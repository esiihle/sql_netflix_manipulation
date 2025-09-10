-- Netflix Analysis Project
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
	show_id VARCHAR(6),
	type	VARCHAR(10),
	title 	VARCHAR(150),
	director	 VARCHAR(208),	
	casts 	VARCHAR(1000),	
	country 	VARCHAR(150),
	date_added VARCHAR(50),
	release_year	INT,
	rating	VARCHAR(10),
	duration VARCHAR(15),
	listed_in	VARCHAR(100),
	description	VARCHAR(250)
);

SELECT * FROM netflix;

SELECT 
	COUNT(*) as total_content
FROM netflix;


SELECT 
	Distinct type
FROM netflix;

SELECT * FROM netflix;

--SOlVING 15 BUSINESS PROBLEMS :


--1. COUNTING THE NUMBER OF MOVIES VS TV SHOWS

SELECT
	TYPE,
	COUNT(*) AS total_content
FROM netflix
GROUP BY TYPE

--2. FIND THE MOST COMMON RATING FOR MOVIES AND TV SHOWS
SELECT
	TYPE,
	RATING
FROM
(
	SELECT
		TYPE,
		rating,
		COUNT(*) AS COUNT,
		RANK() OVER(PARTITION BY TYPE ORDER BY COUNT(*) DESC)AS RANKING
	FROM netflix
	GROUP BY 1,2
) AS T1
WHERE
	RANKING = 1

	
--3. LIST ALL MOVIES REALISED IN A SPECIFIC YEAR(E.G 2020)
SELECT * 
FROM netflix
WHERE release_year = 2020

--4. FIND THE TOP 5 COUNTRIES WITH THE MOST CONTENT ON NETFLIX
SELECT * 
FROM
(
	SELECT 
		
		UNNEST(STRING_TO_ARRAY(country, ',')) as country,
		COUNT(*) as total_content
	FROM netflix
	GROUP BY 1
)as t1
WHERE country IS NOT NULL
ORDER BY total_content DESC
LIMIT 5


--5. IDENTIFY THE LONGEST MOVIE
SELECT 
	*
FROM netflix
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC

--6. FIND CONTENT ADDED IN THE LAST 5 YEARS
SELECT
*
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'

--7.FINDING ALL MOVIES/TV SHOWS BY DIRECTOR 'BEN SIMMS'
SELECT *
FROM
(

SELECT 
	*,
	UNNEST(STRING_TO_ARRAY(director, ',')) as director_name
FROM 
netflix
)
WHERE 
	director_name = 'Ben Simms'


--8. LISTING ALL TV SHOWS WITH MORE THAN 5 SEASONS
SELECT *
FROM netflix
WHERE 
	TYPE = 'TV Show'
	AND
	SPLIT_PART(duration, ' ', 1)::INT > 5


--9. COUNTING THE NUMBER OF CONTENT ITEMS IN EACH GENRE
SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
	COUNT(*) as total_content
FROM netflix
GROUP BY 1

--10. FINDIND EACH YEAR AND THE AVERAGE NUMBER OF CONTENT REALISED BY SOUTH AFRICA ON NETFLIX, ONLY RETURNING TOP 5 YEARS WITH AVERAGE HIGHEST AVERAGE CONTENT REALISED
SELECT 
	country,
	release_year,
	COUNT(show_id) as total_release,
	ROUND(
		COUNT(show_id)::numeric/
								(SELECT COUNT(show_id) FROM netflix WHERE country = 'South Africa')::numeric * 100 
		,2
		)
		as avg_release
FROM netflix
WHERE country = 'South Africa' 
GROUP BY country, 2
ORDER BY avg_release DESC 
LIMIT 5

--11.LISTING ALL MOVIES THAT ARE DOCUMENTARIES
SELECT * FROM netflix
WHERE listed_in LIKE '%Documentaries'

--12.LISTING ALL CONTENTS WITHOUT A DIRECTOR
SELECT * FROM netflix
WHERE director IS NULL

--13. LISTING HOW MANY MOVIES ACTOR'WILL SMITH' APPEARED IN LAST 10 YEARS
SELECT * FROM netflix
WHERE 
	casts LIKE '%Will Smith%'
	AND 
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10

--14. LISTING THE TOP 10 ACTORS WHO HAVE APPEARED IN THE HIGHEST NUMBER OF MOVIES PRODUCED IN SOUTH AFRICA
SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) as actor,
	COUNT(*)
FROM netflix
WHERE country = 'South Africa'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

--15.CATEGORIZING THE CONTENT BASED ON THE PRESENCE OF THE KEYWORDS 'kill' and 'violence' IN DESCRIPTION FIELD. Label CONTENT CONTAINING THESE KEYWORDS AS 'bad' AND ALL OTHER CONTENT AS 'good'.COUNT HOW MANY ITEMS FALL INTO EACH CATEGORY
SELECT 
    category,
	TYPE,
    COUNT(*) AS content_count
FROM (
    SELECT 
		*,
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY 1,2
ORDER BY 2


