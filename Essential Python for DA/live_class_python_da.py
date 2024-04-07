# Essential Python for Data Analyst
## review OOP
from random import randint # เราสามารถ import เฉพาะ function ได้ผ่าน from ... import ...

class ATM:
  def __init__(self, account_name, bank_name, initial): ##dunder (double underscore)
    self.account_name = account_name
    self.bank_name = bank_name
    self.balance = initial

  ## string representation -> ใช้อธิบาย obj เราเวลา print obj ที่เราสร้างจาก class ที่สร้าง
  def __str__(self):
    return f"This is an account of {self.account_name}, bank: {self.bank_name}"

  ## method => function
  def check_balance(self):
    print(f"balance: {self.balance} THB")

  def deposit(self, money):
    self.balance += money
    print(f"Deposit succesfully: your new balance: {self.balance} THB")

  def withdraw(self, money):
    self.balance -= money
    print(f"Withdraw successfully: your new balance: {self.balance} THB")

  def get_otp(self):
    otp = randint(1000, 9999)
    print(f"Your OTP: {otp} This OTP will be availble in the next 2 minute")

# create an instance from ATM class
acc1 = ATM("toy", "scb", 500)
print(acc1) # จะ print จาก __str__ -> string representation

# ATM method
acc1.check_balance()
acc1.deposit(1000)
acc1.withdraw(1000)

# Random module
import random
random.randint(1000, 9999)

# Get OTP with random
def get_otp(self):
    otp = randint(1000, 9999)
    print(f"Your OTP: {otp} This OTP will be availble in the next 2 minute")

acc1.get_otp()

# Try Except Block
# No error
try:
  1/5
except ZeroDivisionError:
  print("cannot divide be zero")
except NameError:
  print("variable not defined")
else:
  print("Done")
finally:
  print("Complete!")

# ZeroDivisionError
try:
  1/0
except ZeroDivisionError:
  print("cannot divide be zero")
except NameError:
  print("variable not defined")
else:
  print("Done")
finally:
  print("Complete!")

# variable not defined error
try:
  number/0
except ZeroDivisionError:
  print("cannot divide be zero")
except NameError:
  print("variable not defined")
else:
  print("Done")
finally:
  print("Complete!")

# import csv
## import csv (data analyst style)
import pandas as pd
pd.read_csv("friends.csv")
## manual import
## improt csv
import csv
# use try except combine with csv.reader for check error
try:
    file = open("friends.csV") 

    data = csv.reader(file)

    for row in data:
      print(row)

    file.close()
except FileNotFoundError:
  print("File not found")

try: # ช่วยให้ลดปัญหากรณีมันพังเมื่อเขียนโค้ดยาวๆ
    file = open("friends.csV") # ถ้าพิมพ์ชื่อไฟล์ผิดก็จะ error -> python case sensitive

    data = csv.reader(file)

    for row in data:
      print(row)

    file.close()
except FileNotFoundError:
  print("File not found")

## context manager (import csv)
result = []

## open and close file automatically
try:
  with open("friends.csv") as file:
    data = csv.reader(file)
    for row in data:
      result.append(row)
except:
  print("File not found")
else:
  print("load data successfully!")
finally:
  print(result)

# Import file in Python
## import csv (data analyst style)
import pandas as pd
pd.read_csv("friends.csv")

try:
  df = pd.read_csv("friends.csv")
except:
  print("a little error")

## write csv file using pandas
df.to_csv("newCSVfile.csv")

## write csv using csv module
import csv

col_name = ["food_id", "food", "price"]

data = [
    [1, "pizza", "200"],
    [2, "french fried", 50],
    [3, "coke", 10]
]
 
with open("food.csv", "w") as file: # "w" -> write mode (default "r" -> read mode)
  writer = csv.writer(file)
  writer.writerow(col_name) # write header -> use writerow () เขียนทีละแถว
  writer.writerows(data) # write data -> use writerows

# json = dictionary in python
!cat data.json

import json

with open("data.json") as file: # ต้องเปิดไฟล์ขึ้นมาก่อนแล้วโหลดไปใส่ใน obj -> result
  result = json.load(file)

print(result)
# method
result["favorite_food"].append("hamburger")
result

result["name"] = "John Wick"
result["city"] = "NY"
result

