# A geometric basis for surface habitat complexity and biodiversity

This GitHub repository provides code for the research posted currently at [bioRxiv](https://www.biorxiv.org/content/10.1101/2020.02.03.929521v1).

### Example of using code

There `analysis.R` code contains an example of how the code is used at the top. There are essentially three steps:

1. Select the size of the patch for your calculations (`L`)
2. Select the scales across which fractal dimension will be calculated (`scl`), the smallest scale automatically is the resolution (`L0`)
3. Load a DEM file as `data` (geotif)
4. Pick the bottom left point of the patch (`x0` and `y0`)
5. Run the `height_variation()` function, which is essentially a wrapper function (see `R/functions.R`). This function only requires the variables mentioned so far (`L`, `scl`, `L0`, `data`, `x0` and `y0`), so make sure there's assigned.  The output of the `height_variation()` function is the DEM height range the prescribed scales. For the largest scale `H` (or 2x2m) there is only one value for the entire patch, and the next scale down (1x1m) there are four values, and so on. Best to assign the output to a variable and save it somewhere (see the Example), because the smallest scales are very time-consuming.
6. Calculate the surface descriptor metrics using the `rdh()` function. This function only requires the output from `height_variation()`. `rdh()` sends back a list with several metrics:

Variable | Description
--- | ---
D | Fractal dimension from model fit
D_ends | Fractal dimension only considering the largest (L) and smallest (L0) scale
D_theory | Fractal dimension calculated from theory (i.e., from R and H)
R_theory | Surface rugosity calculated from theory ()
H | The height range (or height range at L)

### Reef records data

### Trimodal data
