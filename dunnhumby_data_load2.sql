drop table if exists product;
CREATE TABLE product (product_id integer, manufacturer integer, department varchar,
brand varchar, commodity_desc varchar, sub_commodity_desc varchar,
curr_size_of_product varchar);
COPY product
FROM 'C:\Users\MainUser\Downloads\dunnhumby_The-Complete-Journey\dunnhumby - The complete Journey CSV\product.csv'
DELIMITER ',' CSV HEADER;

drop table if exists transaction_data cascade;
create table transaction_data (household_key integer, basket_id bigint, day integer,
product_id integer, quantity integer, sales_value double precision,
store_id integer, retail_disc double precision, trans_time integer, week_no integer,
coupon_disc double precision, coupon_match_disc double precision);
copy transaction_data
from 'C:\Users\MainUser\Downloads\dunnhumby_The-Complete-Journey\dunnhumby - The complete Journey CSV\transaction_data'
DELIMITER ',' CSV HEADER;

drop table if exists hh_demographic;
create table hh_demographic (age_desc varchar, marital_status_code char(1),
income_desc varchar, homeowner_desc varchar, hh_comp_desc varchar,
household_size_desc varchar, kid_category_desc varchar, household_key integer);
copy hh_demographic
from 'C:\Users\MainUser\Downloads\dunnhumby_The-Complete-Journey\dunnhumby - The complete Journey CSV\hh_demographic'
DELIMITER ',' CSV HEADER;
