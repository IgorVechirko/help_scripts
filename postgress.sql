-------------------------------------------
--  ds_salaries.csv DB for samples below --
-------------------------------------------

--create DB
CREATE DATABASE sandbox;
--remove DB
DROP DATABASE sandbox;

--create backuup
BACKUP DATABASE sandbox
TO DISK = 'D:\backups\sendbox.bak';

--create table
CREATE TABLE public.salaries
(
	year integer,
	exp_level text,
	emp_type text,
	job_title text,
	salary integer,	
	salary_curr text,
	salary_in_usd integer,
	emp_location text,
	remote_ratio text,
	company_location text,
	company_sizee text
)
	
--INTO create table and copy selected data into it
SELECT * 
INTO salaries2 (IN external.db)
FROM salaries
	
--remove table
DROP TABLE salaries
--remove data but not table
TRUNCATE TABLE salaries;

--Insert value into table. Specify columns order and values in relate oreder, missed columns will be 'null'
INSERT INTO salaries(year, exp_level, emp_type, job_title, salary_in_usd, emp_localtion, remote_ration, company_location)
VALUES
	(2024, 'EX', 'FT', 'Software engineer', 4500, 'UA', 0, 'UA');
--Or skipp columns name and specify all values for all columns in correct order
INSERT INTO salaries
VALUES
	(2024, 'SE', 'FT', 'QA engineer', 120000, 'UAH', 4000, 'UA', 0, 'UA', 'M')
	(2024, 'SE', 'FT', NULL, 120000, 'UAH', 4000, 'UA', 0, 'UA', 'M')

--Same as above but data slecting from another table
INSERT INTO salaries2(year, exp_level)
SELECT salary_in_usd, company_location
FROM salaries

--Update table
ALTER TABLE salaries
ADD email text

ALTER TABLE salaries
DROP COLUMN email

ALTER TABLE salaries
RENAME COLUMN salary_in_usd TO usd_money

ALTER TABLE table_name
ALTER COLUMN column_name datatype;
	
--Update column value
UPDATE salaries
SET job_title = 'Exotic title'
WHERE job_title = 'Exotic titile'

--Dlete rows
DELETE
FROM salaries
WHERE job_title = 'Exotic title'
	
--Display all colums and 10 rows from salaries
SELECT *
FROM salaries;
LIMIT 10;


--Display job_title, exp_level, salary_in_usd columns under aliases with conditions in WHERE and ordered by salary(DESC, ASC) 
-- combination "<>" - mean not equal other comparsion operators the same
SELECT job_title as title
		, exp_level as expirience
		, salary_in_usd as money
FROM salaries
WHERE remote_ration = 100
		AND company_location = 'US'
ORDER BY salary_in_usd DESC
LIMIT 10;


--Count and display amount off all rows
SELECT 
	COUNT(*) AS amount
FROM salaries
LIMIT 10;


--No empty(null) values in column exp_level
SELECT 
	CASE COUNT(*) as total
	, COUNT(exp_level) as expirience
FROM salaries
LIMIT 10;
--or
SELECT 
	(CASE 
		WHEN COUNT(*) = COUNT(exp_level) 
		THEN 1 
		ELSE 0 END
	) AS no_empty_exp_level
FROM salaries
LIMIT 10;


--DISTINCT - return oncly unique values for specified column
SELECT 
	DISTINCT job_title
FROM salaries;


--MIN MAX AVG. MIN and MAX can be used with str
SELECT 
	MAX(salary_in_usd) AS max_salary
	, MIN(salary_in_usd) AS min_salary
	, AVG(salary_in_usd) AS avg_salary
FROM salaries
;
SELECT 
	COUNT(DISTINCT job_title) AS jobs_amount
FROM salaries;


--Condition operator is construction CASE WHEN THEN ... WHEN THEN ELSE END
SELECT 
	CASE
		WHEN exp_level = 'SE'
		THEN 'Senior'
		WHEN exp_level = 'MI'
		THEN 'Middle'
		ELSE 'Other'
		END AS Grade
FROM salaries;


--Cast int to float
SELECT 
	DISTINCT(CAST(remote_ration AS FLOAT) / 100)
FROM salaries;


--Value exist in specified range
SELECT
	*
FROM salaries
WHERE
	year BETWEEN 2020 AND 2024;


--Value exist in list
SELECT
	*
FROM salaries
WHERE
	year IN (2021, 2024);

--LIKE search patern in text. % - any amount on any character 0 included, _ - exact one character.
SELECT
	DISTINCT(job_title)
FROM salaries
WHERE
	job_title LIKE('%data%') 
	OR job_title LIKE('%Data%');


--ORDER BY alow agregate result by specified one or more columns.
--To apply filtering to agregated data use HAVING
--Statements execution order 
--1. First, the product of all tables in the FROM clause is formed.
--2. The WHERE clause is then evaluated to eliminate rows that do not satisfy the search_condition.
--3. Next, the rows are grouped using the columns in the GROUP BY clause.
--4. Then, groups that do not satisfy the search_condition in the HAVING clause are eliminated.
--5. Next, the expressions in the SELECT statement target list are evaluated.
--6. If the DISTINCT keyword in present in the select clause, duplicate rows are now eliminated.
--7. The UNION is taken after each sub-select is evaluated.
--8. Finally, the resulting rows are sorted according to the columns specified in the ORDER BY clause.
--9. TOP clause is executed.

SELECT 
	year
	, company_location AS loc
	, ROUND(AVG(salary_in_usd), 0) AS av
FROM salaries
GROUP BY company_location, year
HAVING avg(salary_in_usd) > 300000
ORDER BY av DESC


--Result of query can be used with other statements. Nested query returned format depends on statement wich will use those data.
--For comparsion in must be one value. For IN operator it must be a list. For FROM it must be a table with alias.
SELECT *
FROM salaries
WHERE company_location IN (SELECT 
				company_location 
			   FROM salaries
			   GROUP BY company_location
			   HAVING AVG(salary_in_usd) > (SELECT 
								AVG(salary_in_usd)
							FROM salaries
							)
			)
;

--JOIN bind column from one table to related column from other table and create one result record
--JOIN or INNER JOIN - create result record only if binding value exist in bouth tables
--LEFT JOIN - create result record even if right table doesn't contain apropriate record, skiped field will be fill with NULL
--RIGHT JOIN - create result record even if left table doesn't contain apropriate record, skiped field will be fill with NULL
--FULL JOIN - cobine effect from RIGHT JOIN and LEFT JOIN
SELECT 
	i.BillingAddress 
	, art.Name 
FROM Invoice i
INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
INNER JOIN Track t ON t.TrackId = il.TrackId
JOIN Album a ON a.AlbumId = t.AlbumId
JOIN Artist art ON art.ArtistId = a.ArtistId
WHERE i.BillingAddress = 'Theodor-Heuss-Straße 34'
GROUP BY art.Name 

--Self JOIN - a bit diff syntax and it joined table with itself
--Here select customers from same city
SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City
ORDER BY A.City;

--UNION combine result from tow diff SELECT statements. Must be the same amount and type of columns.
--UNION return distinct values, to receive all values use UNION ALL
SELECT job_title, exp_level FROM salaries
UNION
SELECT exp_level, job_title FROM salaries

--EXISTS return true if subquery return at leat one row. Oncly can be used with WHERE statement
SELECT * FROM  salaries
WHERE EXISTS(SELECT * FROM salaries)

