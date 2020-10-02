library(aqp)

# load Region 2 NASIS pedons (n=31573; ~87MB uncompressed);
#  thanks @smroecker; using soilDB::fetchNASIS(from='pedon_report')
load("E:/r02_pedons.RData")
# aqp_df_class(r02_pedons) <- "data.table"
# r02_pedons <- rebuildSPC(r02_pedons)
# save(r02_pedons, file = "E:/r02_pedons.RData")
hzdesgnname(r02_pedons) <- "hzname"
hztexclname(r02_pedons) <- "texcl"
horizonDepths(r02_pedons)

# calculate minimum mollic/umbric thickness requirement
res <- profileApply(r02_pedons, mollic.thickness.requirement, clay.attr = "claytotest")


# create a histogram
hist(res, breaks = round(max(res, na.rm=T) - min(res, na.rm=T)), ylim=c(0,25000),
     xlab = "Minimum Thickness of Mollic Epipedon, cm",
     main= "Mollic Thickness Requirement\nin Pacific Soil Survey Region NASIS Pedons (n = 31,573)")

# classify based on criterion used
clazz <- rep(NA, length(res))
clazz[res == 25] <- "6a"
clazz[res == 18] <- "6d"
clazz[res == 10] <- "6b"
clazz[res > 18 & res < 25] <- "6c" # we only consider it 6c if it "matters" i.e. changes value
clazz[is.na(res)] <- "cannot calculate"

out <- cbind(table(clazz, useNA = "always"), data.frame(total = length(res)))
out$prop <- out$Freq / out$total
out[order(out$Freq, decreasing = T),]
plot(res ~ factor(clazz), ylab="Thickness, cm",xlab="Mollic Thickness Criterion")

s <- r02_pedons[1:1000,]


# example graphic
par(mar=c(0,0,1,1))
s$mollicthk <- profileApply(s, mollic.thickness.requirement, clay.attr = "claytotest")
s.sub <- combine(list(filter(s, mollicthk == 25)[100],
                      filter(s, mollicthk == 18)[10],
                      filter(s, mollicthk > 18 & mollicthk < 23)[12]))
s.sub$criteria <- c("18 cm Requirement", "Between 18 and 25 cm\nRequirement", "25 cm Requirement")
hzdesgnname(s.sub) <- "hzname"
s.sub@horizons$hzdepb[s.sub[[hzdesgnname(s.sub)]] == "R"] <- 200

pscs <- profileApply(s.sub, function(p) {
  return(data.frame(profile_id(p), 'particle size control section', t(estimatePSCS(p))))
}, frameify=TRUE, column.names = c("peiid","featkind","top","bottom"))

mollic <- profileApply(s.sub, function(p) {
  return(data.frame(profile_id(p), 'minimum mollic/umbric thickness', t(c(0, p$mollicthk))))
}, frameify=TRUE, column.names = c("peiid","featkind","top","bottom"))

diagnostic_hz(s.sub) <- rbind(pscs, mollic)

save(s.sub, file="../Expanding the Toolkit for Soil Scientists/mollicthk.Rda")
plotSPC(s.sub, label = "criteria", axis.line.offset = -3.5, cex.names = 0.9, id.style = "top",
        name.style = "left-center")
addDiagnosticBracket(s.sub, kind = 'particle size control section', lwd=3)
addDiagnosticBracket(s.sub, kind = 'minimum mollic/umbric thickness', lwd=3,
                     offset=0, tick.length=0, col="green")
abline(h=c(18+0.5,25+0.5,54+0.5,75+0.5), lty=2)

#mtext("aqp calculated\nMollic/Umbric Minimum Thickness Requirement\n& Particle Size Control Section Boundaries", 3)
legend("bottomleft", c("particle size control section",
                       "minimum mollic/umbric thickness",
                       "absolute depths: 18, 25, 54, 75 cm"), lwd=c(3,3,1), lty=c(1,1,2),
       col=c("black","green","blue","black"))

