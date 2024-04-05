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
## 1. nominal: male, female
## 2. ordinal: low < medium < high

## Data structure
## Vector
scores <- c(88, 90, 50, 65, 76) ## c => concat เอาตัวเลข or data มาต่อกัน
### vectorization (no need to write loop) ภาษาอื่นต้องเขียน loop เพื่อให้ได้ค่าทั้งหมด หริอ check ค่าทั้งหมด
scores > 80
scores + 2
### Aggregate function in R
### sum scores, average score
print(sum(scores))
print(mean(scores))
print(min(scores))
print(max(scores))
print(length(scores)) ## count range, data
### we can assign name of vector
scores <- c(
    John = 88,
    minne = 90,
    david = 50,
    marry = 65,
    anna = 76)
scores
### subset vector
## Index starts at 1
## subset by position 1, 2, 3
## subset by name "david", "marry"
## subset by condition
scores[1]
scores["John"]
scores[scores > 80] 
### Update value in scores
scores[3] <- 60
scores
### which.max() function ⇒ return max value of vector
which.max(scores)
### paste() + vector
friends <- c("toy", "john", "mary", "david", "lisa")
paste("hi", friends)
### Create 1-10 fast vector code
6:10
seq(1 ,100, 5)

## Matrix => vector 2 dimensions
m1 <- matrix(1:100, ncol = 10, byrow = TRUE) #row?
m1 * 2 # vectorization
### matrix multiplication .dot
m1 <- matrix(c(2,4,5,10), ncol = 2)
m2 <- matrix(c(1,1,5,2), ncol = 2)
m1 * m2 # เอาเลขในตำแหน่งเดียวกันมาคูณกัน
##  matrix multiplication dot operation %*%
m1 %*% m2
### m1.dot(m2) => in python
### check dimension => dim()
dim(m1)

## List
### list => key-value paired
### list(key = value)
customer <- list(
  name = "toy",
  age = 35,
  city = "Bangkok",
  favorite_film = c("Dark Knight", "The Marvels"),
  favorite_matrix = matrix(1:4, ncol=2)
)
### Subset list
customer["age"] # [] ติดชื่อ data ออกมา return เป็น lists
customer[["age"]] # [[]] return เป็น value
customer[["favorite_film"]][1]
### nested lists => list in list
customer01 <- list(
  name = "toy",
  age = 35,
  city = "Bangkok",
  favorite_film = c("Dark Knight", "The Marvels")
)
customer02 <- list(
  name = "jane",
  age = 28,
  city = "Seoul",
  favorite_film = c("About Time", "Taylor Swift Concert")
)
### nested list
list_customers <- list(customer01, customer02)
### subset nested list
list_customers
list_customers[[1]]
list_customers[[2]]["age"]

## Dataframe => It is Excel table
df <- data.frame(
  id = 1:5,
  name = c("toy", "john", "mary", "jane", "anne"),
  age = c(28, 30, 31, 22, 25),
  movie_lover = c(T, T, F, F, T)
)
### by condition
### Subset dataframe
df[["name"]]
df$name
df[!(df$movie_lover), ]
df[(df$age >= 30) | (df$movie_lover), ]
### Create city (add new column)
df$city <- c(rep("BKK", 3), rep("LONDON", 2)) #rep=replicate
df
### Add constrain value
df$random <- 100
df
df[ , 1:4]
### remove column
df <- df[ ,1:5]
#or use below แทน Null เข้าไปใน column
df$random <- NULL
df

## Write to CSV file.
write.csv(df, "movie.csv", row.names=FALSE)

## Read csv file.
movie <- read_csv("movie.csv")
movie

## Preview data frame
## function head, tail, str
head(movie, 3)
tail(movie, 3)
str(movie)

## Function
### Function => change input to output
sum(1:100)
### create new function
my_secret_formula <- function (start, end){
    (start + end) * end/2
}

my_secret_formula (1, 100)
### create function greeting()
greeting <- function (name)
{
  text = paste("Hi!", name)
  print(text)
}

greeting("first")

## Function takes user input
username <- readline("What is your name : ") # receive input only character data type
password01 <- readline("password01 : ")
password02 <- as.numeric(readline("password02 : "))

class(username)
class(password01)
class(password02)

## Define a function with input from a user
greeting_v2 <- function() {
  user_name = readline("Hi what's your name")
  text = paste("Good morning!", user_name)
  print(text)
}

## Control flow
## if-else control flow
grading <- function(score)
	if (score >= 80) {
	  print("A")
	} else if(score >= 70) {
	  print("B")
	} else if(score >= 60) {
	  print("C")
	} else if(score >= 50) {
	  print("D")
	} else {
	  return("Failed")
	}
}
## function is re-usable ใช้ซ้ำเรื่อยๆได้
grading(52)
grading(65)
## For loop
fruits <- c("banana", "apple", "pineapple")
for(fruit in fruits) {
  print(toupper(fruit))
}
## vectorization
toupper(fruits)
## while loop
count <- 0
while ( TRUE ) {
  print("hi!")
  count = count + 1
  if (count == 5){ # ถ้ามีเงื่อนไขที่ทำให้เกิด failse ไม่ต้องมีคำสั่ง break ก็ได้
  print("Done!")
  break
}}
