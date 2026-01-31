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
