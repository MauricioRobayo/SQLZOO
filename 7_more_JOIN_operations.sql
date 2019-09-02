-- https://sqlzoo.net/wiki/More_JOIN_operations

-- 1. 1962 movies
-- List the films where the yr is 1962 [Show id, title]
SELECT id, title
FROM movie
WHERE yr=1962;

-- 2. When was Citizen Kane released?
-- Give year of 'Citizen Kane'.
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3. Star Trek movies
-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr;

-- 4. id for actor Glenn Close
-- What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5. id for Casablanca
-- What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 6. Cast list for Casablanca
-- Obtain the cast list for 'Casablanca'.
SELECT name
FROM actor
JOIN casting
ON id = actorid
WHERE movieid = 11768;

-- 7. Alien cast list
-- Obtain the cast list for the film 'Alien'
SELECT name
FROM actor
JOIN casting
ON id = actorid
JOIN movie
ON movieid = movie.id
WHERE title = 'Alien';

-- 8. Harrison Ford movies
-- List the films in which 'Harrison Ford' has appeared
SELECT title
FROM movie
JOIN casting
ON movie.id = movieid
JOIN actor
ON actorid = actor.id
WHERE name = 'Harrison Ford';

-- 9. Harrison Ford as a supporting actor
-- List the films where 'Harrison Ford' has appeared - but not in the starring role.
SELECT title
FROM movie
JOIN casting
ON movie.id = movieid
JOIN actor
ON actorid = actor.id
WHERE name = 'Harrison Ford' AND ord != 1;

-- 10. Lead actors in 1962 movies
-- List the films together with the leading star for all 1962 films.
SELECT title, name
FROM movie
JOIN casting
ON movie.id = movieid
JOIN actor
ON actorid = actor.id
WHERE yr = 1962 AND ord = 1;

-- 11. Busy years for Rock Hudson
-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='ROCK HUDSON'
GROUP BY yr
HAVING COUNT(title) > 2

-- 12. Lead actor in Julie Andrews movies
-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name
FROM movie
JOIN casting
ON movieid=movie.id AND ord=1
JOIN actor
ON actorid=actor.id
WHERE movie.id IN (
  SELECT movieid FROM casting
  WHERE actorid IN (
  SELECT id FROM actor
  WHERE name = 'Julie Andrews'));

-- 13. Actors with 30 leading roles
-- Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT  name
FROM actor
JOIN casting
ON id = actorid AND ord = 1
GROUP BY  name
HAVING COUNT(movieid) >= 30;

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(actorid) AS actors
FROM movie
JOIN casting
ON id = movieid AND yr = 1978
GROUP BY title
ORDER BY actors DESC, title;

-- 15. List all the people who have worked with 'Art Garfunkel'.
SELECT name
FROM actor
JOIN casting
ON id = actorid
WHERE movieid IN (SELECT movieid
                  FROM actor JOIN casting ON id = actorid
                  WHERE name = 'Art Garfunkel')
 AND name != 'Art Garfunkel';