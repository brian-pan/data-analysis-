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



# Cls2
SELECT prod_name, prod_price
	FROM Products
	WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01') 
    AND prod_price >= 10;

SELECT prod_name, prod_price,vend_id
	FROM Products
	WHERE vend_id IN ('DLL01','BRS01');

SELECT prod_id, prod_name
	FROM Products
	WHERE prod_name LIKE 'Fish%';

SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '%bean bag%';

SELECT prod_id, prod_name
	FROM Products
	WHERE prod_name LIKE '__inch teddy bear';
    
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '% inch teddy bear';

-- calculated fields
SELECT vend_name, vend_country, 
Concat(vend_name, ' (', vend_country, ')')
	FROM Vendors
	ORDER BY vend_name;

SELECT vend_name, vend_country, 
Concat(vend_name, ' (', vend_country, ')') 
as vend_title
	FROM Vendors
	ORDER BY vend_name;

SELECT *, concat(vend_name, '(' , vend_zip, ')')  as vend_detail
FROM Vendors
ORDER BY vend_name;

SELECT quantity*item_price AS total_sales,
prod_id, quantity, item_price
	FROM OrderItems
	WHERE order_num = 20008;

-- functions:
SELECT vend_name, 
upper(vend_name) AS vend_name_upcase
	FROM Vendors
	ORDER BY vend_name;

SELECT vend_name, 
substring(vend_name,1,4) 
AS first_4_letters_of_vend_name
	FROM Vendors
	ORDER BY vend_name;

select substring(order_date, 1,7) as month1,
substring(order_date,6,2) as month2
from Orders;

SELECT order_num, order_date
	FROM Orders
	WHERE YEAR(order_date) = 2012;

SELECT order_num, order_date, NOW() as currentdateandtime
	FROM Orders;
    
SELECT order_num, order_date,
NOW() as currentdateandtime, curdate() as curdt,
datediff(curdate(), order_date) as dategap
	FROM Orders;    

SELECT prod_price,
case when prod_price < 6 then 'low price'
	 else 'high price' end as price_seg
     from Products;

-- use case when to create a segmentation column
SELECT prod_price,
case when prod_price < 6 then 'low price'
	 when prod_price < 9 then 'medium price'
	 else 'high price' 
     end as price_segment
     from products;



# Cls3
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
        
        SELECT vend_id, prod_id, 
COUNT(*) AS num_prods	
FROM Products	
GROUP BY vend_id, prod_id;

SELECT order_num,prod_id, 
sum(quantity)
FROM orderitems
GROUP BY 1,2;

    
SELECT cust_id, COUNT(*) AS orders
	FROM Orders
	GROUP BY cust_id
	HAVING orders >= 2;
    
    SELECT vend_id, COUNT(*) AS num_prods
	FROM Products
	WHERE prod_price >= 4
	GROUP BY vend_id
	HAVING COUNT(*) >= 2
    order by num_prods;
    


SELECT order_num
FROM OrderItems
WHERE prod_id = 'RGAN01';

SELECT cust_id
FROM Orders
WHERE order_num IN (20007,20008);

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN ('1000000004','1000000005');

SELECT cust_name, cust_contact
	FROM Customers
	WHERE cust_id IN 
    (SELECT cust_id
				FROM Orders
				WHERE order_num IN 
                (SELECT order_num FROM OrderItems
									WHERE prod_id = 'RGAN01'));

-- 3.1
select continent, sum(population) as sum_pol, avg(lifeexpectancy) as avg_lf 
from country group by 1
having sum_pol >= 1000000;

-- 3.2
select case when population < 1000000 then 'small'
	when population < 10000000 then 'medium'
    when population < 100000000 then 'large'
    when population >= 100000000 then 'extra large' end as population_size, 
    avg(LifeExpectancy)
    from country group by 1;
