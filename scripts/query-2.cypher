// My Second query looks at the position of politics in Ireland. It counts up the total number of left-wing and right-wing parties and displays the results in a single row with 2 columns


MATCH (n:Political_Party), (m:Political_Party) 
WHERE (n.position ENDS WITH "left" OR n.position ENDS WITH "Left") AND (m.position ENDS WITH "right" OR m.position ENDS WITH "Right")
RETURN COUNT(DISTINCT n.name) AS Left-wing, COUNT(DISTINCT m.name) AS Right-wing