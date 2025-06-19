# sql_project1
# Project Overview:- 
This SQL project involves data cleaning, exploratory analysis, and business-focused analytics on a retail sales dataset. The dataset contains information on customer purchases, including details like sale date, time, customer demographics, item categories, and transaction values.

# TABLE OF CONTENT 
* data cleaning
* data exploration
* business questions & analysis
* tools used
* conclusion

#  Data Cleaning
* Check for NULL Values:-
  
We ensured the dataset has complete and valid entries by checking for NULL values in all key columns:


SELECT * FROM retail_sales 
WHERE 
    trasaction_id IS NULL 
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL 
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sales IS NULL;


    * Deleting Incomplete Rows:-
Since the missing data was not useful, such rows were deleted:


DELETE FROM retail_sales
WHERE 
    trasaction_id IS NULL 
    OR ...
    OR total_sales IS NULL;


   # 2. Data Exploration
Total Records in the Table:

SELECT COUNT(*) FROM retail_sales;

Q1: How many total sales (transactions)?

SELECT COUNT(*) AS total_sale FROM retail_sales;

Q2: How many unique customers?

SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;

Q3: How many product categories?

SELECT DISTINCT category FROM retail_sales;


# 3. Business Questions & Analysis

Q1: Sales made on '2022-11-05'

SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

Q2: Clothing transactions with quantity ≥ 10 in Nov 2022

SELECT * FROM retail_sales
WHERE category = 'clothing'
AND TO_CHAR(sale_date,'yyyy-mm') = '2022-11'
AND quantity >= 10;

Q3: Total sales and orders per category

SELECT category, SUM(total_sales) AS net_sale, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

Q4: Average age of customers in Beauty category

SELECT ROUND(AVG(age), 3) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

Q5: Transactions where total_sales > 1000

SELECT * FROM retail_sales
WHERE total_sales > 1000;

Q6: Number of transactions by gender per category

SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

Q7: Best selling month (avg sales per month)

SELECT year, month, avg_sale
FROM (
  SELECT EXTRACT(YEAR FROM sale_date) AS year,
         EXTRACT(MONTH FROM sale_date) AS month,
         AVG(total_sales) AS avg_sale,
         RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) 
                     ORDER BY AVG(total_sales) DESC) AS rank
  FROM retail_sales
  GROUP BY 1, 2
) t
WHERE rank = 1;

Q8: Top 5 customers based on highest total sales

SELECT customer_id, SUM(total_sales) AS total_saleee
FROM retail_sales
GROUP BY customer_id
ORDER BY total_saleee DESC
LIMIT 5;

Q9: Unique customers per category

SELECT category, COUNT(DISTINCT customer_id) AS distinct_customers
FROM retail_sales
GROUP BY category;
Q10: Order count by shift (Morning, Afternoon, Evening)

WITH hourly_sales AS (
  SELECT *,
         CASE 
           WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'morning'
           WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
           ELSE 'evening' 
         END AS shift
  FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;

# 4.  Tools Used
* SQL (PostgreSQL / MySQL / Oracle)
* Any SQL IDE like DBeaver, SQL Server Management Studio, pgAdmin, etc.

# 5. Conclusion
 This SQL project gave insight into:

* Basic to intermediate data cleaning practices.

*Exploratory data analysis techniques.

*Writing efficient and analytical queries.

*Solving real-world business questions through SQL.