# write file Json
from json import load, dump

# with = context manager ช่วยเราเปิดปิดไฟล์แบบ auto
with open("JohnWick.json", "w") as file: 
  json.dump(result, file, indent = 6)  # indent กำหนดย่อหน้า
  print("successfully dump a new json file.")

!cat JohnWick.json

# API
## Request module 
# import module
from requests import get

url = "https://swapi.dev/api/people/1"

response = get(url)

## status code 200 == OK
print(response.status_code)

# see data that get back from server
print( response.json()["name"])

## Loop with API → get requset
# import module
from requests import get

url = "https://swapi.dev/api/people/"

for i in range(5):
  # range 0 1 2 3 4
  index = i + 1
  new_url = url + str(index)
  resp = get(new_url)
  print(resp.json()["name"])

# API for DA
## get
## post
## delete
## put
## patch

# API with R
## use package → httr2
## use packages → rvest (in tidyverse) =>  for web scraping

# Pandas & Numpy
import numpy as np
import pandas as pd

## Numpy ⇒ numerical python
import numpy as np

nums = [1, 20, 25, 30, 100] # list

## numpy array -> same vector
arr_nums = np.array(nums)
np.sum(nums)

print(
    np.sum(nums),
    np.mean(nums),
    np.median(nums),
    np.min(nums),
    np.max(nums),
    np.std(nums)
)

# use with method 
np.mean(nums)

# vector in R
#[1,2
# 3,4] #R

# numpy
np.array([
  [1,2],
  [3,4]
])

# Matrix with element-wise computation
# element-wise computation
# boradcasting -> เอาตัวเลขที่คูณ บวกหรืออื่นๆ ไปทำกับทุกตัวใน matrix ให้มีขนาดเท่าเดิม
m1 * 100
m1 + 100

m1 + m1

# np.ones()
np.ones((3,3)) # สร้าง matrix ที่เป็นตัวเลข 1

# np.zeros(())
np.zeros((2,2)) # สร้าง matrix ที่เป็นเลข 0

# Built-in function of numpy
np.arange(1, 100, 1) # np.arange(start, stop, step)

np.linspace(1, 101, 10) # np.linspace(start, stop, จำนวนตัวเลขที่โชว์)

# Matrix dot notation
m1 = np.array(
    [
        [1,2],
        [3,4]
    ]
)

m2 = np.array(
    [
        [5,5],
        [3,2]
    ]
)

np.dot(m1, m2) # function in module numpy

m1.dot(m2) # method

# Pandas
import pandas as pd

## create dataframe from scratch
data = {
    "id": [1,2,3],
    "name": ["toy", "anna", "jessica"],
    "city": ["BKK", "JPN", "LON"]
}

df = pd.DataFrame(data)

df

# subset dataframe
df["name"] #แต่ละ col -> series

df["id"]

# Create news col in df
df["age"] = [35,28,29]

df

# Drop
df.drop("age", axis = "columns")

# Read CSV file from pandas
df = pd.read_csv("store.csv")

df.head(2) # ดึง 2 แถวบนสุดขึ้นมา

# Method vs Attribute
## attribute → บอกคุณลักษณะ
df.columns # attribute
df.shape #attribute
## Method → ช่วยทำงาน, เช็ค
df.info() # method

# .query
## query() => filter rows with conditions
## clean dataframe column names => เพื่อให้มันง่ายต่อการทำงาน

col_names = list(df.columns)

for name in col_names:
  print(name.lower().replace(" ", "_").replace("-", "_"))

 # list comprehension for clean column names
clean_col_names = [name.lower().replace(" ", "_").replace("-", "_")
                  for name in col_names] 

## assign clean column names to df
df.columns = clean_col_names

df.head(2)

## data transfromation (R dplyr)

df2 = df[["customer_id", "customer_name"]].head(5)

df2

df3 = df[df["customer_name"] == "Claire Gute"].head()

df3

df4 = df[df["customer_name"] == "Claire Gute"][["order_date", "customer_id", "customer_name"]]

df4

## use query filter data
df.query(" city == 'Los Angeles' and category == 'Furniture' and sub_category == 'Tables' ").head()

# use query filter and [] to select some col that we need
df.query(" city == 'Los Angeles' and category == 'Furniture' and sub_category == 'Tables' ")[["customer_name", "segment", "city"]]

