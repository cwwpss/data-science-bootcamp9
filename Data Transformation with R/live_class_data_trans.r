# Data Transformation with R
## library in R => tidyverse, glue, RSQlite, lubridate
## use function install.package() or in package panel
install.packages(tidyverse)
library(tidyverse)

## Glue library => glue message same paste()
my_name <- "toy"
my_age <- 35

glue("Hi! myname is {my_name}. Today I'm {my_age} years old.")
paste0("Hello my name is ", my_name, ".")

## Tidyverse library
### main function => select(), filter(), arrange(), mutate(), summarise(), group by()

### view function => use to view data
view(mtcars) 

### rownames_to_column() => take row name to column name
mtcars <- rownames_to_column(mtcars, "model")

### select()
select(mtcars, 1:5, 11) #ดึง column 1:5 และ 11
select(mtcars, 1, 2, 5, 8)
select(mtcars, model, mpg, hp, wt, 11)
select(mtcars, model, mpg, hp, 11, wt)
select(mtcars, starts_with("a")) # ดึง column ที่เริ่มด้วยตัว a
select(mtcars, ends_with("p")) # ดึง column ที่ลงท้ายด้วยตัว p
select(mtcars, contains("a")) # ดึง column ที่มี a อยู่ข้างในตรงไหนก็ได้
### Select data and assign it to variable
m1 <- select(mtcars, model, mpg, hp, wt, 10)
view(m1)

### %>% pipe operator
# normal select
select(mtcars, model, mpg, hp, wt)
# pipe operator
m2 <- mtcars %>% 
    select(model, mpg, hp, wt) %>%
    filter(hp > 200)

### filter
# filter hp > 200
m2 <- mtcars %>% 
    select(model, mpg, hp, wt) %>%
    filter(hp > 200)
# filter with between()
mtcars %>%
	select(model, mpg, hp, wt, am) %>%
	filter(between(hp, 150, 200))

### arrange => sort data
mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(between(hp, 150, 200)) %>%
  arrange(desc(hp))

m3 <- mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(between(hp, 150, 200)) %>%
  arrange(am, desc(hp))

mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(between(hp, 150, 200)) %>%
  arrange(desc(am), desc(hp))

mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(between(hp, 150, 200)) %>%
  arrange(desc(am), hp)

### Regular expression in R ⇒ function grep() and grepl()
grep("^A", state.name, value = TRUE) # TRUE show position that match to condition
grep("^A", state.name, value = FALSE) # FALSE show value that match to condition
grepl("^A", state.name) #show TRUE or FALSE of condition
# filter with grepl()
mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(grepl("^M", mtcars$model) & hp > 150)

### write_csv() => write dataframe to csv
write_csv(m3, "result.csv")

view(m4)
write_csv(m4, "datayouask.csv") #เวลาwriteไฟล์ต้องใส่นามสกุลไฟล์ด้

### mutate() => create new column
mtcars %>%
  select(model, mpg, hp, wt) %>%
  filter(mpg >=20 ) %>%
  
  mutate(hp_half = hp/2,
         new_col = "datarockie") ## new = something >> call re-cycle 

mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(mpg >=20 ) %>%
  mutate(hp_halve = hp/2,
         am = ifelse(am == 0, "auto", "manual")) ## replace data

mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(mpg >=20 ) %>%
  mutate(hp_halve = hp/2,
         am_label = if_else(am == 0, "auto", "manual")) # if_else() TRUE เลือก auto

### summarize() or summarise()
mtcars %>%
  summarise(avg_mpg = mean(mpg),
            sum_mpg = sum(mpg),
            min_mpg = min(mpg),
            max_hp = max(hp),
            n = n(), ## n = n() count row >> able to use only on summarize 
            med_mpg = median(mpg),
            # spread cal distribution of value
            var_hp = var(hp),
            sd_hp = sd(hp))
