create view Rentals_Joined AS
select a.rental_id, a.rental_date, a.return_date, b.store_id, concat(c.first_name, ' ', c.Last_name) as Customer_Name, d.first_name as Staff_Name, e.title as film_title, e.length as film_length, e.rating as film_rating, g.name as Category_name
from rental as a
join Inventory as b on a.inventory_ID = b.Inventory_ID 
join Customer as c on a.customer_id = c.customer_id
join Staff as d on a.staff_id = d.Staff_id
join Film as e on b.Film_id = e.film_id
join film_category as f on b.film_id = f.film_id
join category as g on f.category_id = g.category_id

--Module 3 "Aggregation" excersice 

select * from Rentals_Joined limit 10;
select * from Payment;

--1- aggregate the payment table by rental_id, counting the number of rows for each value of rental_id, 
--2- find rows "entry" in this case the "rental_id" where the count of rows "entry" is greater than 1
select rental_id, count(*)
from Payment
Group by 1
Having count(*) > 1;
--rental_id = 4591, count=5;
--to validate
select * from rental;
where rental_id = 4591

--we can’t simply join/ add a column from the payment table using this below query, but instead we join the "amount" variable from the payment table onto the rentals_joined view, so we must first aggregate!
select * from rental as a
join payment as b on a.rental_id = b.rental_id
where a.rental_id = 4591;
--the query will run correctly but it's not the right way to do it

--summing the amount spent, and saving it into a temporary table
select rental_id, sum(amount) as amount_spent
into temp payment_agg
from payment
group by 1
--total rows = 14592

--now join on amount_spent to our rentals-joined view
--saving the results into a temporary table
select a.*, b.amount_spent
into temp rentals_joined2
from rentals_joined as a
left join payment_agg as b on a.rental_id = b.rental_id
--# of rows = 16044, if you didn't use the 'left join' clause you'll get only 14592
--which isn’t correct as the you didn't include the rentals that didn’t have a corresponding payment 

--adding the numbers of days rented
--& the time of day rented
select *, return_date - rental_date as days_rented
from rentals_joined2
--# of rows = 16044
--return_date - rental_date as days_rented means 'return_date' minus 'rental_date' = create column 'days_rented'

--we can use the 'Extract' function to give only a whole number of a day without the amount of hours and minutes
select *, extract(day from return_date - rental_date
) as days_rented
from rentals_joined2
--# of rows 16044

--capture the time of day rented, we can do that by extracting the hour from rental_date
select *, extract(day from return_date - rental_date
) as days_rented, extract(hour from rental_date) as hour_of_rental
from rentals_joined2;
--# of rows = 16044

--we need to change the hour into a category capturing the time of day when the rental occurred,
--example "daytime, latenight", then we'll use the clause CASE WHEN function
--here we're checking if the rental hour was between midnight '00' and '4am'
select *, extract(day from return_date - rental_date
) as days_rented, case when extract(hour from rental_date) < 4 then 'late night' else 'other' 
end as time_of_day
from rentals_joined2;
--# of rows =16044
--the function by itself
select *, case when extract(hour from rental_date) < 4 then 'late night' else 'other' 
end as time_of_day
from rentals_joined2;
--# of rows =16044

--adding more times of the day
create view rentals_joined3 as
select *, extract(day from return_date - rental_date
) as days_rented, case when extract(hour from rental_date) < 4 then 'late night' 
when extract(hour from rental_date)<12 then 'morning'
when extract(hour from rental_date)<17 then 'afternoon'
when extract(hour from rental_date)<22 then 'evening'
else 'late night' 
end as hour_of_rental
from rentals_joined2;

--for our view to become permanent in the database, we need to remove the temporary tables
--and have our query only reference permanent tables and view in our database
--from:
select rental_id, sum(amount) as amount_spent
into temp payment_agg
from payment;
group by 1
--to:
select rental_id, sum(amount) as amount_spent
from payment
group by 1
--and from:
select a.*, b.amount_spent
into temp rentals_joined2
from rentals_joined as a
left join payment_agg as b on a.rental_id = b.rental_id;
--to:
select a.*, b.amount_spent
from rentals_joined as a
left join
 ( 
 select rental_id, sum(amount) as amount_spent
from payment
group by 1
 ) 
as b on a.rental_id = b.rental_id


--adding up the final query
create view rentals_joined3 as 
select a.*, b.amount_spent, extract(day from return_date - rental_date
) as days_rented, case when extract(hour from rental_date) < 4 then 'late night' 
when extract(hour from rental_date)<12 then 'morning'
when extract(hour from rental_date)<17 then 'afternoon'
when extract(hour from rental_date)<22 then 'evening'
else 'late night' 
end as hour_of_rental
from rentals_joined as a
left join
 ( 
 select rental_id, sum(amount) as amount_spent
from payment
group by 1
 ) 
as b on a.rental_id = b.rental_id
--query is valid and correct, # of rows =16044, # of columns = 13
select count(*) columns from rentals_joined