# Aggregate data
## aggregate data in SQL
SELECT segment, sum(sales)
FROM store
GROUP BY 1
ORDER BY 2 DESC, 

## aggregate data in python
df.groupby("segment")["sales"].sum()

## aggregate data and group by more than 1 col
df.groupby(["segment", "region"])["sales"].sum()

# aggregate more than 1 col
df.groupby(["segment", "region"])[["sales", "profit"]].sum()

# more than 1 aggregate verb
df.groupby(["segment", "region"])[["sales", "profit"]].agg(['sum', 'mean'])

# table form
df.groupby(["segment", "region"])[["sales", "profit"]].agg(['sum', 'mean']).reset_index()

# convert to csv
res = df.groupby(["segment", "region"])[["sales", "profit"]].agg(['sum', 'mean', 'count']).reset_index()
res.to_csv("agg_data.csv")

res = df.groupby(["segment", "region"])[["sales", "profit"]]\
      .agg(['sum', 'mean', 'count'])\
      .reset_index()
res.to_csv("agg_data.csv")
res

# Filter → Group by → aggregate example
res = df.query("region == 'West'")\
      .groupby(["segment", "region"])[["sales", "profit"]]\
      .agg(['sum', 'mean', 'count'])\
      .reset_index() # .reset_index ช่วยให้ส่งออกไปหมุนใน pivot => เปลี่ยน form table
print(res)

# Load data from SQL
import sqlite3 # ถ้าต่อไป sever อื่นก็ต้องใช้ library ของตัวมัน
import pandas as pd

## create connection
con = sqlite3.connect("chinook.db")
con
## use pandas to query data
pd.read_sql("select * from customers where country = 'USA'", con)
## Close connection
con.close()

# Sklearn Foundation
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor
from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import train_test_split
import pandas as pd

model = LinearRegression()

# read csv data from githup mtcars
url = "https://gist.githubusercontent.com/seankross/a412dfbd88b3db70b74b/raw/5f23f993cd87c283ce766e7ac6b329ee7cc2e1d1/mtcars.csv"

# read_csv สามารถอ่านไฟล์จากบน internet ได้ด้วย
mtcars = pd.read_csv(url)

# Ml work flow
## 4 steps: split > train > test
## supervise learning with sklearn

y = mtcars["mpg"] 
x = mtcars[["hp", "wt", "am"]]

## 1. split data
X_train, X_test, y_train, y_test = train_test_split(
    x, y, test_size = 0.20, random_state=42 ### test size => จำนวน test data, random_state == (set.seed) => seeding ที่เราใช้ split data มันจะเกิดขึ้นแบบ random มันเลยต้อง split แบบ random
)

## 2. train model
model = LinearRegression()
model.fit(X_train, y_train) ## model fitting

## 3. score
train_error = model.score(X_train, y_train) # train error => score == predicted

## 4. evaluation
test_error = model.score(X_test, y_test)

print(train_error, test_error)

# change algorithm
## RandomForestRegressor algorithm
y = mtcars["mpg"] 
x = mtcars[["hp", "wt", "am"]]

## 1. split data
X_train, X_test, y_train, y_test = train_test_split(
    x, y, test_size = 0.20, random_state=42 
)

## 2. train model
model = RandomForestRegressor()
model.fit(X_train, y_train) ## model fitting

## 3. score
train_error = model.score(X_train, y_train) # train error => score == predicted

## 4. evaluation
test_error = model.score(X_test, y_test)

print(train_error, test_error)

# DecisionTree algorithm
y = mtcars["mpg"] 
x = mtcars[["hp", "wt", "am"]]

## 1. split data
X_train, X_test, y_train, y_test = train_test_split(
    x, y, test_size = 0.20, random_state=42 ### test size => จำนวน test data, random_state == (set.seed) => seeding ที่เราใช้ split data มันจะเกิดขึ้นแบบ random มันเลยต้อง split แบบ random
)

## 2. train model
model = DecisionTreeRegressor()
model.fit(X_train, y_train) ## model fitting

## 3. score
train_error = model.score(X_train, y_train) # train error => score == predicted

## 4. evaluation
test_error = model.score(X_test, y_test)

print(train_error, test_error)



