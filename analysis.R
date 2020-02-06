# Surface geometry and biodiversity
source("R/functions.R")

# Scope (extent), scales of variation, and resolution (grain)
L <- 2 # Scope, 2 by 2 m reef patches
scl <- L / c(1, 2, 4, 8, 16, 32) # Scales, aim for 2 orders magnitude
L0 <- min(scl) # Grain, resolution of processing ~ 6 cm

source("R/process_trimodal.R")
