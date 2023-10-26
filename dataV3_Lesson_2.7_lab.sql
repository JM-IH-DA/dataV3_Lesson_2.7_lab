USE Sakila;

-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query:

SELECT c.name AS category, COUNT(*) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY category
ORDER BY film_count DESC;

-- 2. Display the total amount rung up by each staff member in August of 2005:

SELECT s.staff_id, CONCAT(s.first_name, '  ', s.last_name) AS staff_name, SUM(p.amount) AS total_amount
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
WHERE DATE(p.payment_date) BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY s.staff_id
ORDER BY total_amount DESC;

-- 3. Which actor has appeared in the most films?

SELECT a.actor_id, CONCAT(a.first_name, '  ', a.last_name) AS actor_name, COUNT(fa.film_id) AS film_count
FROM actor a
LEFT JOIN film_actor fa 
ON a.actor_id = fa.actor_id
GROUP BY actor_id, actor_name
ORDER BY film_count DESC
LIMIT 1;

-- 4. Most active customer (the customer that has rented the most number of films):

SELECT c.customer_id, CONCAT(c.first_name, '  ', c.last_name) AS customer_name, COUNT(r.rental_id) AS rental_count
FROM customer c
LEFT JOIN rental r 
ON c.customer_id = r.customer_id
GROUP BY customer_id, customer_name
ORDER BY rental_count DESC
LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member:

SELECT s.staff_id, CONCAT(s.first_name, '   ', s.last_name) AS staff_name, a.address
FROM staff s
LEFT JOIN address a 
USING (address_id)
GROUP BY s.staff_id, staff_name
ORDER BY s.staff_id ASC;

-- 6. List each film and the number of actors who are listed for that film:

SELECT f.film_id, f.title, COUNT(fa.actor_id) AS actors_count
FROM film f
JOIN film_actor fa
USING (film_id)
GROUP BY f.film_id, f.title
ORDER BY actors_count DESC;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:

SELECT c.customer_id, CONCAT(c.last_name, ',', '  ', c.first_name) AS customer_name, ROUND(SUM(p.amount),2) AS total_paid_amount
FROM customer c
JOIN payment p
USING (customer_id)
GROUP BY c.customer_id, customer_name
ORDER BY customer_name ASC;

-- 8. List the titles of films per category:

SELECT f.film_id, f.title, c.name AS category
FROM film f
JOIN film_category fc
USING (film_id)
JOIN category c
USING (category_id)
ORDER BY f.film_id ASC;