from py2neo import Database
from py2neo import Graph, Node
import numpy as np

""" Connection to Neo4j Database """
dvdrental = "bolt://localhost:7687"
db = Database(dvdrental)
graph = Graph(password='13579qwer')
db = graph.begin(autocommit=False)

ret = graph.run('''match (f:Film)-[fr:FILM_RENTAL]->(r:Rental)
match (c:Customer)-[cr:CUSTOMER_RENTAL]->(r)
where fr.ID=cr.ID
with count(*) as rented_times

match (f:Film)-[in_cat:IN_CATEGORY]->(cat:Category)
with f.ID as film_ID, f.title as film_title, cat.name as category_name, rented_times
return film_ID, film_title, category_name, rented_times''').to_table()
print(ret)

db.commit()