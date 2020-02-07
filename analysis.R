# Surface geometry and biodiversity
source("R/functions.R")

# Scope (extent), scales of variation, and resolution (grain)
L <- 2 # Scope, 2 by 2 m reef patches
scl <- L / c(1, 2, 4, 8, 16, 32) # Scales, aim for 2 orders magnitude
L0 <- min(scl) # Grain, resolution of processing ~ 6 cm

# Example surface (an 8x8m section of Horseshoe from Lizard Island)

# Load example geotif
data <- raster("data/example/horseshoe.tif")
plot(data)

rep <- 1
# Choose patch in which to calculate RDH (rugosity, fractal D and height range).
x0 <- data@extent[1]
y0 <- data@extent[3]
rect(x0, y0, xb+L, yb+L)

# Calulate height variation at different scales within patch, and save output (because a tie-consuming step)
temp <- height_variation()

# This height_variation method is time-consuming, and so save the result to avoid reprocessing if recalculting RDH for some reason
write.csv(temp, paste0("output/example/var_", names(data), ".csv"), row.names=FALSE)

# Load the file if starting here:
temp <- read.csv(paste0("output/example/var_", names(data), ".csv"), as.is=TRUE)

# Calculate rugosit, fractal dimension and height range (rdh function)
rdh(temp)

