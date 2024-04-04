/* select syntax */
SELECT * FROM customers;

SELECT 
	  firstname, 
    lastname, 
    company,
    Country
FROM customers;

SELECT * FROM invoices;

/* STRFTIME -> use to work with date format */
SELECT 
	invoicedate,
    STRFTIME('%Y', invoicedate) As year,
    STRFTIME('%m', invoicedate) AS month,
    STRFTIME('%d', invoicedate) As day,
    STRFTIME('%Y-%m', invoicedate) as monthid
FROM invoices
WHERE monthid = '2009-10'

/* WHERE clause -> use to filter data */
SELECT 
	firstname,
    country,
    email
FROM customers
WHERE country = 'USA' OR country = 'Brazil' OR country = 'Belgium';
/* IN operator & Create table*/
-- In opertor use to multiple filters data
-- We can create a table from a select syntax
  SELECT 
      firstname,
      country,
      email
  FROM customers
  WHERE country In ('Belgium', 'France', 'Italy') ;

/*Drop table -> use to select table*/
DROP TABLE eu_customers;

/* WHERE with numeric data*/
SELECT 
	name,
    composer,
    bytes/(1024*1024) as MB
FROM tracks
WHERE bytes/(1024*1024) BETWEEN 9 AND 10; --inclusive
LIMIT 5;

/*Where with LIKE operator*/
-- Use in pattern mathcing 
SELECT 
	name,
    composer,
    bytes/(1024*1024) as MB
FROM tracks
WHERE MB >= 8 AND name LIKE '%n'; -- filter data that end with 'n'
LIMIT 5;

/*Filter NULL and NOT NULL*/
SELECT 
	name,
    composer,
    bytes/(1024*1024) as MB
FROM tracks
WHERE composer is NOT NULL; --Null -> missing value

/* Aggregate function*/
-- COUNT
SELECT
	COUNT(*),
    COUNT(name),
    COUNT(composer), -- contains NULL (agregate function ไม่นับค่า Null)
    count(*) - count(composer) as null_in_composer_field
FROM tracks;
-- Other -> avg, sum, max, min
SELECT --Aggregate function
	COUNT(*) as total_songs,
    Round(AVG(bytes), 2) As avg_bytes, -- Round use for adjust digit of numeric data
    SUM(bytes/(1024*1024)) as sum_mb,
    MIN(bytes) as min_bytes,
    MAX(bytes) as max_bytes
FROM tracks;

/*Create Table with condition*/
-- CASE WEHN == If else
CREATE TABLE num_songs As
  SELECT
      bytes/(1024*1024) as mb,
      CASE
          WHEN bytes/(1024*1024) >= 8 THEN 'Large'
          WHEN bytes/(1024*1024) >= 3 THEN 'Medium'
          ELSE 'Small'
      END as segment, -- 1
      COUNT (*)
  FROM tracks 
  GROUP by 1; -- 1 คือ caluse select ตัวเลข (จับตามตัว column ที่ 1 ที่เลือกมา)

/*Group by*/
-- COALESCE() use to replaces the missing value
SELECT 
	company,
    COALESCE(company, 'B2C') As Clean_company,
    CASE 
      WHEN company is NULL then 'B2C' 
      ELSE 'B2B'
    END AS Segment
FROM customers ;

/*HAVING*/
-- HAVING run after the group by operate
SELECT 
	CASE 
      WHEN company is NULL then 'B2C' 
      ELSE 'B2B'
    END AS Segment,
    country,
    COUNT(*) as num_customers
FROM customers 
GROUP by 1, 2
HAVING country in ('Belgium', 'France', 'Italy');

/*order*/
SELECT 
	name,
    round(milliseconds/60000.0, 2) as minute --ถ้าต้องการตัวเลขที่ละเอียดเอา integer หาร float
FROM tracks
ORDER by minute	DESC 
LIMIT 5 -- ORDER BY ชอบใช้คู่ LIMIT

/*JOIN*/
-- USING -> use in case name of PK == FK
SELECT *
FROM artists
JOIN albums USING(artistid)
-- join syntax
-- join syntax 01
SELECT 
		ar.name as artist_name,
    al.title as album_name,
    tr.name as track_name,
FROM artists as ar
INNER JOIN albums as al
-- table.column = table.column
	On ar.artistid = al.artistid -- pk=fk (สลับตำแหน่งกันได้)
INNER JOIN tracks as tr
	on al.albumid = tr.albumid
INNER JOIN genres as ge
	on tr.genreid = ge.genreid;
-- join syntax 02
SELECT 
	ge.name,
    count(*) as count_tracks,
    ROUND(avg(milliseconds), 2) as avg_milliseconds
FROM artists as ar -- AS เป็น optional syntax ไม่จำเป็นต้องใส่ก็ได้ถ้าจะตั้งชื่อ
INNER JOIN albums as al
-- table.column = table.column
	On ar.artistid = al.artistid 
INNER JOIN tracks as tr
	on al.albumid = tr.albumid
INNER JOIN genres as ge
	on tr.genreid = ge.genreid
 Group by 1 
 ORDER by 3 DESC
 Limit 5;

/*Virtual table*/
CREATE VIEW genre_stats as 
  SELECT 
      ge.name,
      count(*) as count_tracks,
      ROUND(avg(milliseconds), 2) as avg_milliseconds
  FROM artists as ar -- AS เป็น optional syntax ไม่จำเป็นต้องใส่ก็ได้ถ้าจะตั้งชื่อ
        JOIN albums as al 	On ar.artistid = al.artistid 
        JOIN tracks as tr	on al.albumid = tr.albumid
        JOIN genres as ge	on tr.genreid = ge.genreid
   Group by 1 
   ORDER by 3 DESC;

SELECT * FROm genre_stats 
   WHERE name = 'Rock';

/*Sub query*/
-- basic Subquery
SELECT firstname, email FROM
(SELECT * FROM customers) -- line 2 in() is subquery
WHERE email LIKE '%yahoo.%'
-- subqueries
SELECT firstname, country
FROM (SELECT * FROM customers) AS sub
WHERE country = 'United Kingdom';
-- WITH : common table expression
WITH sub AS (SELECT * FROM customers)
SELECT firstname, country
FROM sub
WHERE country = 'United Kingdom';

-- Example subquery
-- basic query
SELECT
firstname,
lastname,
email,
COUNT(*) count_order
FROM customers c
JOIN invoices i ON c.customerid = i.customerid
WHERE c.country = 'USA' AND STRFTIME("%Y-%m",i.invoicedate) = "2009-10"
GROUP BY 1,2,3;
-- with clauses
WITH usa_customers AS (
SELECT * FROM customers
SQL Live 05 4
WHERE country = 'USA'
), invoice_2009 AS (
SELECT * FROM invoices
WHERE STRFTIME("%Y-%m",invoicedate) = "2009-10"
)
SELECT firstname, lastname, email, COUNT(*)
FROM usa_customers t1
JOIN invoice_2009 t2
ON t1.customerid = t2.customerid
GROUP BY 1,2,3;
-- standard subqueries
SELECT firstname, lastname, email, COUNT(*)
FROM (
SELECT * FROM customers
WHERE country = 'USA'
) AS t1
JOIN (
SELECT * FROM invoices
WHERE STRFTIME("%Y-%m",invoicedate) = "2009-10"
) AS t2
ON t1.customerid = t2.customerid
GROUP BY 1,2,3;
