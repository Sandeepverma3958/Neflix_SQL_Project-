/*🎬 Netflix Content Analysis Using SQL (MS SQL Server)

This project focuses on performing end-to-end data analysis on the Netflix dataset using Microsoft SQL Server to extract meaningful business insights. The dataset contains 8,800+ records of movies and TV shows with attributes such as title, director, cast, country, release year, rating, duration, genre, and description.

The project begins with data profiling and data cleaning, where null values, incorrect ratings (e.g., “84 min” in the rating column), and duplicate records were identified and handled. Data types were validated, and data quality checks were performed to ensure accurate analysis.

Using advanced SQL concepts, the project answers 15 real-world business problems, including:

Comparing the number of Movies vs TV Shows

Finding the most common rating by content type

Identifying the longest movie

Analyzing content added in the last 5 years

Finding year-wise and average content release in India

Listing all documentary movies

Identifying top actors and directors

Categorizing content based on violent keywords in descriptions

Key SQL techniques used include:

GROUP BY, HAVING, CTE

WINDOW FUNCTIONS (AVG() OVER(), RANK())

STRING_SPLIT for multi-valued columns

Date functions (YEAR(), DATEADD())

Data cleaning with CASE, TRIM, REPLACE, CAST

This project demonstrates strong skills in SQL data cleaning, analytical querying, and business insight generation, making it highly relevant for Data Analyst and Business Analyst roles.*/
CREATE DATABASE PROJECT 
SELECT * FROM netflix_titles

EXEC sp_help netflix_titles;
/*All the columns is of varchar type but rating is nvarchar and release year is int data type
and null value is also included*/

Select count(*) Total_count from netflix_titles
-- Total count is 8807 

Select Distinct type from netflix_titles;
-- Type of movies TV show and Movies 

Select count(Distinct country) Nos_of_diff_country from netflix_titles;
Select Distinct country from netflix_titles

-- Numbers of diffrent country is 749

Select Distinct release_year from netflix_titles order by release_year asc
-- In which years the moves had get released 

Select Distinct rating from netflix_titles;

-- Not Ratings 84 min, 66 min, 74 min, NULL this flow in this columns 


--CHECK THE NULL VALUES IN THE TABLE 

SELECT SUM(CASE WHEN SHOW_ID IS NULL THEN 1 ELSE 0 END) AS SHOW_NULL,
SUM(CASE WHEN TYPE IS NULL THEN 1 ELSE 0 END) AS TYPE_NULL,
SUM(CASE WHEN TITLE IS NULL THEN 1 ELSE 0 END) AS TITLE_NULL,
SUM(CASE WHEN DIRECTOR IS NULL THEN 1 ELSE 0 END) AS DIRECTOR_NULL,
SUM(CASE WHEN CAST IS NULL THEN 1 ELSE 0 END) AS CAST_NULL,
SUM(CASE WHEN COUNTRY IS NULL THEN 1 ELSE 0 END) AS COUNTRY_NULL, 
SUM(CASE WHEN DATE_ADDED IS NULL THEN 1 ELSE 0 END) AS DATE_ADDED_NULL,
SUM(CASE WHEN RELEASE_YEAR IS NULL THEN 1 ELSE 0 END) AS RELEASE_NULL,
SUM(CASE WHEN RATING IS NULL THEN 1 ELSE 0 END) AS RATING_NULL,
SUM(CASE WHEN DURATION IS NULL THEN 1 ELSE 0 END) AS DURATION_NULL,
SUM(CASE WHEN LISTED_IN IS  NULL THEN 1 ELSE 0 END) AS LISTED_IN_NULL,
SUM(CASE WHEN DESCRIPTION IS NULL THEN 1 ELSE 0 END) AS DESCRIPTION_NULL

FROM NETFLIX_TITLES

/* FOLLOWING IS THE NULL COLUMNS 
DIRCTOR_NULL = 2634
CAST         = 0825
COUNTRY      = 0831
DATE_ADDED   = 0010
RATING       = 0004
DURATION     = 0003
*/
--DELETE THE NULL VLAUES FROM THE TABLE 
DELETE FROM NETFLIX_TITLES WHERE 
DIRECTOR IS NULL
OR CAST IS NULL
OR COUNTRY IS NULL 
OR DATE_ADDED IS NULL 
OR RATING IS NULL 
OR DURATION IS NULL;

SELECT SUM(CASE WHEN SHOW_ID IS NULL THEN 1 ELSE 0 END) AS SHOW_NULL,
SUM(CASE WHEN TYPE IS NULL THEN 1 ELSE 0 END) AS TYPE_NULL,
SUM(CASE WHEN TITLE IS NULL THEN 1 ELSE 0 END) AS TITLE_NULL,
SUM(CASE WHEN DIRECTOR IS NULL THEN 1 ELSE 0 END) AS DIRECTOR_NULL,
SUM(CASE WHEN CAST IS NULL THEN 1 ELSE 0 END) AS CAST_NULL,
SUM(CASE WHEN COUNTRY IS NULL THEN 1 ELSE 0 END) AS COUNTRY_NULL, 
SUM(CASE WHEN DATE_ADDED IS NULL THEN 1 ELSE 0 END) AS DATE_ADDED_NULL,
SUM(CASE WHEN RELEASE_YEAR IS NULL THEN 1 ELSE 0 END) AS RELEASE_NULL,
SUM(CASE WHEN RATING IS NULL THEN 1 ELSE 0 END) AS RATING_NULL,
SUM(CASE WHEN DURATION IS NULL THEN 1 ELSE 0 END) AS DURATION_NULL,
SUM(CASE WHEN LISTED_IN IS  NULL THEN 1 ELSE 0 END) AS LISTED_IN_NULL,
SUM(CASE WHEN DESCRIPTION IS NULL THEN 1 ELSE 0 END) AS DESCRIPTION_NULL

