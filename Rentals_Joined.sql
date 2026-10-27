--Exercice Module (2)

--Join the film_id & store_id from the inventory table to the rental table?
select a.*, b.film_ID, b.store_ID
from rental as a
join inventory as b on a.inventory_ID = b.Inventory_ID 
--

--How many rows in the rental Table?
select *
from rental
--16044

--remove the inventory_ID, and the last_update from the table?
select a.rental_id, a.rental_date, a.customer_id, a.staff_id, a.return_date, a.staff_ID, b.film_ID, b.store_id
from rental as a
join Inventory as b on a.inventory_ID = b.Inventory_ID 
--

--add the customer table to the rental table by keeping the changes made previously?
select *
from customer
select a.rental_id, a.rental_date, a.staff_id, a.return_date, b.film_ID, b.store_id, concat(c.first_name, ' ', c.Last_name) as Customer_Name 
from rental as a
join Inventory as b on a.inventory_ID = b.Inventory_ID 
join Customer as c on a.customer_id = c.customer_id
--Number of rows = 16044

--add the Staff table to the rental table by keeping the changes made previously?
select a.rental_id, a.rental_date, a.return_date, b.film_ID, b.store_id, concat(c.first_name, ' ', c.Last_name) as Customer_Name, d.first_name as Staff_Name 
from rental as a
join Inventory as b on a.inventory_ID = b.Inventory_ID 
join Customer as c on a.customer_id = c.customer_id
join Staff as d on a.staff_id = d.Staff_id
--Number of rows = 16044

--add the Film table to the rental table by keeping the changes made previously?
select *
from film
select a.rental_id, a.rental_date, a.return_date, b.store_id, concat(c.first_name, ' ', c.Last_name) as Customer_Name, d.first_name as Staff_Name, e.title as film_title, e.length as film_length, e.rating as film_rating 
from rental as a
join Inventory as b on a.inventory_ID = b.Inventory_ID 
join Customer as c on a.customer_id = c.customer_id
join Staff as d on a.staff_id = d.Staff_id
join Film as e on b.Film_id = e.film_id
--number of rows = 16044

--we need one final column "film category", and in order to do that we'll need firdt to Join On the Film Category Table--

create view Rentals_Joined AS
select a.rental_id, a.rental_date, a.return_date, b.store_id, concat(c.first_name, ' ', c.Last_name) as Customer_Name, d.first_name as Staff_Name, e.title as film_title, e.length as film_length, e.rating as film_rating, g.name as Category_name
from rental as a
join Inventory as b on a.inventory_ID = b.Inventory_ID 
join Customer as c on a.customer_id = c.customer_id
join Staff as d on a.staff_id = d.Staff_id
join Film as e on b.Film_id = e.film_id
join film_category as f on b.film_id = f.film_id
join category as g on f.category_id = g.category_id
Select * 
From rentals_joined;

--Number of rows = 16044