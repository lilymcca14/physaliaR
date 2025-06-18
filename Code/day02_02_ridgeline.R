# ridgeline plots
# Code for multitemporal analysis

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)
library(viridis)
library(RStoolbox)
library(colorist)
library(ggridges)

im.list()

# NDVI phenology
# what is ndvi? vegetation is reflecting nir and absorbing red
# 8 bit = 256 potential values from 0 to 255
# nir = 255 ; red = 0
# dvi = difference vegetation index = nir - red = 255 - 0 = 255
# 4 bit = 16 values from 0 to 15
# nir = 15 ; red = 0 
# dvi = nir - red = 15 - 0 = 15
# diff. between 4 bit and 8 bit is huge but proportion is the same
# normalized difference vegetation value: (nir - red)/(nir + red); range from -1 to 1
# 8 bit ndvi = 1, 4 bit ndvi = 1
# ndvi related to biomass of vegetation
ndvi <- im.import("Sentinel2_NDVI_2020")
# ^ imports and plots all the ndvi tifs that start like this 
# (4 of them); 02, 05, 08, 11
# all of them referenced separately and then put in same object
ndvi02 <- im.import("Sentinel2_NDVI_2020-02-21.tif")
ndvi05 <- im.import("Sentinel2_NDVI_2020-05-21.tif")
ndvi08 <- im.import("Sentinel2_NDVI_2020-08-01.tif")
ndvi11 <- im.import("Sentinel2_NDVI_2020-11-27.tif")
ndviA1 <- c(ndvi02, ndvi05, ndvi08, ndvi11)

# need to change the names bc all the ndvis have the 
  # same name so it's being referenced once
names(ndvi) <- c("02_Feb", "05_May", "08_Aug", "11_Nov")
im.ridgeline(ndvi, scale = 2) # now it has four layers!
im.ridgeline(ndvi, scale = 1) # scale = how many lines the graph exists in;
# scale = 1, stay in one layer; scale = 2, overlaps into layer above
im.ridgeline(ndvi, scale = 3, palette = "plasma")

pdf("pathway/title.pdf")
im.ridgeline(ndvi, scale = 3, palette = "plasma")
im.ridgeline(ndvi, scale = 2)
im.ridgeline(ndvi, scale = 1, palette = "mako")
dev.off()




