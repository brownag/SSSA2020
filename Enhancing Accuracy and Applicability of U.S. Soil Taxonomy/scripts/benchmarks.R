library(aqp)
library(soilDB)
library(tibble)

f <- fetchKSSL(c("davidson","cecil","chewacla"),
               #c("fayette","tama","downs"), 
                 returnMorphologicData = TRUE,
                 returnGeochemicalData = TRUE,
                 simplifyColors = TRUE)
save(f, file =  "udic.Rda")
load("udic.Rda")

aqp_df_class(f$SPC) <- "data.table"
f$SPC <- rebuildSPC(f$SPC)

soildepth <- profileApply(f$SPC, function(p) {
  
  return(tibble(getSoilDepthClass(p)))
  
}, frameify = TRUE)

head(soildepth)

argillic <- profileApply(f$SPC, function(p) {
  
  cargi <- t(getArgillicBounds(p))
  
  return(tibble(pedon_key = profile_id(p), 
                featdept = cargi[1], 
                featdepb = cargi[2]))
  
}, frameify = TRUE)

mollic <- profileApply(f$SPC, function(p) {
  
  mss <- getMineralSoilSurfaceDepth(p)
  pld <- getPlowLayerDepth(p)
  if(mss == pld) # no surface horizon present
    mss <- 0
  cmolli<- t(c(mss, 
               mss + mollic.thickness.requirement(p, clay.attr = 'clay')))
  
  return(tibble(pedon_key = profile_id(p), 
                featdept = cmolli[1], 
                featdepb = cmolli[2]))
  
}, frameify = TRUE)

mollic$featkind <- "mollic calculated"
argillic$featkind <- "argillic calculated"

diagnostic_hz(f$SPC) <- rbind(mollic, argillic)
f$SPC$taxonname <- toupper(f$SPC$taxonname)

f$SPC$is_dark <- factor(hasDarkColors(f$SPC, d_value = NA))

groupedProfilePlot(f$SPC[sample(1:40),], groups = "taxonname", color = "is_dark")

addDiagnosticBracket(f$SPC, kind = "mollic calculated")
addDiagnosticBracket(f$SPC, kind = "argillic calculated")

p <- filter(f$SPC, profile_id(f$SPC) == "36404")
