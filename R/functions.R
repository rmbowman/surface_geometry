# Functions

library(raster)
library(parallel)
library(rgdal)
# library(lme4)
# library(MuMIn)
# library(plot3D)
# library(sgeostat)
# library(mgcv)
# library(jpeg)
# library(rgeos)

# Function for calculating variation in windows
fd_func <- function(x, y, s) {
  bx <- extent(cbind(c(x0 + x, y0 + y), c(x0 + x + s, y0 + y + s)))
  return(diff(range(getValues(crop(data, bx)), na.rm=TRUE)))
}

R_func <- function(H0, L0) {
  sqrt((H0^2) / (2 * L0^2) + 1)
}
# 
# H0_func <- function(R, L0) {
#   sqrt(L0^2 * 2 * (R^2 - 1))
# }
# 
D_func <- function(H, R, L, L0) {
  3 - log10(H / (sqrt(2) * L0 * sqrt(R^2 - 1))) / log10(L / L0)
}
# 
# HL0_func <- function(D, R, L, L0) {
#   (3 - D) * log10(L/L0) + 0.5 * log10(R^2 - 1)
# }
# 
# A0 <- function(H0, L0) {
#   L0 * 0.5 * sqrt(2 * H0^2 + 4 * L0^2)
# }

# Main functions

height_variation <- function(write=TRUE, return=FALSE) {

  # Fractal dimension, D
  temp <- data.frame()
  for (s in scl) {
    inc <- seq(0, L-s, s)
    x <- rep(inc, L/s)
    y <- rep(inc, each=L/s)
    # If you can't get multicore working, change "mcmapply" to "mapply" below:
    temp <- rbind(temp, data.frame(L0=s, x=x, y=y, H0=mcmapply(fd_func, x, y, s)))
  }
  # This variation method is time-consuming, and so save the result to avoid reprocessing if recalculting RDH
  if (write) {
    write.csv(temp, paste0("output/", output, "/var_", names(data), "_", sprintf("%04d", rep), ".csv"), row.names=FALSE)
  }
  print(paste0("Complete: ", names(data), "_", sprintf("%04d", rep)))
  # You can return the data and assign to variable if wish
  if (return) {
    return(temp)
  }
}

rdh <- function(height_variation) {
  # log10 transform
  height_variation$H0 <- log10(height_variation$H0)
  height_variation$L0 <- log10(height_variation$L0)
  # plot(H0 ~ L0, height_variation)
  # Mean of scales to avoid biased sampling at smaller scales
  height_variation_m <- aggregate(H0 ~ L0, height_variation, mean)
  # points(H0 ~ L0, height_variation_m, col="red")
  
  # Find the height ranges at both ends of the scale
  H <- 10^height_variation_m$H0[height_variation_m$L0==log10(L)]
  H0 <- 10^height_variation_m$H0[height_variation_m$L0==log10(L0)]

  # Re-centering, probably unnessary
  height_variation_m$H0 <- height_variation_m$H0 - height_variation_m$H0[height_variation_m$L0==log10(L)]
  height_variation_m$L0 <- height_variation_m$L0 - log10(L)

  # Calculate slopes and minus from 3 (i.e., to get D from S)
  mod <- lm(H0 ~ L0, height_variation_m)
  D <- 3 - coef(mod)[2]
  mod_ends <- lm(H0 ~ L0, height_variation_m[c(1, nrow(height_variation_m)),])
  D_ends <- 3 - coef(mod_ends)[2]

  # Calculate rugosity from theory
  R_theory <- R_func(H0, L0)		

  # Optional test: calculating R using another method
  # temp3 <- crop(data, extent(x0, x0 + L, y0, y0 + L))
  # temp3 <- as(temp3, 'SpatialGridDataFrame')
  # R <- surfaceArea(temp3) / L^2
  
  # Calcualte D from theory
  D_theory <- D_func(H, R_theory, L, L0)

  return(list(D=D, D_ends=D_ends, D_theory=D_theory, R_theory=R_theory, H=H))
}
