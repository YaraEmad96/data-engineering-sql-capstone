--recalling the rentals_joined4 Table
select *
from rentals_joined4;
--success

--aggregate rentals_joined4 by 1-film_title, 2-store_id, 3-week of rental_date
select film_title, store_id, date_trunc('week', rental_date) as week_of_rental, count(*) as num_rentals
from rentals_joined4
group by 1, 2, 3
order by 1, 2, 3 
--success, 6880 rows, the result doesn’t include any rentals with 0 value"the weeks with no rentals for certain films",
--it means that the result is incomplete, and we'll need to use temporary tables too solve it

--temporary table
select film_title, store_id, date_trunc('week', rental_date) as week_of_rental, count(*) as num_rentals
into film_store_week
from rentals_joined4
group by 1, 2, 3
order by 1, 2, 3
--success

--now create a table that contains each distinct values of each categorical variable
select distinct film_title
from rentals_joined4;

select distinct store_id
from rentals_joined4;

select distinct date_trunc('week', rental_date) as week_of_rental
from rentals_joined4;
--success

--now but these queries into a temporary table
select distinct film_title
into temp film_list
from rentals_joined4;

select distinct store_id
into temp store_list
from rentals_joined4;

select distinct date_trunc('week', rental_date) as week_of_rental
into temp week_list
from rentals_joined4;
--success

--now join alll the variables from the temporary tables that we created
select film_title, store_id, week_of_rental
from film_list, store_list, week_list
order by 1, 2, 3
--success, this is called Cartesian Product; this contains every possible combination of values of the input table
--the number of rows = # rows of the input tables = 958*2*6=11,496

--put the combination query into a temporary table
select film_title, store_id, week_of_rental
into temp all_combinations
from film_list, store_list, week_list
order by 1, 2, 3
--success

--call values from the correct table all_combinations
select a.*, b.num_rentals
from all_combinations as a
left join film_store_week as b using (film_title, store_id, week_of_rental)
order by 1, 2, 3
--now we get all the possible values including the null ones

--use the 'coalesce function' to return the first non-null value passed to the parameter
select a.*, coalesce(b.num_rentals,0) as num_rentals
from all_combinations as a
left join film_store_week as b using (film_title, store_id, week_of_rental)
order by 1, 2, 3
--success

--now build the clean table
select film_title, store_id, date_trunc('week', rental_date) as week_of_rental, count(*) as num_rentals
into film_store_week
from rentals_joined4
group by 1, 2, 3
order by 1, 2, 3

select distinct film_title
from rentals_joined4;

select distinct store_id
from rentals_joined4;

select distinct date_trunc('week', rental_date) as week_of_rental
from rentals_joined4;

select film_title, store_id, week_of_rental
into temp all_combinations
from film_list, store_list, week_list
order by 1, 2, 3

select a.*, coalesce(b.num_rentals,0) as num_rentals
from all_combinations as a
left join film_store_week as b using (film_title, store_id, week_of_rental)
order by 1, 2, 3

--putting it all together
select film_title, store_id, date_trunc('week', rental_date) as week_of_rental, count(*) as num_rentals
into film_store_week
from rentals_joined4
group by 1, 2, 3
order by 1, 2, 3
------full query
create view films_rented_by_week as
with 
film_store_week as (
select film_title, store_id, date_trunc('week', rental_date) as week_of_rental, count(*) as num_rentals
from rentals_joined4
group by 1, 2, 3
order by 1, 2, 3
),

film_list as 
(
select distinct film_title
from rentals_joined4),
store_list as 
(select distinct store_id
from rentals_joined4
),

week_list as
(
select distinct date_trunc('week', rental_date) as week_of_rental
from rentals_joined4
),

all_combinations as 
(
select film_title, store_id, week_of_rental
from film_list, store_list, week_list
order by 1, 2, 3
)

select a.*, coalesce(b.num_rentals,0) as num_rentals
from all_combinations as a
left join film_store_week as b using (film_title, store_id, week_of_rental)
order by 1, 2, 3
--success

--run the query
select * 
from films_rented_by_week
--success