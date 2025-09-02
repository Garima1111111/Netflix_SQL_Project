drop table if exists Netflix;
Create Table netflix(
show_id	varchar(6),
type varchar(10),
title varchar(150),
director varchar(210),
casts varchar(1000),
country varchar(150),
date_added varchar(50),
release_year int,
rating varchar(10),
duration varchar(15),
listed_in varchar(100),
description varchar(250)
);

select * from netflix;

-- 15 Business Problems & Solutions

--1. Count the number of Movies vs TV Shows

select * from netflix;

select type, count(show_id) as Count from netflix group by type; 


--2. Find the most common rating for movies and TV shows

select type, rating from (select type, rating, count(*) , RANK() OVER (PARTITION BY type ORDER BY count(*) DESC) AS common_rating from netflix group by type, rating) as table1 where table1.common_rating = 1 ;
--3. List all movies released in a specific year (e.g., 2020)

select Title from netflix where release_year = 2020 and type = 'Movie';
--4. Find the top 5 countries with the most content on Netflix

select unnest(string_to_array(country, ',')) as new_country , count(*) from netflix group by new_country order by count(*) desc limit 5 

--5. Identify the longest movie

-- Create a new numeric column
ALTER TABLE netflix
ADD COLUMN duration_int INT;

-- Extract only numbers (works for both 'min' and 'season/seasons')
UPDATE netflix
SET duration_int = CAST(REGEXP_REPLACE(duration, '[^0-9]', '', 'g') AS INT);

select title,type,duration ,COALESCE(duration_int, 0) AS duration_int from netflix where type = 'Movie' order by duration_int desc limit 2;

--6. Find content added in the last 5 years
select title,  from netflix where to_date(date_added, 'Month DD, YYYY') >= current_date - interval'5 years'

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'netflix'
ORDER BY ordinal_position;

--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

select title, director from netflix where director ilike '%Rajiv Chilaka%';
--8. List all TV shows with more than 5 seasons

select title, type, duration_int from netflix where type = 'TV Show' and duration_int > 5;
--9. Count the number of content items in each genre
--SPLIT_PART(string, delimiter, field)

select  unnest(string_to_array(listed_in, ',')) as genre, count(*)  from netflix group by genre;
--10.Find each year and the average numbers of content release in India on netflix.--return top 5 year with highest avg content release! 

select release_year ,count(*) as yearly_content,round(count(*)::numeric/(select count(*) from netflix where country ilike '%India%' )::numeric * 100 , 2) as average_Content from netflix where country ilike '%India%' group by release_year order by count(*) desc limit 5 


--11. List all movies that are documentaries

select title, listed_in from netflix where listed_in ilike '%Documentaries%'
--12. Find all content without a director

select * from netflix where director is null
--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
 select count(*) as total_movies_of_salman from (select type, casts ,date_added, to_date(date_added, 'Month DD, YYYY') >= current_date - interval'10 years' from netflix where type = 'Movie' and casts ilike '%salman khan%')
select type, casts, release_year from netflix where type = 'Movie' and casts ilike '%salman khan%' and release_year >= extract(year from current_date) - 10

--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

select unnest(string_to_array(casts, ',')) as actors, count(*) from netflix where country ilike '%india%' group by actors order by count(*) desc limit 10


--15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--the description field. Label content containing these keywords as 'Bad' and all other 
--content as 'Good'. Count how many items fall into each category.
WITH new_table AS (
    SELECT 
        *,
        CASE
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'bad content'
            ELSE 'good content'
        END AS category
    FROM netflix
)
select category, count(*) from new_table group by category