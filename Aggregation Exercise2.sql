--Start aggregation exercise
select * from rentals_joined3
--aggregate our database by month of rental, using the date_trunc() function
select distinct rental_date, date_trunc('month', rental_date)
from rentals_joined3

--aggregate the database by day
select distinct rental_date, date_trunc('day', rental_date)
from rentals_joined3

--to see how many months of data we have in the database
select date_trunc('month', rental_date), count(*) as num_rentals, sum(amount_spent)
from rentals_joined3
group by date_trunc('month', rental_date)
--in this database we only have 5 months of data, from 5/2005 to 8/2005 & 2/2006

--let's invistigate on a daily base
select date_trunc('day', rental_date), count(*) as num_rentals, sum(amount_spent)
from rentals_joined3
group by 1
order by date_trunc asc
--when using the date_trunc clause, it changes all the timing to 00 too simplifies the results 

--find out how many null values of amount_spent
select date_trunc('day', rental_date), count(*) as num_rentals, sum(amount_spent)
from rentals_joined3
where amount_spent is null
group by 1
--we have 16 days of null payments in both may and june

--filter for only July and August, since they're the ones with the most data
select min(rental_date), max(rental_date)
from rentals_joined3
where rental_date between '2005-07-01' and '2005-08-31' 

--store a subset of the view that contains only July and August
create view rentals_joined4 as
select *
from rentals_joined3
where rental_date between '2005-07-01' and '2005-08-31'
--data saved successfully in the database of DVD - views

--Let's answer some business questions
--for the month of July & august, which store had the most rentals?
select store_id, count(*) as num_rentals, sum(amount_spent) as Total_revenue
from rentals_joined4
group by 1
order by 2 desc
--the store with the highest reantals is 2 with num_rentals = 6260

--which employee rented the most videos?
select staff_name, count(*) as num_rentals, sum(amount_spent) as total_revenue
from rentals_joined4
group by 1
order by 2 desc;
--mike, num rentals = 6234

--who were our top 10 customers by the number of rentals and the amount of money spent?
select customer_name, count(*) as num_rentals, sum(amount_spent) as total_revenue
from rentals_joined4
group by 1
order by 2 desc
--don't limit to 10, doesn't give the correct answer

--which time of the day have the most rentals?
select hour_of_rental, count(*) as num_rentals, sum(amount_spent) as total_revenue
from rentals_joined4
group by 1
order by 2 desc
--morning - late night - evening - afternoon

--which films were most popular?
select film_title, count(*) as num_rentals, sum(amount_spent) as total_revenue
from rentals_joined4
group by 1
order by 2 desc
--success

--which categories of films has the most rentals?
select category_name, count(*) as num_rentals, sum(amount_spent) as total_revenue
from rentals_joined4
group by 1
order by 2 desc
--success

--which films ratings were most popular?
select film_rating, count(*) as num_rentals, sum(amount_spent) as total_revenue
from rentals_joined4
group by 1
order by 2 desc
--success

--End aggregation exercise

