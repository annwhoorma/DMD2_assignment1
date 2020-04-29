## Nodes

#### Actor

```cypher
load csv with headers from "file:///csv_files/actor.csv" as row
create (:Actor {
ID: apoc.convert.toInteger(row.actor_id), 
firstName: row.first_name, 
lastName: row.last_name, 
lastUPD: apoc.date.parse(row.actor_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss.ms')
});
```

#### Customer

```cypher
load csv with headers from "file:///csv_files/customer.csv" as row
create (:Customer {
ID:apoc.convert.toInteger(row.customer_id), 
firstName:row.first_name, 
lastName:row.last_name,
email:row.email,
activebool:apoc.convert.toBoolean(row.activebool), 
createDate:apoc.date.parse(row.create_date, 'ms', 'yyyy-MM-dd'), 
active:apoc.convert.toInteger(row.active),
address:row.address,
address2:row.address2,
district:row.district,
city:row.city,
country:row.country,
postalCode:apoc.convert.toInteger(row.postal_code),
addressLastUPD:apoc.date.parse(row.address_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss'), 
cityLastUPD:apoc.date.parse(row.city_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss'), 
countryLastUPD:apoc.date.parse(row.country_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss'), 
lastUPD:apoc.date.parse(row.customer_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss.ms')
});
```

#### Film

```cypher
load csv with headers from "file:///csv_files/film.csv" as row
create (:Film {
ID:apoc.convert.toInteger(row.film_id),
title:row.title,
description:row.description,
releaseYear:apoc.date.parse(row.release_year, 'ms', 'YYYY'),
rentalDuration:apoc.convert.toInteger(row.rental_duration),
rentalRate:apoc.convert.toFloat(row.rental_rate),
length:apoc.convert.toInteger(row.length),
replacementCost:apoc.convert.toFloat(row.replacement_cost),
rating:row.rating,
specialFeatures:split(replace(replace(row.special_features, "{", ""), "}", ""), ","), 
fulltext:row.fulltext
});
```



#### Staff

```cypher
load csv with headers from "file:///csv_files/staff.csv" as row
create (:Staff {
ID:apoc.convert.toInteger(row.staff_id),
firstName:row.first_name,
lastName:row.last_name, 
email:row.email,
active:apoc.convert.toBoolean(row.active),
username:row.username,
password:row.password,
picture:row.picture,
address:row.address,
address2:row.address2,
district:row.district,
postalCode:apoc.convert.toInteger(row.postal_code),
city:row.city,
country:row.country,
lastUPD:apoc.date.parse(row.staff_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss'),
addressLastUPD:apoc.date.parse(row.address_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss'), 
cityLastUPD:apoc.date.parse(row.city_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss'),
countryLastUPD:apoc.date.parse(row.country_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss')
});
```

#### Category

```cypher
load csv with headers from "file:///csv_files/category.csv" as row
create (:Category {
ID:apoc.convert.toInteger(row.category_id),
name:row.name,
categoryLastUPD:apoc.date.parse(row.category_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss')
});
```

#### Language

```cypher
load csv with headers from "file:///csv_files/language.csv" as row
create (:Language {
ID:apoc.convert.toInteger(row.language_id),
name:row.name,
lastUPD:apoc.date.parse(row.language_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss')
});
```

#### Rental

```cypher
load csv with headers from "file:///csv_files/rental.csv" as row
create (:Rental {
ID:apoc.convert.toInteger(row.rental_id),
rentalDate:apoc.date.parse(row.rental_date, 'ms', 'yyyy-MM-dd HH:mm:ss'),
returnDate:apoc.date.parse(row.return_date, 'ms', 'yyyy-MM-dd HH:mm:ss'),
rentalLastUPD:apoc.date.parse(row.rental_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss')
});
```







#### Store

```cypher
load csv with headers from "file:///csv_files/store.csv" as row
create (:Store {
ID:apoc.convert.toInteger(row.store_id),
address:row.address,
address2:row.address2,
district:row.district,
postalCode:apoc.convert.toInteger(row.postal_code),
city:row.city,
country:row.country,
lastUPD: apoc.date.parse(row.store_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss'),
addressLasUPD:apoc.date.parse(row.address_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss'),
cityLastUPD:apoc.date.parse(row.city_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss'),
countryLastUPD:apoc.date.parse(row.country_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss')
});
```

#### Payment

```cypher
load csv with headers from "file:///csv_files/payment.csv" as row
create (:Payment {
ID:apoc.convert.toInteger(row.payment_id),
amount:apoc.convert.toFloat(row.amount),
paymentDate:apoc.date.parse(row.payment_date, 'ms', 'yyyy-MM-dd HH:mm:ss')
});
```

## Indexes

#### Actor

```cypher
create index actor_id for (n:Actor) on (n.ID);
create index customer_id for (n:Customer) on (n.ID);
create index film_id for (n:Film) on (n.ID);
create index staff_id for (n:Staff) on (n.ID);
create index category_id for (n:Category) on (n.ID);                                        
create index language_id for (n:Language) on (n.ID);                                        
create index rental_id for (n:Rental) on (n.ID);                                        
create index store_id for (n:Store) on (n.ID);                                        
create index payment_id for (n:Payment) on (n.ID);                                        
```

## Relationships

#### WORKS_IN

