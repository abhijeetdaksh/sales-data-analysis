CREATE TABLE sales_data (
	order_id INT,
	order_date DATE,
	region VARCHAR(50),
	product_name VARCHAR(100),
	sales FLOAT
);

SELECT * FROM sales_data LIMIT 10;
DROP TABLE sales_data;

SELECT region, SUM(sales) AS total_sales
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;

-- SELECT MONTH( order_date) AS month,
-- 	SUM(sales) AS total_sales
-- FROM sales_data
-- GROUP BY month
-- ORDER BY month;
-- SHOW COLUMNS FROM sales_data;

SELECT 
STR_TO_DATE(`Order Date`, '%d-%m-%Y') AS formatted_date
FROM sales_data;

-- SELECT 
-- MONTH(STR_TO_DATE(`Order Date`, '%d-%m-%Y')) AS month,
-- SUM(sales) AS total_sales
-- FROM sales_data
-- GROUP BY month
-- ORDER BY month;

ALTER TABLE sales_data ADD order_date_new DATE;

SET SQL_SAFE_UPDATES = 0;

UPDATE sales_data
SET order_date_new =
CASE
    WHEN `Order Date` REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
         AND SUBSTRING(`Order Date`,4,2) <= '12'
    THEN STR_TO_DATE(`Order Date`, '%d-%m-%Y')

    WHEN `Order Date` REGEXP '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$'
         AND SUBSTRING(`Order Date`,4,2) > '12'
    THEN STR_TO_DATE(`Order Date`, '%m-%d-%Y')

    ELSE NULL
END;

SELECT `Order Date`, order_date_new 
FROM sales_data
LIMIT 10;

SELECT 
MONTH(order_date_new) AS month,
SUM(sales) AS total_sales
FROM sales_data
GROUP BY MONTH(order_date_new)
ORDER BY month;

-- 1️⃣ Region-wise Sales

SELECT 
region,
SUM(sales) AS total_sales
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;

-- 2️⃣ Monthly Sales (Correct Order + Month Name)

SELECT 
MONTHNAME(order_date_new) AS month,
SUM(sales) AS total_sales
FROM sales_data
GROUP BY MONTH(order_date_new), MONTHNAME(order_date_new)
ORDER BY MONTH(order_date_new);

-- 3️⃣ Top 5 Products

SELECT 
`Product Name`,
SUM(sales) AS total_sales
FROM sales_data
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 5;

-- 4️⃣ Total Revenue

SELECT 
SUM(sales) AS total_revenue
FROM sales_data;

-- 5️⃣ Region + Product (Advanced Analysis 🔥)

SELECT 
region,
`Product Name`,
SUM(sales) AS total_sales
FROM sales_data
GROUP BY region, `Product name`
ORDER BY total_sales DESC;