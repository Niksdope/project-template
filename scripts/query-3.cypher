// My Third query finds all the independant politicians who won a seat in the Dáil


MATCH (n:Politician)
WHERE NOT (n)-[:IS_IN]-() AND (n)-[:TD_IN]-()
RETURN DISTINCT(n)