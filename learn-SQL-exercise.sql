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

-- 3.3
select language, count(distinct countrycode) as num_of_country 
from countrylanguage group by 1 order by 2 desc;

-- 3.4
select region, avg(population) as pol_avg from country
group by 1
having pol_avg > (select avg(population) from country);



# Cls4
SELECT *
	FROM Vendors JOIN Products
	ON Vendors.vend_id = Products.vend_id;
    
SELECT vend_name, prod_name, prod_price
	FROM Vendors JOIN Products
	ON Vendors.vend_id = Products.vend_id;
    
SELECT order_num, prod_name, vend_name, prod_price, quantity
	FROM OrderItems, Products, Vendors
	WHERE Products.vend_id = Vendors.vend_id
	AND OrderItems.prod_id = Products.prod_id
	AND order_num = 20007;


SELECT cust_name, cust_contact
	FROM Customers, Orders, OrderItems
	WHERE Customers.cust_id = Orders.cust_id
	AND OrderItems.order_num = Orders.order_num
	AND prod_id = 'RGAN01';

SELECT o.*,cust_name,cust_contact
	FROM Customers AS C, Orders AS O, OrderItems AS OI
	WHERE C.cust_id = O.cust_id
	AND OI.order_num = O.order_num
	AND prod_id = 'RGAN01';
    
SELECT C.*, O.order_num, O.order_date, OI.prod_id, OI.quantity, OI.item_price
	FROM Customers AS C, Orders AS O, OrderItems AS OI
	WHERE C.cust_id = O.cust_id AND OI.order_num = O.order_num 
	AND prod_id = 'RGAN01';
    
SELECT C.*, O.*
	FROM Customers AS C, Orders AS O, OrderItems AS OI
	WHERE C.cust_id = O.cust_id AND OI.order_num = O.order_num 
	AND prod_id = 'RGAN01';

SELECT C.cust_id, O.order_num
FROM customers as C
LEFT JOIN
orders as O
on C.cust_id=O.cust_id;

SELECT C.cust_id, O.order_num
FROM customers as C
RIGHT JOIN
orders as O
on C.cust_id=O.cust_id;

SELECT c.cust_id,cust_name, cust_contact
	FROM Customers AS C
    LEFT JOIN Orders AS O
    ON C.cust_id = O.cust_id
    LEFT JOIN OrderItems AS OI
    ON OI.order_num = O.order_num
    where prod_id = 'RGAN01';

SELECT Customers.cust_id, COUNT(Orders.order_num) AS num_ord -- be careful about count(*)
FROM Customers INNER JOIN Orders
 ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;

SELECT Customers.cust_id, COUNT(Orders.order_num) AS num_ord
FROM Customers LEFT OUTER JOIN Orders
 ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;

SELECT Customers.cust_id, Orders.order_num AS num_ord
FROM Customers LEFT OUTER JOIN Orders
 ON Customers.cust_id = Orders.cust_id;

-- union
select cust_name, cust_contact, cust_email from customers
where cust_state in ('IL', 'IN','MI')
UNION
select cust_name, cust_contact, cust_email from customers#customers2
where cust_name = 'Fun4All';

select cust_name, cust_contact, cust_email from customers
where cust_state in ('IL', 'IN','MI')
UNION ALL
select cust_name, cust_contact, cust_email from customers
where cust_name = 'Fun4All';

select cust_name, cust_contact, cust_email from customers 
where cust_state in ('IL', 'IN','MI')
UNION ALL
select cust_name, cust_contact, cust_email from customers
where cust_name = 'Fun4All'
order by cust_name,cust_contact;

# CLS5
insert into Customers
values(
'Toy Land2',
'1000000010',
'123 Any Street',
'New York',
'NY',
'11111',
'USA',null,
null);

select * from Customers;

insert into customers
(cust_id,
cust_name,
cust_address,cust_city,
cust_state,
cust_zip,
cust_country,
cust_contact,cust_email)
values(
'1000000007',
'Toy Land',
'123 Any Street',
'New York',
'NY',
'11111',
'USA',
NULL,
NULL);

insert into customers
(cust_id,
cust_name,
cust_address,cust_city,
cust_state,
cust_zip,
cust_country,
cust_contact,cust_email)
select
cust_id,
cust_name,
cust_address,cust_city,
cust_state,
cust_zip,
cust_country,
cust_contact,cust_email
from CustNew;

select * from customers where cust_id = '1000000005';

select * from Customers;

UPDATE Customers 
SET cust_email = 'abcd@gmail.com'
WHERE cust_id = '1000000005';

UPDATE Customers 
SET cust_email = 'abc@gmail.com',
	cust_contact = 'learnsqlcourse'
WHERE cust_id = '1000000005';

select * from Customers;

DELETE FROM Customers
WHERE cust_id = 'Toy Land2';

select * from Customers; 

DELETE FROM Customers
WHERE cust_id = 'Toy Land2';

select * from Customers; 

# Create Table
CREATE TABLE new_customers AS
SELECT C.cust_id,cust_name, cust_contact
	FROM Customers AS C
    LEFT JOIN Orders AS O
    ON C.cust_id = O.cust_id
    LEFT JOIN OrderIteNataliems AS OI
    ON OI.order_num = O.order_num
    where prod_id = 'RGAN01';
    
select * from new_customers;
# different b/t delete and drop:

delete from new_customers;

drop table if exists new_customers; # with if statement

# create table and drop
CREATE TABLE class.new_c AS
SELECT * FROM Customers;

DROP TABLE class.new_c;

DROP TABLE IF EXISTS new_c;

SELECT vend_id, 
COUNT(*) AS num_prods	
FROM Products				
WHERE prod_price >= 4
			GROUP BY vend_id   
			order by num_prods;
            
create table a as
SELECT vend_id, COUNT(*) AS num_prods
	FROM Products
	WHERE prod_price >= 4
	GROUP BY vend_id
    order by num_prods;
    
SELECT a.vend_id, b.vend_city  FROM 
(SELECT vend_id, COUNT(*) AS num_prods
	FROM Products
	WHERE prod_price >= 4
	GROUP BY vend_id
    Having num_prods >=2
    order by num_prods) AS a
    left join
Vendors as b
on a.vend_id=b.vend_id;

SELECT cust_id, 
order_date, 
ROW_NUMBER() OVER (PARTITION BY cust_id ORDER BY order_date desc) AS row_num 
FROM Orders;


select cust_id, order_date, order_num from
(SELECT *, 
ROW_NUMBER() OVER (PARTITION BY cust_id ORDER BY order_date desc) AS row_num 
