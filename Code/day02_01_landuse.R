# how to handle landuse (change) in R
# quantify difference between images

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

im.list()

mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")
#mato1992 = flip(mato1992) 
# exactly what it looks like: flips the image 180º
plot(mato1992)

set.seed(42)
mato1992c = im.classify(mato1992, num_clusters = 2) # just like gis classify
# class 1 = forest
# class 2 = human-altered/water

mato2006 = im.import("matogrosso_ast_2006209_lrg.jpg")
#mato2006 = flip(mato2006)
plot(mato2006)

set.seed(42)
mato2006c = im.classify(mato2006, num_clusters = 2)
# class 1 = human-altered/water
# class 2 = forest
# the classes switched... how do i change that?
# maybe i can assign new colors to both of these

f1992 <- freq(mato1992c) # frequency of each class
f1992*100/ncell(mato1992c) # percentage of each class
# forest = 83%
# human = 17%

f2006 <- freq(mato2006c)
f2006*100/ncell(mato2006c)
# human = 55%
# forest = 45%

# Creating dataframe

class = c("Forest","Human")
y1992 = c(83,17)
y2006 = c(45,55)
tabout = data.frame(class, y1992, y2006)

# 1992
p1 <- ggRGB(mato1992, 1, 2, 3, stretch = 'lin') + ggtitle("Raster image 1992")
p2 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + 
  geom_bar(stat="identity", fill="white") + ggtitle("Land use in 1992") +
  ylim(c(0,100)) # c works but so does just listing the numbers (see p4)
p1 + p2

# 2006
p3 <- ggRGB(mato2006, 1, 2, 3, stretch = 'lin') + ggtitle("Raster image 2006")
p4 <-  ggplot(tabout, aes(x=class, y=y2006, color=class)) + 
  geom_bar(stat="identity", fill="white") + ggtitle("Land use in 2006") +
  ylim(0,100)
p3 + p4

##### other iterations/visualizations

p2 + p4 # both bar graphs

(p1 | p2) / (p3 | p4) # image | graph / image | graph
(p1 | p3) / (p2 | p4) # image | image / graph | graph

pdf("pathway/title.pdf")
(p1 | p3) / (p2 | p4)
dev.off()

