/*Project SQL database create Pizza restaurant*/
-- Create at least 3 tables
-- Work with at least 3 SQL queries

-- Create customers table
CREATE TABLE customers (
  customers_id INT PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  customers_age INT,
  customers_gender TEXT,
  customers_email TEXT);

  -- Insert customers data
  INSERT INTO customers VALUES
  (1, 'Maya', 'Patel', 21, 'Female', 'maya55@gmail.com'),
  (2, 'Christopher', 'Garcia', 32, 'Male', 'christopher.gar@gmail.com'),
  (3, 'Olivia', 'Johnson', 25, 'Female', 'olivia1999@gmail.com'),
  (4, 'Ethan', 'Lee', 35, 'Male', 'ethan007@gmail.com'),
  (5, 'Sophia', 'Khan', 27, 'Female', 'sophia_1997@gmail.com'),
  (6, 'William', 'Jones', 37, 'Male', 'wil.joe@gmail.com'),
  (7, 'Ava', 'Miller', 20, 'Female', 'ava.mil@gmail.com'),
  (8, 'David', 'Brown', 42, 'Male', 'david123@gmail.com'),
  (9, 'Emily', 'Davis', 29, 'Female', 'emily789@gmail.com'),
  (10, 'Noah', 'Williams', 27, 'Male', 'noah_will@gmail.com');
-- Query customers data
SELECT * FROm customers;

-- Create menu table
CREATE TABLE menus(
  menus_id INT PRIMARY KEY,
  menus_name TEXT,
  menus_type TEXT,
  menus_price INT
);

-- insert menus data
INSERT INTO menus VALUES
(1, 'Margherita Pizza', 'pizza', 10.99),
(2, 'Hawaiian Pizza', 'pizza', 10.99),
(3, 'Meat Feast Pizza', 'pizza', 12.99),
(4, 'Smoked Salmon Pizza', 'pizza', 13.99),
(5, 'Pepperoni Pizza', 'pizza', 10.99),
(6, 'Caesar Salad', 'salad', 8.49),
(7, 'Garlic Bread', 'side', 4.49),
(8, 'Cheesy Breadsticks', 'side',5.99),
(9, 'Chicken Wings', 'Appetizer', 8.99),
(10, 'Coke', 'drinks', 2.49);

-- Create payments method table
CREATE TABLE payments (
  payments_id INT PRIMARY KEY,
  methods TEXT
);

-- Insert payments method data
INSERT INTO payments VALUES
(1, 'Cash'),
(2, 'Mobile Banking'),
(3, 'Credit Card'),
(4, 'TrueMoney');

-- Create staff table
CREATE TABLE staffs(
  staffs_id INT PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  gender TEXT
);

-- Insert staff data
INSERT INTO staffs VALUES
(1, 'Sarah', 'Jones', 'Female'),
(2, 'Michael', 'Brown', 'Male'),
(3, 'Alex', 'Chen', 'Male'),
(4, 'Priya', 'Gupta', 'Female');

-- Create order table
CREATE TABLE orders (
  orders_id INT PRIMARY KEY,
  customers_id INT,
  menus_id INT,
  payments_method INT,
  orders_staff INT,
  orders_qty INT,
  orders_date TEXT
);

-- Insert order data
INSERT INTO orders VALUES
(1, 3, 2, 2, 1, 2, '2023-12-09'),
(2, 5, 5, 3, 3, 1, '2023-12-12'),
(3, 1, 1, 1, 1, 3, '2023-12-15'),
(4, 8, 8, 4, 1, 4, '2023-12-21'),
(5, 7, 3, 2, 4, 1, '2023-12-24'),
(6, 2, 4, 1, 1, 2, '2023-12-28'),
(7, 9, 7, 3, 4, 3, '2023-12-30'),
(8, 4, 9, 4, 1, 1, '2024-01-02'),
(9, 10, 6, 2, 2, 2, '2024-01-08'),
(10, 6, 1, 1, 3, 1, '2024-01-11'),
(11, 1, 8, 3, 4, 4, '2024-01-18'),
(12, 5, 2, 4, 2, 3, '2024-01-25'),
(13, 8, 7, 1, 1, 2, '2024-01-31'),
(14, 3,	5, 2, 4, 1, '2024-02-05'),
(15, 7, 1, 3, 4, 2, '2024-02-10'),
(16, 2, 9, 1, 1, 4, '2024-02-17'),
(17, 9, 4, 2, 4, 3, '2024-02-22'),
(18, 4, 3, 4, 1, 2, '2024-02-24'),
(19, 10, 6, 1, 1, 1, '2024-03-01'),
(20, 6, 8, 3, 3, 2, '2024-03-02');

-- create our data
SELECT * FROM customers;
SELECT * FROM menus;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM staffs;

--  Find the qty sell in each month
SELECT
  STRFTIME('%Y-%m', orders_date) AS orders_date,
  SUM(orders_qty) as total_sell
FROM orders
GROUP By STRFTIME('%Y-%m', orders_date);

-- Find the most popular menu
SELECT 
 ord.menus_id as menus_id, 
 menus_name, 
 sum(orders_qty) as Total_sell
FROM orders as ord
JOIN menus as me
 ON ord.menus_id = me.menus_id
GROUP BY menus_name
ORDER BY sum(orders_qty) DESC
LIMIT 1;

-- Find the total sales in each menu.
SELECT 
 menus_name, 
 ROUND(sum(orders_qty*menus_price), 2) AS total_revenue
FROM orders as ord
JOIN menus as me
 ON ord.menus_id = me.menus_id
GROUP BY menus_name
ORDER BY sum(orders_qty*menus_price) DESC;

-- Sub query: Find the most hard worker staff in Jan 2024
SELECT
first_name,
SUM(orders_qty)
FROM (
SELECT * FROM orders
WHERE STRFTIME('%Y-%m', orders_date) = "2024-01"
) AS t1
JOIN (
SELECt * FROM staffs
) AS t2
ON t1.orders_staff = t2.staffs_id
GROUP BY 1
ORDER BY 1 DESC
LIMIT 1;
