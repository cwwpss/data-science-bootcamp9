# Data transformation with R Project
## Homework - 01 transform nycflights13
# load library
library(tidyverse)
library(nycflights13)

# load data
data("flights")
data("airports")
data("airlines")

# pre-view data
glimpse(flights)

# Q.1 the most arrival destination.
flights %>%
  left_join(
    airports, 
    by = c("dest" = "faa")) %>%
  select(dest, name) %>%
  group_by(dest, name) %>%
  summarize(number_dest = n()) %>%
  arrange(desc(number_dest)) %>%
  head(1)

# Q.2 destination that spent the most of amount time.
flights %>%
  left_join(
    airports, 
    by = c("dest" = "faa")
    ) %>%
  left_join(
    airports,
    by = c("origin" = "faa"),
    suffix = c(".dest", ".ori")
    ) %>%
  select(origin ,name.ori, dest, name.dest, air_time) %>%
  group_by(origin, dest) %>%
    arrange(desc(air_time)) %>%
  head(1)

# Q.3 top 10 departure delayed in 2nd month of 2013
flights %>%
  filter(month == 2) %>%
  left_join(airlines, by = c("carrier")) %>%
  select(name, dep_delay) %>%
  group_by(name) %>%
  arrange(desc(dep_delay)) %>%
  head(10)
  
# Q.4 top 10 time that fly in NOV and DEC of 2013
flights %>%
  select(time_hour) %>%
  mutate(
    hour = hour(time_hour),
    min = minute(time_hour),
    sec = second(time_hour)
    ) %>%
  mutate(times = paste(hour, min, sec, sep = ":")) %>%
  select(times) %>%
  group_by(times) %>%
  summarise(count_time = n()) %>%
  head(10)

# Q.5 top 5 arrival to destination 
flights %>%
  left_join(
    airports, 
    by = c("origin" = "faa")
  ) %>%
  left_join(
    airports,
    by = c("dest" = "faa"),
    suffix = c(".ori", ".dest")
  ) %>% 
  group_by(name.ori, name.dest) %>%
  summarise(times_arrival = n()) %>%
  arrange(desc(times_arrival)) %>%
  head(5)

## Homework - 02 R connect PostgreSQL
# load library
library(RPostgreSQL)
library(sqldf)
library(tidyverse)

# connect SQL sever
con <- dbConnect(
  PostgreSQL(),
  host = "arjuna.db.elephantsql.com",
  dbname = "qvuviyss",
  user = "qvuviyss",
  password = "g3fC5VuLRNxp8iKhTiKsloVFXhq8A7vX",
  port = 5432
)

# list table
dbListTables(con)

# create df csv
customers <- read_csv("customers.csv")

menus <- read_csv("menus.csv")

orders <- read_csv("orders.csv")

payment_method <- tribble(
  ~method_id, ~method_name,
  1, "Cash",
  2, "Mobile Bank",
  3, "Credit card",
  4, "Wallet"
)

staffs <- tribble(
  ~staffs_id, ~name, ~lastname, ~gender,
  1, "David", "Beckham", 40,
  2, "John", "Smith", 25,
  3, "Jame", "Coner", 32,
  4, "Alisa", "Gen", 20
)

# Write table into db
dbWriteTable(con, "customers", customers)

dbWriteTable(con, "menus", menus)

dbWriteTable(con, "orders", orders)

dbWriteTable(con, "payment_method", payment_method)

dbWriteTable(con, "staffs", staffs)

# Query data
df <- dbGetQuery(con, "select * from customers")
glimpse(df)
