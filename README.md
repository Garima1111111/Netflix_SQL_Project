# Netflix Data Analysis using PostgreSQL

![Netflix SQL Project](https://github.com/Garima1111111/Netflix_SQL_Project/blob/main/red-large-netflix-logo-text-701751694792625tjldcsq74b.png)

##  Project Overview  
This project explores the **Netflix dataset** using **PostgreSQL (pgAdmin4)**.  
I designed the schema, imported Netflix data, and solved **15 business problems** using SQL queries.  
The aim was to practice **SQL for Data Analytics** and extract meaningful insights.  

---

##  Tech Stack  
- **PostgreSQL (pgAdmin4)** – Database & queries  

---

## 📂 Dataset  
The dataset contains details about Netflix Movies and TV Shows:  
- Show ID  
- Type (Movie / TV Show)  
- Title  
- Director  
- Cast  
- Country  
- Date Added  
- Release Year  
- Rating  
- Duration  
- Listed In (Genre)  
- Description  

---

## ❓ Business Problems Solved  

Here are some of the key SQL queries included:  

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
15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.  

---

## 📜 Example Queries  

### 🔹 1. Count Movies vs TV Shows
```sql
SELECT type, COUNT(show_id) AS Count
FROM netflix
GROUP BY type;

