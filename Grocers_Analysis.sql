--TEST - MODULE 1 CAPE STONE
select distinct department 
from product

SELECT schemaname, relname, n_live_tup 
FROM pg_stat_user_tables 
WHERE relname = 'transaction_data';

select *
from product limit 10;

select count (*)
from product;
--92,353

select *
from transaction_data limit 10;

select count(*)
from transaction_data;
--2,595,732

select *
from hh_demographic limit 10;

select count(*)
from hh_demographic;
--801
--End Test

--Begin MODULE 1 Capstone Project 
--2 years worthwhile of a grocery store Database.

/*
Product
*/

--how many rows?
select *
from product
--92353

--how many null/empty values?
select count(product_id)
from product
where product_id is null 
--1 row = 0

--how many distinct values?
select count(distinct product_id)
from product
--92353

--sort by department, commodity_desc, sub_commodity_desc
select distinct department, commodity_desc, sub_commodity_desc
from product


--filter to only include particular value of sub_commodity_desc. how many different products are there?
select sub_commodity_desc
from product
where sub_commodity_desc = 'CORN CHIPS'
--59


/*
TRANSACTION_DATA
*/

--how many rows?
SELECT *
FROM TRANSACTION_DATA
--2,595,732

--how many null/empty values?
select count(TRANSACTION_DATA)
from TRANSACTION_DATA
where TRANSACTION_DATA is null 

--1 row = 0

--how many distinct values?
select count(distinct TRANSACTION_DATA)
from TRANSACTION_DATA
--2,595,732

--sort by household_key, day_num, basket_id?
select distinct household_key, day, basket_id
from TRANSACTION_DATA

--filter the table to include only products purchased for a single basket_id 27008843374?
select product_id
from TRANSACTION_DATA
where basket_id = '27008843374'
--30 rows of products



/*
HH_DEMOGRAPHIC
*/

--how many rows?
select *
from HH_DEMOGRAPHIC
--801

--how many null/empty values?
select count(HH_DEMOGRAPHIC)
from HH_DEMOGRAPHIC
where HH_DEMOGRAPHIC is null
--1 row = 0

--how many distinct values?
select count(distinct HH_DEMOGRAPHIC)
from HH_DEMOGRAPHIC
--801

--sort by income_desc, age_desc?
select distinct income_desc, age_desc
from HH_DEMOGRAPHIC
order by income_desc, age_desc asc
--or oreder by income_desc, age_desc    it will automatically order it ascending 


--END OF MODULE 1 CAPESTONE 
------------------------------------------>
--START - MODULE 2 CAPSTONE 
--how many rows are in the product table?;
;
select *
from product;
--92353

--how many rows are in the hh_demographic?
select *
from hh_demographic
--801

--how many rows are in the transaction_data?
select *
from transaction_data
--2,595,732

--Join the three tables into one flat table including the most crucial columns needed for the analysis?

create view Grocers_Analysis as
select a.store_id, a.trans_time, a.quantity, b.department, b.sub_commodity_desc as product_name, c.age_desc as age_group, c.income_desc as income_level, c.household_size_desc as household_size
from transaction_data as a
join product as b on a.product_id = b.product_id
join hh_demographic as c on a.household_key = c.household_key
order by trans_time asc

--how many rows are in the new Transaction_data joined table?
select *
from transaction_data
--2,595,732

select *
from grocers_analysis;

--END MODULE 2 CAPESTONE