# Reef record test
output <- "trimodal"

# Load geotif
data <- raster("data/trimodal/trimodal3set_photoscan_2chunk_DEM_7mm_proj_clip.tif")
# These are midpoints for 2x2m squares, which are our "patch"-level samples
mids <- readOGR("data/trimodal/trimodal_patch_grid_midpnts.shp")
# These are the annotated coral colonies, ID'ed to species level
anno <- readOGR("data/trimodal/trimodal_ann_aligned_cleaned.shp")

# plot(data)
# rect(mids$x-1, mids$y-1, mids$x+1, mids$y+1, border="white")
# points(anno, col=rgb(1, 0, 0, 0.2), cex=0.1)

for (mid in 1:length(mids)) {
  rep <- mid
  # Get lower corner of 2x2m bounding box; alternatively, prescribe these values some other way.
  x0 <- mids@data$x[mid] - L/2
  y0 <- mids@data$y[mid] - L/2

  height_variation() # Calulate height variation at different scales for quadrat, and save
}

# Iterate through records and reps, calculate RDH, and store results
store <- data.frame()

for (mid in 1:length(mids)) {
  temp <- read.csv(paste0("output/trimodal/var_", names(data), "_", sprintf("%04d", mid), ".csv"), as.is=TRUE)
  # Calculate rugosit, fractal dimension and height range (rdh function)
  store <- rbind(store, data.frame(rec=names(data), rep=mid, rdh(temp)))
}
write.csv(store, "output/trimodal.csv", row.names=FALSE)


### BIODIVERSITY
store <- read.csv("output/trimodal.csv", as.is=TRUE)

for (mid in 1:length(mids)) {

  # Get lower corner of 2x2m bounding box; alternatively, prescribe these values some other way.
  x0 <- mids@data$x[mid] - L/2
  y0 <- mids@data$y[mid] - L/2
  
  tax <- crop(anno, extent(x0, x0 + 2, y0, y0 + 2))
  # points(tax, pch=20, cex=0.3)
  spp <- length(unique(tax$Species))
  abd <- length(tax$Species)

  store <- rbind(store, data.frame(mid=mid, D, D_ends, D_theory, R, R_theory, H, H_min=min(rr), H_max=max(rr), spp, abd, spp0, abd0))
  print(mid)
}

write.csv(store, "output/trimodal0.csv", row.names=FALSE)


# 
# 
# dat <- read.csv("output/trimodal.csv", as.is=TRUE)
# # hist(dat$mid[dat$H <= 2])
# plot(data)
# # points(mids)
# points(mids[dat$mid[dat$D < 2],], col="black", pch=20)
# points(mids[dat$mid[dat$H > 2],], col="red")
# rect(mids$x-1, mids$y-1, mids$x+1, mids$y+1)
# points(mids[dat$mid,], col="red", pch=2)
# 
# points(mids[dat$mid==239,], col="red", pch=2)
# 
# 
# par(mfrow=c(2, 2))
# 
# 
# plot(D ~ D_theory, dat, asp=1, main="D_theory1 uses R calculated\nfrom theory")
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