````cypher
load csv with headers from "file:///csv_files/works_in.csv" as row
match (staff:Staff{ID:apoc.convert.toInteger(row.staff_id)})
match (store:Store{ID:apoc.convert.toInteger(row.store_id)})
merge (staff)-[:WORKS_IN]->(store);
```



#### ACTS_IN

```cypher
load csv with headers from "file:///csv_files/film_actor.csv" as row
match (film:Film{ID:apoc.convert.toInteger(row.film_id)})
match (actor:Actor{ID:apoc.convert.toInteger(row.actor_id)})
merge (actor)-[acts:ACTS_IN]->(film)
on create set acts.lastUPD=apoc.date.parse(row.film_actor_upd, 'ms', 'yyyy-MM-dd HH:mm:ss');
```

#### IN_CATEGORY

```cypher
load csv with headers from "file:///csv_files/film_category.csv" as row
match (film:Film{ID:toInteger(row.film_id)})
match (category:Category{ID:toInteger(row.category_id)})	
merge (film)-[c:IN_CATEGORY]->(category)
on create set c.lastUPD=apoc.date.parse(row.film_category_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss');
```

#### IN_LANGUAGE

```cypher
load csv with headers from "file:///csv_files/film_language.csv" as row
match (film:Film{ID:apoc.convert.toInteger(row.film_id)})
match (lang:Language{ID:apoc.convert.toInteger(row.language_id)})
merge (film)-[:IN_LANGUAGE]->(lang);
```

#### HAS

```cypher
load csv with headers from "file:///csv_files/inventory.csv" as row
match (store:Store{ID:apoc.convert.toInteger(row.store_id)})
match (film:Film{ID:apoc.convert.toInteger(row.film_id)})
merge (store)-[h:HAS]->(film)
on create set h.ID=apoc.convert.toInteger(row.inventory_id),h.lastUPD=apoc.date.parse(row.inventory_last_upd, 'ms', 'yyyy-MM-dd HH:mm:ss');
```

#### RENTAL (STORE_RENTAL, FILM_RENTAL, CUSTOMER_RENTAL)

```cypher
load csv with headers from "file:///csv_files/rental.csv" as row
match (rent:Rental{ID:apoc.convert.toInteger(row.rental_id)})
match (cust:Customer{ID:apoc.convert.toInteger(row.customer_id)})
match ((store:Store)-[has:HAS{ID:apoc.convert.toInteger(row.inventory_id)}]->(film:Film))
match (staff:Staff{ID:apoc.convert.toInteger(row.staff_id)})
merge (store)-[s_r:STORE_RENTAL]->(rent)
merge (film)-[f_r:FILM_RENTAL]->(rent)
merge (cust)-[c_r:CUSTOMER_RENTAL]->(rent)
merge (staff)-[s_f:STAFF_RENTAL]->(rent)
on create set s_r.ID=apoc.convert.toInteger(row.rental_id), f_r.ID=apoc.convert.toInteger(row.rental_id), c_r.ID=apoc.convert.toInteger(row.rental_id), s_f.ID=apoc.convert.toInteger(row.rental_id);
```







#### PAYMENT (RENTAL_PAYMENT, STAFF_PAYMENT, CUSTOMER_RENTAL)

~~~cypher
load csv with headers from "file:///csv_files/payment.csv" as row
match (paym:Payment{ID:apoc.convert.toInteger(row.payment_id)})
match (rent:Rental{ID:apoc.convert.toInteger(row.rental_id)})
match (cust:Customer{ID:apoc.convert.toInteger(row.customer_id)})
match (staff:Staff{ID:apoc.convert.toInteger(row.staff_id)})
merge (rent)-[r_p:RENTAL_PAYMENT]->(paym)
merge (staff)-[s_p:STAFF_PAYMENT]->(paym)
merge (cust)-[c_p:CUSTOMER_PAYMENT]->(paym)
on create set r_p.ID=apoc.convert.toInteger(row.payment_id), s_p.ID=apoc.convert.toInteger(row.payment_id), c_p.ID=apoc.convert.toInteger(row.payment_id);
~~~

## Queries

#### Query 1

**Retrieve all the customers that rented movies of at least two different categories during the current year. The current year is the year of the most recent records in the table rental.**

This query is also implemented in python (*queries/query1.py*), which connects to neo4j database and outputs the resulting table.

You can see the resulting table in *queries/queries_results/query1_result.csv* which was created using Neo4j Desktop

```cypher
match (all_r:Rental)
with apoc.date.field(max(all_r.rentalDate), 'years') as year

match (c:Customer)-[cr:CUSTOMER_RENTAL]->(r:Rental)
match (f:Film)-[fr:FILM_RENTAL]->(r)
where apoc.date.field(r.rentalDate, 'years') = year and cr.ID=r.ID and cr.ID=fr.ID

match (f)-[in_c:IN_CATEGORY]->(cat:Category)
with count(cat) as amount_of_categories, c.ID as customer_id, c.firstName as customer_name, c.lastName as customer_surname
where amount_of_categories>=2
return customer_id, customer_name, customer_surname, amount_of_categories
```

#### Query 2

**Create a report that shows a table actor (rows) vs actor (columns) with the number of movies the actors co-starred.**

Implemented in *queries/query2.py*, since it required some work with arrays. 

You can see the resulting table in *queries/queries_results/query2_result.csv*

#### Query 3

**A report that lists all films, their film category and the number of times it has been rented by a customer.**

This query is also implemented in python (*queries/query3.py*), which connects to neo4j database and outputs the resulting table.

You can see the resulting table in *quesries/queries_results/query3_result.csv* which was created using Neo4j Desktop

```cypher
match (f:Film)-[fr:FILM_RENTAL]->(r:Rental)
match (c:Customer)-[cr:CUSTOMER_RENTAL]->(r)
where fr.ID=cr.ID
with count(*) as rented_times

match (f:Film)-[in_cat:IN_CATEGORY]->(cat:Category)
with f.ID as film_ID, f.title as film_title, cat.name as category_name, rented_times
return film_ID, film_title, category_name, rented_times
```

