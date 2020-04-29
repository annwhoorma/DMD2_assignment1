from py2neo import Database
from py2neo import Graph, Node
import numpy as np

""" Connection to Neo4j Database """
dvdrental = "bolt://localhost:7687"
db = Database(dvdrental)
graph = Graph(password='13579qwer')
db = graph.begin(autocommit=False)

ret = graph.run('''match (all_r:Rental)
with apoc.date.field(max(all_r.rentalDate), 'years') as year

match (c:Customer)-[cr:CUSTOMER_RENTAL]->(r:Rental)
match (f:Film)-[fr:FILM_RENTAL]->(r)
where apoc.date.field(r.rentalDate, 'years') = year and cr.ID=r.ID and cr.ID=fr.ID

match (f)-[in_c:IN_CATEGORY]->(cat:Category)
with count(cat) as amount_of_categories, c.ID as customer_id, c.firstName as customer_name, c.lastName as customer_surname
where amount_of_categories>=2
return customer_id, customer_name, customer_surname, amount_of_categories''').to_table()
print(ret)

db.commit()