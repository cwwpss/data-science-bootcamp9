# R programming foundation
## Comment in R using -> #
print("hello world")
print("I am learning R programming")

## 5 Topic for Programming Foundation\
## Variable
income <- 35000
expense <- 25000

saving <- income - expense

print(saving)

##  assign variable use -> or <- or =
my_name <- "Beckham"
school = "DataRockie"
print(my_name)
print(school)

## remove variable
rm(my_name)

## Data type

### numeric
gpa <- 3.41
print(gpa)
age <- 35
print(age)
print(class(age)) #class() use to check data type

### character
class("Hello world")
### function paste =>  use to concat string
paste("hello", "world")
paste0("hello", "world") #paste0 => No write space
paste("hello", "world", "hahaha")

### boolean => logical(TRUE, FALSE)
class(FALSE)
1+1 == 2
## not equal
5 != 5
#!negate
!TRUE
!(1+1 == 2)
# Is R case sensitive?
"hi" == "Hi"
# R is case-sensitive.
my_name = "toy"
my_Name = "top"
my_name == my_Name

### date
### as.___() change data type
as.character(today_date)
class(today_date)
as.integer() #change data type to integer(numeric)
as.character() #change data type to character

### factor (categorical -> stats, special in R)
gender <- c("male", "female", "male")
class(gender)
gender <- factor(gender)
is.factor(gender)
## factor has two categories
## 1. nominal : male, female
## 2. ordinal : low < medium < high
