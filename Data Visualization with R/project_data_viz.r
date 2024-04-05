# Project Data Visualization with R programming

## load library
library(tidyverse)
library(patchwork)

data("mpg")

## Explore data
glimpse(mpg)

# chart 1 compare type of car in each year 1999 and 2008
mpg %>%
  group_by(class) %>%
  summarize(total_car = n()) %>%
  ggplot(data = ., aes(x = reorder(class, -total_car), y = total_car, fill = -total_car)) +
    geom_col() +
    theme_minimal() +
    labs(
      title = "Total Car in Each Class",
      x = "class",
      y = "Vehicle count"
      )

mpg %>%
  ggplot(aes(fct_infreq(class), fill = class)) +
  geom_bar(alpha = 0.8) +
  scale_color_brewer("Set2")

# Chart 2 trend between engine displacement and city&highway mpg
c1 <- mpg %>%
  ggplot(aes(displ, hwy)) +
  geom_point() +
  geom_smooth(
    method = "lm"
  ) +
  theme_minimal()

c2 <- mpg %>%
  ggplot(aes(displ, cty)) +
  geom_point() +
  geom_smooth(
    method = "lm"
  ) +
  theme_minimal()

c1 + c2

# Chart 3 Compare total car for each manufacturing
ggplot(mpg, mapping = aes(fct_rev(fct_infreq(manufacturer)))) +
  geom_bar() +
  coord_flip() +
  theme_minimal()

# Chart 4 distribution regrad to the fl and mile per gallon
cty_data <- mpg %>%
  select(fl, cty)

hwy_data <- mpg %>%
  select(fl, hwy)

boxplot_cty <- cty_data %>%
  ggplot(aes(cty, fl)) +
  geom_boxplot() +
  theme_minimal()

histrogram_cty <- cty_data %>%
ggplot(aes(cty)) +
  geom_histogram(bins = 15) +
  theme_minimal()

boxplot_hwy <- hwy_data %>%
  ggplot(aes(hwy, fl)) +
  geom_boxplot() +
  theme_minimal()

histrogram_hwy <- hwy_data %>%
  ggplot(aes(hwy)) +
  geom_histogram(bins = 10) +
  theme_minimal()

a1 <- ((boxplot_cty + boxplot_hwy) / (histrogram_cty + histrogram_hwy))
a1

# Chart 5 the transmission and drv in each manafacturer in 1999 and 2008
mpg_2008 <- mpg %>%
  filter(year == 2008)

mpg_1999<- mpg %>%
  filter(year == 1999)

trans_2008 <- mpg_2008 %>%
  ggplot(aes(manufacturer, fill = trans)) +
  geom_bar(position = "fill") +
  theme_minimal()

drv_2008 <- mpg_2008 %>%
  ggplot(aes(manufacturer, fill = drv)) +
  geom_bar(position = "fill") +
  theme_minimal()

trans_1999 <- mpg_1999 %>%
  ggplot(aes(manufacturer, fill = trans)) +
  geom_bar(position = "fill") +
  theme_minimal()

drv_1999 <- mpg_1999 %>%
  ggplot(aes(manufacturer, fill = drv)) +
  geom_bar(position = "fill") +
  theme_minimal()

trans_1999/trans_2008
drv_1999/drv_2008
