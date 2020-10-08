library(aqp)
library(soilDB)

# get some lab data for series
x <- fetchKSSL(c("treaty","davidson","cohasset","cecil"),
               returnMorphologicData = TRUE, simplifyColors = TRUE)
f <- x$SPC

# use tibbles internally
aqp_df_class(f) <- "tbl_df"
f <- rebuildSPC(f)

horizons(f)

# lots of warnings
system.time(profileApply(f, estimateSoilDepth))
system.time(profileApply(f, getArgillicBounds))
system.time(profileApply(f, getCambicBounds, clay.attr = "clay"))
system.time(profileApply(f, mollic.thickness.requirement, clay.attr = "clay"))

# remove bad horizon logic
f.sub <- subset(f, checkHzDepthLogic(f)$valid)

# fewer warnings
system.time(profileApply(f.sub, estimateSoilDepth))
system.time(profileApply(f.sub, getArgillicBounds, verbose = TRUE))
system.time(profileApply(f.sub, getCambicBounds, clay.attr = "clay"))
system.time(profileApply(f.sub, mollic.thickness.requirement, clay.attr = "clay"))

# subset to inspect
f.sub.bad <- subset(f.sub, profile_id(f.sub) %in% c(15745,25651,25652,25653))

# look at 'em
plot(f.sub.bad, color = "moist_soil_color", cex.names = 1.2)

profileApply(f.sub.bad, getArgillicBounds, clay.attr = "clay")
