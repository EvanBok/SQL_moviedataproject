# SQL_project
Test1


```sql
SELECT name, AVG(budget) AS average_budget
FROM movies
JOIN directors ON movies.director_id = directors.id
GROUP BY name
ORDER BY average_budget DESC; 
```
