from py2neo import Database
from py2neo import Graph, Node
import numpy as np

""" Connection to Neo4j Database """
dvdrental = "bolt://localhost:7687"
db = Database(dvdrental)
graph = Graph(password='13579qwer')
db = graph.begin(autocommit=False)


actors_list = graph.run("match(a:Actor) with a.ID as ids return ids").to_ndarray()
number_of_ids = graph.run("match(a:Actor) with count(a.ID) as number_of_ids return number_of_ids").to_ndarray()[0][0]
maxID = graph.run('''match(a:Actor)
with max(a.ID) as max_actor_ID
return max_actor_ID''').to_ndarray()[0][0]

ret = graph.run('''match (a1:Actor)-[:ACTS_IN]->(f:Film)
match (a2:Actor)-[:ACTS_IN]->(f:Film)
with a1.ID as actor1_ID, a2.ID as actor2_ID, count(f) as together
where actor1_ID <> actor2_ID
return actor1_ID, actor2_ID, together''').to_ndarray()
# ret: 1st col - actor1_ID, 2nd col - actor2_ID, 3rd col - how many films actor1 and actor2 had together

print(ret[0][0], ret[0][1], ret[0][2], ret[20867][0], ret[20867][1], ret[20867][2])

table = np.zeros([maxID+1, maxID+1], dtype=int)
for i in range(0, len(ret)-1):
    act1 = ret[i][0]
    act2 = ret[i][1]
    table[act1][act2] = ret[i][2]

print(table)
np.savetxt("queries_results/query2_result.csv", table, delimiter=",")

db.commit()