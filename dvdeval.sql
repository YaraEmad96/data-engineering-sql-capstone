/*
ADDRESS
*/
--how many values for address2 have an empty string
select count(*)
from address 
where address2 = '';
--HOW many of distinct values of district are there
select count(distinct district)
from address
--378

/*
CATEGORY
*/

--how many rows are there?

select count(*)
From Category
--16

--how many distenct category are there?
select count(distinct category)
From Category;
--16

/*
CITY
*/
--how many rows are there?
select count(*)
From City
--600

--how many distinct countries?
select count(distinct city.country_id) 
from city
--109

--how many cities are there in the united states?
select count(*)
from city
where country_id = 103

/*
COUNTRY
*/
--how many rows are there?;

select count(*)
from country

--what is the country_id of the united states?

select country_id
from country
where country = 'united states%'
--103

/*
CUSTOMER
*/

--how many rows are there?
select count(*)
from customer
--599

--how many distinct stores are there?
select count(distinct store_id)
from customer
--2

/*
FILM
*/

--how many rows are there?
select count(*)
from film
--1000

--how many distinct years are there?
select count(distinct release_year)
from film
--1

--what is the year where all film were released?
select distinct release_year
from film
--2006

--howo many distinct prices (renta_rate) are there?
select count(distinct rental_rate)
from film
--3
--what is the highest price?
select rental_rate
from film
order by rental_rate DESC
--4.99

--what is the lenght of the longest film?
select length
from film
order by length desc
--185

--how many films are longer than 3 hours (180 minutes)?
select count(length)
from film
where length > 180
'or' select count(length)
from film
where length > 180
--39