SELECT * FROM retail_sales
LIMIT 10

-----DATA CLEANING----:-

--CHECK IF THERE IS ANY NULL VALUE EXISTS IN OUR DATA :

SELECT * FROM retail_sales 
WHERE trasaction_id IS NULL

SELECT * FROM retail_sales 
WHERE sale_date IS NULL

SELECT * FROM retail_sales 
WHERE sale_time IS NULL

--SHORTCUT TO FIND NULL VALUES 

SELECT * FROM retail_sales 
WHERE 
    trasaction_id IS NULL 
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	customer_id IS NULL
	OR 
	gender IS NULL
	OR 
	age IS NULL 
	OR 
	category IS NULL
	OR
	quantity IS NULL
	OR
	cogs IS NULL
	OR 
	total_sales IS NULL;

--WE DONT HAVE EFFICIENT INFORMATION SO WE HAVE TO DELETE ROWS

DELETE FROM retail_sales
WHERE 
    trasaction_id IS NULL 
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	customer_id IS NULL
	OR 
	gender IS NULL
	OR 
	age IS NULL 
	OR 
	category IS NULL
	OR
	quantity IS NULL
	OR
	cogs IS NULL
	OR 
	total_sales IS NULL;

--provide the total amount of data we have 

SELECT 
COUNT(*)
FROM retail_sales


------DATA EXPLORATION:-


--Q1: How many sales do we have?


SELECT COUNT (*)
as total_sale
FROM retail_sales


-- Q2: How many unique customers do we have?


SELECT COUNT( DISTINCT customer_id) 
as total_sale
FROM retail_sales


-- Q3: How many categories do we have?

SELECT DISTINCT category
as total_sale
FROM retail_sales

---DATA ANALYSIS AND BUSINESS KEY PROBLEMS & ANSWERS 

---Q1: Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05'; 

--Q2: Write a SQL query to retrieve all transactions where the category is clothing and the quantity sold is more than 10 in November 2022

SELECT
* 
FROM retail_sales
WHERE 
   category = 'clothing'
   AND
   TO_CHAR(sale_date,'yyyy-mm')= '2022-11'
   AND
   quantity >= 10

---Q3: Write a SQL query to calculate the total sales (total sales) for each category

SELECT 
  category, 
  SUM(total_sales) as net_sale,
  COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

---Q4: Write a SQL query to find the average age of customers who purchased items from the beauty category 

SELECT
ROUND(AVG(age), 3) as avg_age 
FROM retail_sales
WHERE category = 'Beauty'

--Q5: Write a SQL query to find all transactions where the total sale is greater than 1000

SELECT * FROM retail_sales
WHERE total_sales > 1000 

--Q6: write a sql query to find the total number of transaction(transacton_id ) made by each gender in each category.

SELECT 
category,
gender,
COUNT(*) as total_trans
FROM retail_sales
GROUP BY  
        category,
		gender
ORDER BY 1	

----Q7---WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND OUT THE BEST SELLING MONTH...?

  ---VERY IMPORTANT QUERY ASKED IN INTERVIEW;_
  
SELECT  
       year,
	   month,
	 avg_sale
FROM 
(
SELECT
       EXTRACT (YEAR FROM sale_date) as year,
	   EXTRACT (month FROM sale_date) as month,
	  AVG(total_sales) as avg_sale,
	  RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG (total_saleS) DESC) as rank
FROM retail_sales
GROUP BY 1 ,2
) as t1
WHERE rank = 1


---Q8-- write a SQL query to find the top 5 customers based on the higest total sales 

SELECT 
customer_id,
SUM(total_Sales) as total_saleee
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


---Q9--Write a SQL query to find the number of unique customers who purchased items from each category


SELECT  
      category,
       COUNT(DISTINCT customer_id) as distinct
FROM retail_sales
GROUP BY category


---Q10--WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS (EXAMPLE MORNING<=12,AFTERNOON BETWEEN 12 & 17 , EVENING >17)

	 ----very important ----

WITH hourly_sales
AS
(
SELECT * ,
      CASE 
	  WHEN EXTRACT(HOUR FROM sale_time ) < 12 THEN  'morning'
	  WHEN EXTRACT(HOUR  FROM sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
	  ELSE  'evening' 
	END as shift 
FROM retail_sales  
)
SELECT
    shift,
    COUNT(*) as total_orders
 FROM hourly_sales
GROUP BY shift

 -----the end----- 







		





   






	
	








