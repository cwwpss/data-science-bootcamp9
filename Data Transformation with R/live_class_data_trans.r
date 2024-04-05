# Data Transformation with R
## library in R => tidyverse, glue, RSQlite, lubridate
## use function install.package() or in package panel
install.package(tidyverse)
library(tidyverse)

## Glue library => glue message same paste()
my_name <- "toy"
my_age <- 35

glue("Hi! myname is {my_name}. Today I'm {my_age} years old.")
paste0("Hello my name is ", my_name, ".")


