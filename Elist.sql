SELECT  FROM `elistcore.core.customers` LIMIT 1000
-- 1. What is the date of the earliest and latest order, returned in one query?

select min(purchase_ts)as earliest,max(purchase_ts)as latest from
core.orders

-- 2. What is the average order value for purchases made in USD? What about average order value for purchases made in USD in 2019?


select avg(usd_price) from core.orders where   currency = 'USD' and extract(year from purchase_ts) = 2019

-- 3. Return the id, loyalty program status, and account creation date for customers who made an account on desktop or mobile. Rename the columns to more descriptive names.

select id,loyalty_program as member,created_on as start_date, account_creation_method as type from core.customers where account_creation_method = 'desktop' OR account_creation_method = 'mobile'


-- 4. What are all the unique products that were sold in AUD on website, sorted alphabetically?

select distinct(product_name),purchase_platform from core.orders where currency = "AUD" and purchase_platform ='mobile app' order by 1 ASC;
-- 5. What are the first 10 countries in the North American region, sorted in descending alphabetical order?

select * from core.geo_lookup where region = 'NA' order by 1 desc limit 10;

--6. What is the total number of orders by shipping month, sorted from most recent to oldest?
select date_trunc(ship_ts, month) as month,
  count(distinct order_id) as order_count
from core.order_status
group by 1
order by 1 desc;

--7.What is the average order value by year? Can you round the results to 2 decimals?
select extract(year from purchase_ts) as year, 
  round(avg(usd_price),2) as aov
from core.orders
group by 1
order by 1;

--8.Create a helper column is_refund  in the order_status  table that returns 1 if there is a refund, 0 if not. Return the first 20 records.
select *, 
  case when refund_ts is not null then 1 else 0 end as is_refund
from core.order_status
limit 20;

 --9.Return the product IDs and product names of all Apple products.
select distinct product_id,
  product_name
from core.orders
where product_name like '%Apple%'
or product_name = 'Macbook Air Laptop';
--10.Calculate the time to ship in days for each order and return all original columns from the table.
select *, 
  date_diff(ship_ts,purchase_ts, day) as days_to_ship
from core.order_status;
