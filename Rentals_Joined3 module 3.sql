-- View: public.rentals_joined3

-- DROP VIEW public.rentals_joined3;

CREATE OR REPLACE VIEW public.rentals_joined3
 AS
 SELECT a.rental_id,
    a.rental_date,
    a.return_date,
    a.store_id,
    a.customer_name,
    a.staff_name,
    a.film_title,
    a.film_length,
    a.film_rating,
    a.category_name,
    b.amount_spent,
    EXTRACT(day FROM a.return_date - a.rental_date) AS days_rented,
        CASE
            WHEN EXTRACT(hour FROM a.rental_date) < 4::numeric THEN 'late night'::text
            WHEN EXTRACT(hour FROM a.rental_date) < 12::numeric THEN 'morning'::text
            WHEN EXTRACT(hour FROM a.rental_date) < 17::numeric THEN 'afternoon'::text
            WHEN EXTRACT(hour FROM a.rental_date) < 22::numeric THEN 'evening'::text
            ELSE 'late night'::text
        END AS hour_of_rental
   FROM rentals_joined a
     LEFT JOIN ( SELECT payment.rental_id,
            sum(payment.amount) AS amount_spent
           FROM payment
          GROUP BY payment.rental_id) b ON a.rental_id = b.rental_id;

ALTER TABLE public.rentals_joined3
    OWNER TO postgres;