## summarize with mutate() & group_by() จับกลุ่มdataframeเพื่อหาค่าสถิติตามกลุ่มที่สนใจ
mtcars %>%
  mutate (am_label = if_else(am == 0, "Auto", "Manual")) %>%
  group_by(am_label) %>% # group_by Run ก่อน summarize()
  summarise(avg_mpg = mean(mpg),
            sum_mpg = sum(mpg),
            min_mpg = min(mpg),
            max_hp = max(hp),
            n = n()) -> m4
### join data
left_join(band_members, band_instruments)
left_join(band_members, band_instruments, by = "name")
inner_join(band_members, band_instruments, by = "name")
full_join(band_members, band_instruments, by = "name")
## use pipe operator in join function
band_members %>%
  mutate(name_upper = toupper(name)) %>%
  left_join(band_instruments, by="name")
## differant name of 2 table, df
band_members %>%
  select(member_name = name, # ชื่อ col ใหม่ = ชื่อ col เก่า
         band_name = band) %>% ## select() สามารถเปลี่ยนชื่อ col ได้
  left_join(band_instruments,
            by = c("member_name" = "name"))

### random sampling
mtcars %>%
  sample_n(2) %>%
  select(model)

mtcars %>%
  sample_n(2) %>%
  pull(model) ##pull == sampling data is vector type

# sampling by %
mtcars %>%
  sample_frac(0.15) %>%
  pull(model)

# sampling by % with summarize
mtcars %>%
  sample_frac(0.20) %>% 
  summarise(avg_hp = mean(hp))

### count
## count
mtcars_01 <- mtcars %>%
  mutate(am = if_else(am == 0, "Auto", 
                      "Manual")) %>%
  count(am)

## เมื่อเราได้จำนวนมาแล้วเราสามารถเปลี่ยนเป็น pct(percentage)
mtcars_01 %>%
mutate(pct = n / sum(n))

## summarize count
mtcars %>%
  mutate(am = if_else(am == 0, "Auto", 
                      "Manual")) %>%
	group_by(am) %>%
	summarize(n = n())

## sqldf packages
install.packages("sqldf")
library("sqldf")

sqldf("select mpg, hp from mtcars
       where hp >= 200")

sqldf("select avg(hp) as mean_hp, max(hp) as max_hp,
      count(*) as count_df from mtcars")

## RSQLite packages
library(RSQLite)
## Connect to sqlite.db file
con <- dbConnect(SQLite(), "Chinook.db")
## list tables
dbListTables(con)
## list field(column)
dbListField(con, "customers") #ต้องใส่ชื่อtable
## Get data from database tables
m1 <- dbGetQuery(con, "select firstname, email from customers where country = 'USA'")
## Create dataframe
product <- tribble(
	~id, ~product_name.
	1, "chocolate",
	2, "pineapple"
	3, "samsung galaxy s23"
)
## Write table to database 
# write table to database
dbWriteTable(con, "products", products) #write table
# view table
dbGetQuery(con, "select * from products")
## Remove table
dbRemoveTable(con, "products")
## close connection
dbDisconnect(con)

## postgresql server connect
## create connection
con <- dbConnect(
	PostgreSQL(),
	host = "floppy.db.elephantsql.com", ## same IP-address
	dbname = "sefnxxps",
	user = "sefnxxps", ##ชื่อเดียวกันกับ dbname แต่ในการทำงานจริงอาจจะไม่
	password = "A0xt9Fs9GO2Gbl-hfxJOecG_5EXqxM4Y", # ในชีวิตจริงอย่าเปิด pass ให้คนอื่นเห็น
	port = 5432 #port ที่ postgreSQL จองไว้คือ 5432 ถ้าเราไม่เปลี่ยนมัน
)
## db list Tables
dbListTables(con)
products <- tribble(
  ~id, ~product_name,
  1, "Chocolate",
  2, "pineapple",
  3, "samsung galaxy S23")
dbWriteTable(con, "products", products)
## get data
df <- dbGetQuery(con, "select id, product_name from products")

