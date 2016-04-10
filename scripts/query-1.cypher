// My First query is one that returns the amount of TDs in each political party and adds them up, representing them in a descending order. This shows the power each party holds in the Dáil


MATCH (n:Political_Party)<-[:IS_IN]-(m:Politician)-[:TD_IN]->(o:Constituency) 
RETURN DISTINCT n.name, COUNT((m)--(n)) 
ORDER BY COUNT((m)--(n)) DESC