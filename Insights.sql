Insight and Decision making - Which directors would be the best investment for a movie producer.
#1. Which directors balance high ratings and strong revenue?
SELECT name, AVG(vote_average) AS avg_rating, SUM(revenue) AS total_revenue
FROM movies 
JOIN directors ON movies.director_id = directors.id 
GROUP BY name 
HAVING avg_rating >6.12 AND movies.id>3 AND total_revenue>82777095
ORDER BY avg_rating DESC, total_revenue DESC;
-- The conditions to qualify for high ratings and strong revnue are to be above the average movie rating of 6.12, average total revenue of 82777095, and having made at least 3 movies, both averages derived from the dataset.

#2. Which directors have the most consistent financial outcomes?
 SELECT name AS director, 
 COUNT(movies.id) AS movie_count,
  AVG(revenue-budget) AS avg_profit,
  MIN(revenue-budget) AS min_profit,
  MAX(revenue-budget) AS max_profit,
  (MAX(revenue-budget) - MIN(revenue-budget)) AS profit_range
 FROM movies 
 JOIN directors
 ON movies.director_id = directors.id
 WHERE revenue>0 AND budget>0
 GROUP BY director
 HAVING COUNT(movies.id)>3
 ORDER BY avg_profit DESC, profit_range ASC;
 -- Here I find directors with consistent financial outcomes by identifying director volatility (profit_range) and director average profit (avg_profit). I order by directors with high average profit and low profit range to show results that signify the trade off.

#3. Which directors generate the highest total profit?
SELECT name AS director, SUM(revenue-budget) AS total_profit 
FROM movies 
JOIN directors ON movies.director_id = directors.id 
WHERE revenue IS NOT NULL AND budget IS NOT NULL
GROUP BY director
ORDER BY total_profit DESC
LIMIT 20;

#4. Which directors have the highest average profit per movie?
SELECT name AS director, COUNT(movies.id) AS movie_count, AVG(revenue-budget) AS avg_profit
FROM movies 
JOIN directors
ON movies.director_id = directors.id
WHERE budget>0 
AND revenue>0
GROUP BY director
HAVING COUNT(movies.id)>=3
ORDER BY avg_profit DESC;

#5. Which directors most frequently produce profitable films?
SELECT name AS director,
COUNT (movies.id) AS profitable_films
FROM movies
JOIN directors 
ON movies.director_id = directors.id
WHERE revenue>budget
GROUP BY director
HAVING COUNT(movies.id)>3
ORDER BY profitable_films DESC;
-- because it is asking how frequently (how often) a director produces profitable films we use COUNT(movies.id) and not revenue-budget. R-B would be used if profitable is the movie or director not how often.

#6. Which directors are consistently profitable?
SELECT name AS director, AVG(revenue-budget) AS avg_profit, 
COUNT(movies.id) 
FROM movies
JOIN directors 
ON movies.director_id = directors.id 
WHERE revenue>0 AND budget>0 
GROUP BY director 
HAVING avg_profit> 53552482 AND COUNT(movies.id)>=3 
ORDER BY avg_profit DESC;

#7. Which directors maintain rating consistency across films?
SELECT name AS director, AVG(vote_average) AS avg_rating, COUNT(movies.id) AS movie_count, 
 MIN(vote_average) AS min_rating, MAX(vote_average) AS max_rating, (MAX(vote_average)-MIN(vote_average)) AS rating_range
FROM movies
JOIN directors
ON movies.director_id=directors.id
GROUP BY director
HAVING movie_count>3
ORDER BY avg_rating DESC, rating_range ASC;

 
#8. Which directors have the highest average audience rating?
SELECT name AS director, AVG(vote_average) AS avg_rating,
COUNT(movies.id) movie_count
FROM movies 
JOIN directors 
ON movies.director_id=directors.id 
WHERE vote_average>0 AND movies.id>0
GROUP BY director
HAVING movie_count>=3
ORDER BY avg_rating DESC;

#9. Which directors attract the largest total audience engagement?
SELECT name AS director, SUM(vote_count) AS total_votes, popularity, COUNT(movies.id) AS movie_count
FROM movies 
JOIN directors 
ON movies.director_id=directors.id 
GROUP BY director 
HAVING COUNT(movies.id)>3
ORDER BY total_votes DESC, popularity DESC;

