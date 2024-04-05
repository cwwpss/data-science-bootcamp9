# Data Visualization with R programming
## using library GGPLOT2
## load library
library(tidyverse) # ggplot2 
library(ggthemes)
## basic syntax
ggplot(data = mtcars,
       mapping = aes(x = mpg)) + #mapping col to chart element
  geom_histogram(bins = 8)

# 1 variable => continuous (number)
## geom_histogram()
ggplot(diamonds,
       aes(x = price)) + 
  geom_histogram()
## geom_density()
ggplot(diamonds,
       aes(x = price)) + 
  geom_density()
## geom_boxplot()
ggplot(diamonds, aes(x = price)) +
  geom_boxplot()

## create ordinal factor
## create ordinal factor
## factor : norminal vs. ordinal
temp <- c("high", "medium", "low", "high")
temp # character factor
class(temp)
temp2 <- factor(temp, 
                level = c("low", "medium", "high"),
                ordered = TRUE) # ordinal factor
temp2
class(temp2)

# DRY : Do not repeat yourself concept
# By assign ggplot to variable
base <- ggplot(diamonds, aes(x = price))
p1 <- base + geom_histogram()
p2 <- base + geom_density()

## Violin plot 2 variable 
ggplot(diamonds, aes(x = price, y = cut)) +
  geom_violin()

# 1 variable => discrete(factor)
## geom_bar => raw data
ggplot(diamonds, aes(cut)) +
  geom_bar()
## geom_col => data ที่ผ่านการ aggregate 
diamonds %>%
  count(cut) %>%
  ggplot(data = ., mapping=aes(x = cut, y = n)) + 
    geom_col()

# 2 variables : number x number
## scatter plot
ggplot(diamonds,
       mapping = aes(x = carat, y = price))
## setting vs mapping
ggplot(diamonds,
       # mapping เอา col ของ dataframe ไป map ที่ element ของ chart
       mapping = aes(x = carat, y = price, color = cut)) +
  # setting ไม่เกี่ยวกับ col แต่เป็นการเปลี่ยนตรงๆเลย => เปลี่ยนกราฟโดยไม่ได้ไปยุ่งกับ data 
  geom_point(alpha = 0.4, size = 2) +
  theme_minimal()
## mapping example
ggplot(diamonds,
       mapping = aes(x = carat, y = price, color = cut)) + # mapping
  geom_point() +
## setting example
ggplot(diamonds,
       mapping = aes(x = carat, y = price, color = cut)) +
  geom_point(alpha = 0.4, size = 2) # setting

# theme
ggplot(diamonds,
       mapping = aes(x = carat, y = price, color = cut)) +
  geom_point(alpha = 0.4, size = 2) +
  theme_minimal()

# sample data for reduce the size of data
ggplot(sample_n(diamonds, 3000),
       mapping = aes(x = carat, y = price, color = cut)) +
  geom_point(alpha = 0.4, size = 2) +
  theme_minimal()

set.seed(42) 
ggplot(sample_n(diamonds, 3000),
       mapping = aes(x = carat, y = price, color = cut)) +
  geom_point(alpha = 0.4, size = 2) +
  theme_minimal()

# label
set.seed(42)
ggplot(sample_n(diamonds, 3000),
       mapping = aes(x = carat, y = price, color = cut)) +
  geom_point(alpha = 0.4, size = 2) +
  theme_minimal() +
  labs(
    title = "My first scatter plot",
    subtitle = "Cool ggplot2",
    caption = "Data diamonds in africa",
    y = "Price in USD",
    x = "Carat Diamonds")

# qplot
## Short cut ⇒ qpot()
## qpot == quick plot

qplot(x = carat, data = diamonds, geom = "density")
qplot(x = carat, data = diamonds, geom = "histogram")
qplot(cut,data = diamonds, geom="bar")

# layer in ggplot2
## layers in ggplot2
base <- ggplot(diamonds %>% sample_n(1000) %>%
               filter(carat <= 2.8),
               aes(x = carat, y = price))

p3 <- base + 
  theme_minimal() +
  geom_point(alpha = 0.3, color = "blue") +
	  geom_smooth(method = "loess", se = TRUE, 
							fill = "gold", 
              color = "red") +
## Bar plot with layer 
### fill => fill the color into bar
ggplot(diamonds, aes(cut, fill = cut)) +
  geom_bar() +
  theme_minimal()
## stack bar chart
ggplot(diamonds, aes(cut, fill = clarity)) +
  geom_bar() +
  theme_minimal()
## position in bar chart
ggplot(diamonds, aes(cut, fill = clarity)) +
  geom_bar(position="fill") +
  theme_minimal()

# how to change color in ggplot
## scale_fill_manual() => manual change
## scale_fill_brewer() => pattern color
ggplot(diamonds, aes(cut, fill = cut)) +
  geom_bar() +
  theme_minimal() +
  scale_fill_brewer(palette = "Accent")
## heat map color scale
## haet map color scale ถ้า map color ไปที่ตัวแปรตัวเลขมันจะเป็น color scale(heatmap)
ggplot(diamonds %>%
         sample_frac(0.1), aes(carat, price, color = price)) +
  geom_point(alpha = 0.3) +
  theme_minimal() +
  scale_color_gradient(low = "gold", high = "purple") ## gradient use with heatmap

# multiple sub-plots (facet)
## add another 1 layer => facet_wrap()
ggplot(diamonds %>% sample_frac(0.2),
       aes(carat, price)) +
  geom_point(alpha = 0.2) +
  geom_smooth() +
  theme_minimal() +
  facet_wrap(~cut, ncol = 3)
## warp in to x, y axis (x cross y)
ggplot(diamonds %>% sample_frac(0.2),
       aes(carat, price)) +
  geom_point(alpha = 0.2) +
  geom_smooth() +
  theme_minimal() +
  facet_wrap(clarity ~ cut)
## facet_grid()
ggplot(diamonds %>% sample_frac(0.2),
       aes(carat, price)) +
  geom_point(alpha = 0.2, size = 2, color = "red") +
  geom_smooth(method = "lm", color = "black") +
  theme_minimal() +
  facet_grid(~cut)

# multiple dataframes with data viz
m1 <- mtcars %>% filter(mpg > 30)
m2 <- mtcars %>% filter(mpg <= 20)

#create chart with multiple df
ggplot() + #เปิด ggplot ไว้โล่งๆ
theme_minimal() +
geom_point(data = m1, aes(wt, mpg), color  = "blue") + #map df1
geom_point(data = m2, aes(wt, mpg), color = "red") # map df2

# geom_bin2D
## มีไว้ช่วยลดเวลาการ render scatter plot ที่data เยอะเกินไป
ggplot(diamonds, aes(carat, price)) +
  geom_bin2d(bins = 100)

# library(patchwork)
# arrange multiple chart in 1 picture
library(patchwork)

p1 <- qplot(hwy, data = mpg, geom = "density")
p2 <- qplot(cty, data = mpg, geom = "histogram")
p3 <- qplot(cty, hwy, data = mpg, geom = "point")
p4 <- qplot(cty, hwy, data = mpg, geom = "smooth")

p1 + p2 + p3 + p4 #patwork ลง library แล้วเอา chart มาใส่หน้าเดียวกัน
(p1 + p2 + p3) / p4
p1 / (p2 + p3 + p4)
