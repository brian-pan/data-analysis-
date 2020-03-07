SELECT * FROM country LIMIT 100;
SELECT code, name, region, population FROM country;
SELECT DISTINCT region from country;
SELECT /*DISTINCT*/ region from country;

SELECT name, population from country 
order by population desc limit 5;

SELECT name, region, SurfaceArea from country 
order by region desc, SurfaceArea;

SELECT name, lifeexpectancy, population from country
where lifeexpectancy >=75 order by 3;

SELECT name, indepyear from country where 
indepyear between 1980 and 1990;

SELECT name, indepyear, region from country
where indepyear is null and region = 'Eastern Asia';

SELECT code, name, region, population, surfacearea, gnp
from country 
where region = 'Western Europe' 
and population < 80000000
and surfacearea > 100
order by code desc;

SELECT AVG(prod_price) AS avg_price
	FROM Products;

SELECT AVG(prod_price) AS avg_price
	FROM Products
	WHERE vend_id = 'DLL01';

SELECT COUNT(*) AS num_cust
	FROM Customers;
    
SELECT COUNT(cust_email) AS num_cust
	FROM Customers;
    
select * from  Customers; 
SELECT count(*), COUNT(cust_email)
	FROM Customers;
    
SELECT MAX(prod_price) AS max_price
	FROM Products;

SELECT MIN(prod_price) AS min_price
	FROM Products;

SELECT SUM(quantity) AS items_ordered
	FROM OrderItems
	WHERE order_num = 20005;

SELECT SUM(item_price*quantity) AS total_sales
	FROM OrderItems
	WHERE order_num = 20005;
    
    SELECT AVG(DISTINCT prod_price) AS avg_price
	FROM Products
	WHERE vend_id = 'DLL01';
    
SELECT COUNT(distinct vend_id) FROM products;

-- is used very often in real business cases to check:
	-- 1. number of records
    -- 2. Null values
    -- 3. Duplicated values
    
    SELECT count(*), COUNT(vend_id), 
COUNT(distinct vend_id)
	FROM products;
    
    
select distinct vend_id, prod_price from products;

SELECT COUNT(*) AS num_items,
	MIN(prod_price) AS price_min,
	MAX(prod_price) AS price_max,
	AVG(prod_price) AS price_avg
	FROM Products;
    
    SELECT vend_id, COUNT(*) AS num_prods
	FROM Products
	GROUP BY vend_id
    ORDER by num_prods;
    
SELECT vend_id, 
count(*) as num_prods, 
avg(prod_price) as avg_price
		FROM Products
        Group By vend_id;