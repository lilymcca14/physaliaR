# visualizing data with ggplot2 
# Code for plotting satellite data with ggplot2

library(terra)
library(imageRy)
library(RStoolbox)
library(patchwork)
library(ggplot2)

# Import the data
im.list()
mato1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") # freely available nasa data

# b1 = NIR
# b2 = red
# b3 = green
# instead of plotRGB, ggRGB in RStoolbox
ggRGB(mato1992, r = 1, g = 2, b = 3)
ggRGB(mato1992, r = 2, g = 1, b = 3) # water not white bc murky/soil
ggRGB(mato1992, r = 2, g = 3, b = 1)

mato2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") # L5 = landsat 5
ggRGB(mato2006, r = 1, g = 2, b = 3) # water seems very polluted
ggRGB(mato2006, r = 2, g = 1, b = 3) 
ggRGB(mato2006, r = 2, g = 3, b = 1)

# plot the two graphs next to each other # patchwork package
# assign plots to objects and perform algebra with them

# from RStoolbox
p1 <- ggRGB(mato1992, r=1, g=2, b=3) + ggtitle("1992 Landsat Data")
p2 <- ggRGB(mato2006, r=1, g=2, b=3) + ggtitle("2006 Landsat Data")

p1 + p2

p3 <- ggRGB(mato1992, r=2, g=1, b=3)
p4 <- ggRGB(mato2006, r=2, g=1, b=3)

# p1 and p2 plots above p3 and p4 plots
(p1 | p2) / (p3 | p4)

# stretching?
p5 <- ggRGB(mato1992, r=2, g=1, b=3, stretch = 'lin')
p6 <- ggRGB(mato1992, r=2, g=1, b=3, stretch = 'hist') # stretching mean values with greater slope
p7 <- ggRGB(mato2006, r=2, g=1, b=3, stretch = "lin")
p8 <- ggRGB(mato2006, r=2, g=1, b=3, stretch = "hist")

(p5 | p6) / (p7 | p8)
(p5 | p7) / (p6 | p8)

#run next three lines at the same time
pdf("/Users/lilymccarthy/Desktop/r/physaliaTidyverseLandsat.pdf")
(p5 | p6) / (p7 | p8)
dev.off()