FROM NETFLIX_TITLES

--Select count(*) Total_count from netflix_titles

 Select count(*) Total_count from netflix_titles

-- TOTAL NUMBER OF ROWNS NOW 5332

--CHECKING THE DUPLICATE VALUE IN COLUMNS

SELECT TITLE, COUNT(*) AS Count
FROM NETFLIX_TITLES
GROUP BY TITLE
HAVING COUNT(*) > 1;

DELETE FROM NETFLIX_TITLES WHERE 
TITLE IN('??? ?????','Esperando la carroza','Love in a Puff')

--RATING HHAVE SOME UNWANTED VALUE 

DELETE FROM NETFLIX_TITLES WHERE 
RATING IN ('84 min', '66 min', '74 min', NULL);

SELECT DISTINCT RATING FROM NETFLIX_TITLES

SELECT * FROM netflix_titles

/*15 Business Problems & Solutions

1. Count the number of Movies vs TV Shows
2. Find the most common rating for movies and TV shows
3. List all movies released in a specific year (e.g., 2020)
4. Find the top 5 countries with the most content on Netflix
5. Identify the longest movie
6. Find content added in the last 5 years
7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
8. List all TV shows with more than 5 seasons
9. Count the number of content items in each genre
10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!
11. List all movies that are documentaries
12. Find all content without a director
13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
15.
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.*/


--1. Count the number of Movies vs TV Shows

SELECT TYPE, COUNT(*) [Total Contant] FROM NETFLIX_TITLES 
GROUP BY TYPE ORDER BY [Total Contant] Desc;
--2. Find the most common rating for movies and TV shows

SELECT * 
FROM (SELECT TYPE , RATING, COUNT(*) RATING_COUNT ,
RANK() OVER(PARTITION BY TYPE ORDER BY COUNT(*) DESC) 
RANKING FROM netflix_titles GROUP BY TYPE,RATING ) 
AS RANKED WHERE RANKING = 1

--3. List all movies released in a specific year (e.g., 2020)

SELECT * FROM netflix_titles

SELECT TYPE , TITLE,release_year FROM netflix_titles WHERE release_year = '2020' and Type = 'Movie'

--4. Find the top 5 countries with the most content on Netflix

SELECT TOP 5 COUNTRY , COUNT(*) NOS_CONTENT_INCOUNTRY FROM netflix_titles GROUP BY country ORDER BY NOS_CONTENT_INCOUNTRY DESC

--5. Identify the longest movie

SELECT Top 1 cast(replace(DURATION ,'min','') as int) logest_duration,
       TYPE ,
       title 
	   from netflix_titles  
	   where type = 'Movie' order by logest_duration desc

-- longest duration in min of the above result 

--6. Find content added in the last 5 years

	SELECT * FROM netflix_titles

SELECT *
FROM netflix_titles
WHERE CAST(date_added AS DATE) >= DATEADD(YEAR, -5, GETDATE());

--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT TYPE , TITLE , director FROM netflix_titles WHERE director = 'Rajiv Chilaka'

--8. List all TV shows with more than 5 seasons

SELECT *
FROM netflix_titles
WHERE Type = 'TV Show'
  AND duration LIKE '%SeasonS%'
  AND CAST(TRIM(REPLACE(duration, 'Seasons', '')) AS INT) > 5;

--9. Count the number of content items in each genre
WITH GenreSplit AS (
    SELECT
        TRIM(value) AS genre
    FROM netflix_titles
    CROSS APPLY STRING_SPLIT(listed_in, ',')
)
SELECT 
    genre,
    COUNT(*) AS genre_count
FROM GenreSplit
GROUP BY genre
ORDER BY genre_count DESC;

--10.Find each year and the average numbers of content release in India on netflix. 


WITH yearly_data AS (
    SELECT 
        release_year AS [Year],
        COUNT(*) AS releases_in_india
    FROM netflix_titles
    WHERE country LIKE '%India%'
    GROUP BY release_year
)
SELECT 
    [Year],
    releases_in_india,
    ROUND(AVG(releases_in_india * 1.0) OVER (), 2) AS avg_releases_per_year
FROM yearly_data
ORDER BY [Year];

--11. List all movies that are documentaries
Select * from 
netflix_titles where type = 'Movie' and listed_in like '%documentaries%'

--12. Find all content without a director

select * from netflix_titles where director is null
-- when to use is ,in and existing 

--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

Select * from 
netflix_titles where cast like '%Salman Khan%' and release_year>=  year(GETDATE())-10;

--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.



WITH SPLITING AS(
SELECT TITLE,
TRIM(VALUE) AS ACTOR 
FROM netflix_titles 
CROSS APPLY string_split(CAST,',')
WHERE TYPE = 'Movie'
and country = 'India')
select ACTOR ,COUNT(*) AS MOVIES 
FROM SPLITING GROUP BY ACTOR 
ORDER BY MOVIES DESC;

/*15.
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.*/

SELECT description FROM netflix_titles where  description like '%bad%'

SELECT DESCRIPTION FROM NETFLIX_TITLES WHERE DESCRIPTION LIKE '%kill%'or description like '%violence%' 

SELECT description FROM netflix_titles where  description like '%Good%'



SELECT CASE WHEN 
       LOWER(description) like '%kill%'
	   and lower(description) like '%violence%'
	   then 'Bad'
	   else 'Good'
	   end as cetogery ,
	   count(*) as total_items 
from netflix_titles 
group by CASE WHEN 
       LOWER(description) like '%kill%'
	   and lower(description) like '%violence%'
	   then 'Bad'
	   else 'Good'
	   end ;

