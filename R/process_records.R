# Reef record test
source("R/functions.R")
output <- "record"

# Reef records
files <- dir("data/records")
files <- unique(gsub("\\.tfw|\\.tif", "", files))

for (rec in files) {
  # Load geotif for reef record
  data <- raster(paste0("data/records/", rec, ".tif"))
  # Get lower corner of 8x8m bounding box; alternatively, prescribe these values.
  xb <- mean(data@extent[1:2]) - 4
  yb <- mean(data@extent[3:4]) - 4

  # Iterate through  2x2m quadrats (reps = 16) in reef record
  rep <- 1
  for (i in c(0, 2, 4, 6)) {
    for (j in c(0, 2, 4, 6)) {
      x0 <- xb + i
      y0 <- yb + j
      height_variation() # Calulate height variation at different scales for quadrat, and save
      rep <- rep + 1
    }
  }
}

# Iterate through records and reps, calculate RDH, and store results
store <- data.frame()

for (rec in files) {
  for (rep in 1:16) {
    temp <- read.csv(paste0("output/variation/var_", names(data), "_", sprintf("%04d", rep), ".csv"), as.is=TRUE)
    # Calculate rugosity, fractal dimension and height range (rdh)
    store <- rbind(store, data.frame(rec=rec, rep=rep, rdh(temp)))
  }
}
write.csv(store, paste0("output/record.csv"), row.names=FALSE)

# 
# dat <- read.csv("output/record.csv", as.is=TRUE)
# 
# 
# par(mfrow=c(2, 2))
# 
# plot(D ~ D_theory, store, asp=1, main="D_theory1 uses R calculated\nfrom theory")
# abline(0, 1)
# 
# hist(store$D_theory - store$D, breaks=50)
# abline(v=0, lty=2, col="red")
# 
# plot(D ~ D_theory2, store, asp=1, main="D_theory2 from R calculated\nwith DEM function")
# abline(0, 1)
# 
# plot(R ~ R_theory, store, asp=1, main="R DEM function vs.\nR calculated from theory")
# abline(0, 1)
# 
# # write.csv(store, paste0("output/master.csv"), row.names=FALSE)
# 
# # REEF RECORD DATA
# 
# dat <- read.csv("output/store2.csv", as.is=TRUE)
# dat$obs <- 1:16
# 
# dat$site[dat$rec=="rr201611_004_Osprey_dem_low"] <- "Osprey"
# dat$site[dat$rec=="rr201611_007_CooksPath_dem_low"] <- "Cooks Path"
# dat$site[dat$rec=="rr201611_018_Resort_dem_low"] <- "Resort"
# dat$site[dat$rec=="rr201611_023_NorthReef03_dem_low"] <- "Mermaid Cove"
# dat$site[dat$rec=="rr201611_033_ConerBeach_dem_low"] <- "Corner Beach"
# dat$site[dat$rec=="rr201611_037_southeast_dem_low"] <- "Southeast"
# dat$site[dat$rec=="rr201611_039_EasterPoint_dem_low"] <- "Easter Point"
# dat$site[dat$rec=="rr201611_040_NoMansLand_dem_low"] <- "No Mans Land"
# dat$site[dat$rec=="rr201611_041_NorthOfParadise_dem_low"] <- "North of Paradise"
# dat$site[dat$rec=="rr201611_042_GnarlyTree_dem_low"] <- "Gnarly Tree"
# dat$site[dat$rec=="rr201611_046_NorthReef02_dem_low"] <- "North Reef 2"
# dat$site[dat$rec=="rr201611_050_horsehoe_DEM_low"] <- "Horseshoe"
# dat$site[dat$rec=="rr201611_051_Vickis_dem_low"] <- "Vickis"
# dat$site[dat$rec=="rr201611_052_SouthIsland_dem_low"] <- "South Island"
# dat$site[dat$rec=="rr201611_053_Trimodal_dem_low"] <- "Trimodal"
# dat$site[dat$rec=="rr201611_054_lagoon02_dem_low"] <- "Lagoon 2"
# dat$site[dat$rec=="rr201611_055_Lagoon01_dem_low"] <- "Lagoon 1"
# dat$site[dat$rec=="rr201611_055_LizardHead_dem_low"] <- "Lizard Head"
# dat$site[dat$rec=="rr201611_056_TurtleBeach_dem_low"] <- "Turtle Beach"
# dat$site[dat$rec=="rr201611_045_WashingMachine_dem_low"] <- "Washing Machine"
# dat$site[dat$rec=="rr201611_049_NorthReef01_dem_low"] <- "North Reef 1"
# 
# bio <- read.csv("data/2016_metrics_dataset_dama_june_HIMB.csv", as.is=TRUE)[c("site", "obs", "tx", "abd")]
# dat <- merge(dat, bio, by=c("site", "obs"))
# 
# dat$R_log10 <- log10(dat$R_theory)
# dat$HL0_log10 <- log10(dat$H / L0)
# dat$D_sq <- dat$D^2
# dat$R_log10_sq <- dat$R_log10^2
# dat$HL0_log10_sq <- dat$HL0_log10^2
# 
# dat$abd_sqrt <- sqrt(dat$abd)
# dat$tx_sqrt <- sqrt(dat$spp)

