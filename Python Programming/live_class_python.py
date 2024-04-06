# Python 101
# Python is case sensitive
"hello" == "Hello"
## 5 concepts essential for programming
## 1. variable
## 2. data types
## 3. data structure: list turple dict set
## 4. control flow: if else
## 5. function: def

## Print() function
print("this is a new file")
print("bootcamp live!")
print("this is cold!")
## # → use comment
# let's learn python 101 together
# today class about 3 hours 9am-noon
print("this is a new file")
print("bootcamp live!")
print("this is cold!")

# create your own function
 def greeting(name, friend):
   print("hello world " + name + " we are going to meet " + friend)

# call function
greeting(name = "Toy!", friend = "first")

# define f-string function
def greeting_fstr(name = "Trump", friend = "Obama"):
  print(f"{name} is going to meet {friend} for lunch.")

# call function
greeting_fstr(name = "Toy", friend = "first")

greeting_fstr(friend="Zue", name="Joey" )

# fstring template
name = "toy"
friend = "zue"

result = f"{name} is going to meet {friend} for lunch."
print(result)

# get user input
username = input("What is your name? ")
print("Hi! " + username)

# naming conversion
my_en_name = "first"
sales_2024 = "5M"

# Combine input() with def() => greeting update V2
def greeting_name():
   username = input("what is your name: ")
   message = f"Hi! {username}, What can i do for you today?"
   print(message)

greeting_name()

# input() ⇒ receive text(string) 
def fdouble_01():
  num = input("Give me one number: ")
  print(num*2)

fdouble_01()
# change to numeric
# double number
def fdouble_02():
   #int float str bool
   num = int(input("Give me one whole number: "))
   print(num * 2)

fdouble_02()

# Data type in Python
# string in python "hello"
# function that is made for string => METHOD
text = "a duck walks into a arb"

print(text.upper)

print(text.replace("duck", "cat"))

print(text.capitalize())

print(text.split())

# generic function vs .method
name = "toy"
friend = "zue"
text2 = "{} is going to have lunch with {}".format(name, friend)
print(text2)

# bool (boolean)
a = 10
b = 15
print(a > b) # FALSE 0
print(a < b) # TRUE 1
print(a == b)
print(a != b) # not equal
print(a >= b)
print(a <= b)

print(int(True) + 1)
print(int(False) + 1)

a = 10
b = 15
c = 20
d = 25

print(a > b and c > d) # truth table
print( 10 == 5 or 6 > 2)

# Data structure

# starts with list []
shopping_list = ["egg", "milk", "bread", "tissue", "salmon", "wine"]

print(shopping_list)

# repeat work -> เรียกค่ามาทีล้ะตัวผ่านการ print ทีละ line
print(shopping_list[0])
print(shopping_list[1])
print(shopping_list[2])

# DRY by using loop
for item in shopping_list: #item is dummy its can be anything ex set, number, x, a etc.
   if(item == "milk" or item == "wine"):
     print("liquid")
   else:
     print(item)

# list.method()
fruits = ["apple", "banana", "orange"]
# lish method
# .append() #add item
# in place
# list is mutable object
fruits.append("grape")

fruits[0] = "green apple"
fruits[2] = "pineapple"

print(fruits)
print(fruits[-1]) # [-1] last object

# .pop() #remove item (default remove last item)
fruits.pop()
print(fruits)

# .remove() can specify item
fruits.remove("green apple")
print(fruits)

# fav book
print() # print() blank line show in terminal
print()
fav_book = [
    "Naked Statistics",
    "Think like a Freak",
    "Deep work"
]
fav_book.append("Business Made Simple")
fav_book.insert(1, "Coah Builder") 

print(fav_book)
# .sort()
fav_book.sort(reverse = True) # default sort a-z (False)
print(fav_book)

# mutable vs immutable
# string is immutable
name = "Python"

print(name[0])
print(name[1])
print(name[5])
print(name[-1]) # the last char
print(name[-2]) # the 2nd last char

name[0] = "C"
print(name) # error str obj does not support item assignment
#แต่ถ้าอยากเปลี่ยน
print(name.replace("P", "C"))
print("C" + name[1:])

print(movies + ["Titanic", "Avatar"]) # + ใช้แค่ชั่วคร่าว
print(movies)

# use + to combine text
# same result as append
movies = movies + ["Titanic", "Avatar"] # ยกเว้นฝากตัวแปรกลับไปในตัวแปรเก่า
print(movies)

# Python dynamic typed language
x = True
type(x)

# python type hint => use → : datatype
name: str = "toy"
gpa: float = 3.45
age: int = 36
movie_lover: bool = True

print(name, age, gpa, movie_lover)

name: str = 100
print(name)

# Tuple => Imuutable object
friends = ("toy", "john", "doe")
type(friends)

for friend in friends:
  print(friend)

## can not update in tuble
friends[0] = "Toy"

# method
friends.count("toy")

## tuple unpacking
age_friends = (35, 30, 28)

toy, john, doe = age_friends

print(toy, john, doe)

# tuple unpacking with define function
def create_books():
  return ("BSM", "MMS", "Coach Builder", "Freak")

b1, b2, b3, _ = create_books()
print(b1, b2, b3)
c1, c2, _, _ = create_books() # กรณีที่เราไม่ต้องการใส่ชื่อให้ตัวแปรนั้น use -> _ เพราะถ้าเว้นไว้หรือใส่ไม่ครบจะ err
print(c1, c2)
d1, d2, _, d4 = create_books()
print(d1, d2, d4)

# Dictionary => Key-value pair → same Json
## mutable object
customer01 = {
    "name": "toy",
    "age": 36,
    "city": "BKK"
}
## dictionary is mutable object
customer01["name"] = "John Wick"
customer01["age"] = 49
customer01["city"] = "New York"
customer01
customer01["name"]

## add new key
customer01["country"] = "US"
customer01

# dictionary.method()
## .key()
customer01.keys()
## .values()
customer01.values()
## .items()
customer01.items()

# loop with dictionary
## loop
for item in customer01.items():
  print(item)

for item in customer01.items():
  print(item[0], item[1])

# delete key
# 1. .pop()
# 2. del function
customer01.pop("country")
customer01
del customer01["name"]
customer01

## .get()
customer01.get("name")
