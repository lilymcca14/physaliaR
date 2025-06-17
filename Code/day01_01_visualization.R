# code to visualize RS data, spatial data and matrices

install.packages("devtools")
#install_github("ducciorocchini/imageRy") # didn't work
devtools::install_github("ducciorocchini/imageRy")

library(terra)
library(imageRy)
library(viridis)

# Listing data inside imageRy
im.list()

# Sentinel-2 bands
# https://gisgeography.com/sentinel-2-bands-combinations/

# importing the data
b2 <- im.import("sentinel.dolomites.b2.tif") 
# sentinel-2 is a satellite with a resolution of 10 m 
# 490nm wavelength (blue)
# reflection: yellow
# absorption: blue

# cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
# plot(b2, col=cl)

# Exercise: import b3 and plot it with the previous palette
b3 <- im.import("sentinel.dolomites.b3.tif")
# green light, 560 (vegetation reflects green?)
# plot(b3, col=cl)

# Importing the red band
b4 <- im.import("sentinel.dolomites.b4.tif")
# red light, 665
# reflectance of objects in red band
# plot(b4, col=cl)

# Importing the NIR band (near infrared)
b8 <- im.import("sentinel.dolomites.b8.tif")
# 842; vegetation is reflecting a lot?
# high reflectance in healthy leaves
# plot(b8, col=cl)

# Multiframe presentation of plots 
par(mfrow = c(2,2))
par(mfrow = c(1,4)) # elements of an array
plot(b2)
plot(b3)
plot(b4)
plot(b8)

# for the black and white versions
#plot(b2, col=cl)
#plot(b3, col=cl)
#plot(b4, col=cl)
#plot(b8, col=cl)

# stack all of the data together
sentstack <- c(b2, b3, b4, b8)
plot(sentstack) # creating one object that 
                # includes all the band rasters
ncell(sentstack) # number of cells PER LAYER
# color version
plot(sentstack, col = magma(100)) # 100 is the number of colors (3 = 3 classes)

# b2 = blue - 1
# b3 = green - 2 
# b4 = red - 3
# b8 = nir - 4
plotRGB(sentstack, r = 3, g = 2, b = 1, stretch = 'lin') # linear stretching
plotRGB(sentstack, r = 4, g = 3, b = 2, stretch = 'lin') # fun experimentation
    # everything is that is reflecting nir will become red
    # where there is red, there is high reflectance of nir
    # false color image; a scheme using a color we cannot actually see
    # water completely absorbs nir?
plotRGB(sentstack, r = 3, g = 4, b = 2, stretch = 'lin')
plotRGB(sentstack, r = 3, g = 2, b = 4, stretch = 'lin')
   
# deforestation with bare soil
pairs(sentstack) # correlation
