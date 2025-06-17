# Code

In this folder, we are going to put the code we use in this course.

> The code in this folder has been developed by all participants in the course.

Image obtained with day 01 code!
+ The code:
``` r
p5 <- ggRGB(mato1992, r=2, g=1, b=3, stretch = 'lin')
p6 <- ggRGB(mato1992, r=2, g=1, b=3, stretch = 'hist') # stretching mean values with greater slope
p7 <- ggRGB(mato2006, r=2, g=1, b=3, stretch = "lin")
p8 <- ggRGB(mato2006, r=2, g=1, b=3, stretch = "hist")

(p5 | p6) / (p7 | p8)
```
+ The image:
  
  <img width="929" alt="Screenshot 2025-06-17 at 11 58 06 AM" src="https://github.com/user-attachments/assets/48165eb2-9bfc-41e5-8fe7-8480ab589bfd" />
