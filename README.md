# Irish Constituencies Neo4j Database
###### Niks Gurins, G00315379

## Introduction
What I've created is a Neo4j database filled with information about the 2016 Irish General Election. This information consists of all the politicans that ran for TD, the ones who won, the political party they are in and the constituency they won in as well as much more.

I've included all the Political Parties that are in the Dáil and all the ones that are not. 

## Database
My database consists of 609 nodes with 527 relationships. The nodes are of three different labels: Politician, Political_Party and Constituency. 

A Politician node consists of the politicians name, gender and the constituency they ran in. 

A Political_Party has the attributes name, the partys year of establishment and their position in politics i.e Left or Right wing

The Constituency nodes represent all the regions in ireland and have attributes for their name, number of seats they have in the Dáil and the population of the constituency.

The relationships I use to represent information about who's in which political party and who won the seat in the constituency are [:IS_IN] and [:TD_IN] respectively.


I used Microsoft Excel to reduce the time to create nodes/relationships. Most of the excel files are included inside the scripts folder. The way I did relationships for the politicians and parties was I created a Political_Party node and then all the nodes for their members and then executed this query
```cypher
MATCH (n:Politician), (m:Political_Party {name: "Fine Gael"}) 
WHERE NOT (n)--() 
CREATE (n)-[:IS_IN]->(m)
```

This was before I had the [:TD_IN] assigned to the Politicians so whenever I added new politicians they had no relationships and linking them with their Political_Party was quick.

## Queries
* My First query is one that returns the amount of TDs in each political party and adds them up, representing them in a descending order. This shows the power each party holds in the Dáil

* My Second query looks at the position of politics in Ireland. It counts up the total number of left-wing and right-wing parties and displays the results in a single row with 2 columns

* My Third query finds all the independant politicians who won a seat in the Dáil

#### Political power query
This query retreives the politial party with the largest number of seats in the Dáil and hence shows who holds the most power
```cypher
MATCH (n:Political_Party)<-[:IS_IN]-(m:Politician)-[:TD_IN]->(o:Constituency) 
RETURN DISTINCT n.name, COUNT((m)--(n)) 
ORDER BY COUNT((m)--(n)) DESC
```

#### Political position query
This query retreives the political positons of all the parties and adds them all up in a final result to show which side of politics is dominant in Ireland
```cypher
MATCH (n:Political_Party), (m:Political_Party) 
WHERE (n.position ENDS WITH "left" OR n.position ENDS WITH "Left") AND (m.position ENDS WITH "right" OR m.position ENDS WITH "Right")
RETURN COUNT(DISTINCT n.name) AS Left-wing, COUNT(DISTINCT m.name) AS Right-wing
```

#### Independant winners
This query retreives the all the politcal party independant runners who became TDs in the 2016 General election
```cypher
MATCH (n:Politician)
WHERE NOT (n)-[:IS_IN]-() AND (n)-[:TD_IN]-()
RETURN DISTINCT(n)
```

## References
1. [Neo4J website](http://neo4j.com/), the website of the Neo4j database.
2. [Irish political map](http://irishpoliticalmaps.blogspot.ie/), website with all the general elections information