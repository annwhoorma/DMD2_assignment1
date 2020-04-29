/*
author: Anna Boronina
data export from dvdrental;
queries were written with consideration that the following data will be imported to neo4j,
    therefore, you can see splitting some entities into their original relationships
 */

/*
!!!ATTENTION!!! If you want to run any of the queries you need to replace path to .csv file with your path. This inconvenience is explained in the report.
 */

/*
Note that rental.csv and payment.csv will be used to construct both nodes and relationships in neo4j
Entities that will become nodes:
 - customer(+address, city, country)
 - store (+address, city, country)
 - staff (+address, city, country)
 - film
 - language
 - category
 - actor
 - rental
 - payment

Relationships:
 - inventory (connects film and store)
 - rental (connects nodes: inventory [film & store] and rental)
 - payment (connects nodes: rental, staff, customer and payment)
 - film_language (connects film and language)
 - film_actor (connects film and actor)
 - film_category (connects film and category)
 - works_in (connects store and staff)
 */


/*
 properties of customer and, additionally, customer's address, city and country
 */
\copy (select customer_id,
             first_name,
             last_name,
             store_id,
             email,
             activebool,
             create_date,
             active,
             address.address,
             address2,
             district,
             postal_code,
             city.city,
             country.country,
             customer.last_update as customer_last_upd,
             address.last_update  as address_last_upd,
             city.last_update     as city_last_upd,
             country.last_update  as country_last_upd
      from customer
               left join address on customer.address_id = address.address_id
               left join city on address.city_id = city.city_id
               left join country on country.country_id = city.country_id)
    to "/home/whoorma/Documents/S20/DMD2/ass1/csv_files/customer.csv" with csv header;

/*
properties of store and, additionally, store's address, city and country;
does not include properties 'store.manager_staff_id' because it considered to be a relationship between 'staff' and 'store',
 therefore it was taken to 'works_in.csv'
 */
\copy (select store_id,
             address.address,
             address2,
             district,
             postal_code,
             city.city,
             country.country,
             store.last_update   as store_last_upd,
             address.last_update as address_last_upd,
             city.last_update    as city_last_update,
             country.last_update as country_last_upd
      from store
               left join address on store.address_id = address.address_id
               left join city on address.city_id = city.city_id
               left join country on country.country_id = city.country_id)
    to "/home/whoorma/Documents/S20/DMD2/ass1/csv_files/store.csv" with csv header;

/*
 properties of staff (member) and, additionally, store's address, city and country
 */
\copy (select staff_id,
             first_name,
             last_name,
             email,
             active,
             username,
             password,
             picture,
             address.address,
             address2,
             district,
             postal_code,
             city.city,
             country.country,
             staff.last_update   as staff_last_upd,
             address.last_update as address_last_upd,
             city.last_update    as city_last_upd,
             country.last_update as country_last_upd
      from staff
               left join address on staff.address_id = address.address_id
               left outer join city on address.city_id = city.city_id
               left join country on country.country_id = city.country_id)
    to "/home/whoorma/Documents/S20/DMD2/ass1/csv_files/staff." with csv header;

/*
 properties of film
 */
\copy (select film_id,
             title,
             description,
             release_year,
             rental_duration,
             rental_rate,
             length,
             replacement_cost,
             rating,
             special_features,
             fulltext,
             last_update as film_last_upd
      from film)
    to "/home/whoorma/Documents/S20/DMD2/ass1/csv_files/film.csv" with csv header;

/*
 properties of language
 */
\copy (select language_id,
             name,
             last_update as language_last_update
      from language)
    to "/home/whoorma/Documents/S20/DMD2/ass1/csv_files/language.csv" with csv header;

/*
 properties of category
 */
\copy (select category_id,
             name,
             last_update as category_last_upd
      from category)
    to "/home/whoorma/Documents/S20/DMD2/ass1/csv_files/category.csv" with csv header;

/*
 properties of actor
 */
\copy (select actor_id,
             first_name,
             last_name,
             last_update as actor_last_upd
      from actor)
    to "/home/whoorma/Documents/S20/DMD2/ass1/csv_files/actor.csv" with csv header;

/*
 properties of inventory
 will become a relationship between film and store - HAS
 */
\copy (select inventory_id,
             store_id,
             film_id,
             last_update as inventory_last_upd
      from inventory)
    to "/home/whoorma/Documents/S20/DMD2/ass1/csv_files/inventory.csv" with csv header;

/*
 properties of rental
 rental_id, rental_date, return_date will be used to construct a node 'rental'
 inventory_id, customer_id, staff_id will be used to construct relationships:
    - FILM_RENTAL
    - STORE_RENTAL
    - STAFF_RENTAL
 */
\copy (select rental_id,
             rental_date,
             inventory_id,
             customer_id,
             return_date,
             staff_id,
             last_update as rental_last_upd
      from rental)
    to "/home/whoorma/Documents/S20/DMD2/ass1/csv_files/rental.csv" with csv header;

/*
 properties of payment
 payment_id, amount, payment_date will be used to construct a node 'rental'
 customer_id, staff_id, rental_id will be used to construct relationships:
    - CUSTOMER_PAYMENT
    - STAFF_PAYMENT
    - RENTAL_PAYMENT
 */
\copy (select payment_id,
             customer_id,
             staff_id,
             rental_id,
             amount,
             payment_date
      from payment)
    to "/home/whoorma/Documents/S20/DMD2/ass1/csv_files/payment.csv" with csv header;

/*
 describes relationship between store and staff [member] - WORKS_IN
 */
\copy (select staff_id,
             store_id
      from staff)
    to "/home/whoorma/Documents/S20/DMD2/ass1/csv_files/works_in.csv" with csv header;

/*
 describes relationship between film and category - IN_CATEGORY
 */
\copy (select film_id,
             category_id,
             last_update as film_category_last_upd
      from film_category)
    to "/home/whoorma/Documents/S20/DMD2/ass1/csv_files/film_category.csv" with csv header;

/*
 describes relationship between actor and film - ACTS_IN
 */
\copy (select actor_id,
             film_id,
             last_update as film_actor_last_upd
      from film_actor)
    to "/home/whoorma/Documents/S20/DMD2/ass1/csv_files/film_actor.csv" with csv header;