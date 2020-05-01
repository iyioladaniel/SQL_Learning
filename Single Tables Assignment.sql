use mavenmovies; #telling SQL to use mavenmovies sever
/* SELECT first_name, last_name, email FROM customer

SELECT DISTINCT rating FROM film

SELECT DISTINCT rental_duration FROM film;

SELECT customer_id, rental_id, amount, payment_date FROM payment
WHERE customer_id <= 100
	AND amount > 5
    AND payment_date >= '2006-01-06';

SELECT customer_id, rental_id, amount, payment_date  FROM payment
WHERE amount > 5 
	OR customer_id = 42
    OR customer_id = 53
    OR customer_id = 60
    OR customer_id = 75;
    
SELECT customer_id, rental_id, amount, payment_date  FROM payment
WHERE amount > 5 
	OR customer_id IN (42,53,60,75);
    
SELECT title,special_features FROM film
WHERE special_features LIKE "%Behind the scene%";

SELECT rental_duration, COUNT(film_id) AS no_of_movies_with_rental_duration FROM film
GROUP BY rental_duration #Can group by multiple columns

SELECT replacement_cost,
	COUNT(film_id) AS no_of_films,
	AVG(rental_rate) AS avg_rental_rate,
    MIN(rental_rate) AS min_rental_rate,
    MAX(rental_rate) AS max_rental_rate
    FROM film
GROUP BY replacement_cost;

SELECT customer_id,
	COUNT(*) AS total_rentals
    FROM rental
GROUP BY customer_id
HAVING total_rentals <15

SELECT title, length, rental_rate FROM film
ORDER BY length DESC;

SELECT first_name, last_name,
CASE 
	WHEN store_id = 1 THEN 'store 1 active'
	WHEN store_id = 2 THEN 'store 2 active'
	ELSE 'Hey! I am a customer too?!'
END AS store_and_status
FROM customer
ORDER BY first_name;

SELECT store_id,
	COUNT(CASE WHEN active = 1 THEN customer_id ELSE NULL END) AS active,
	COUNT(CASE WHEN active = 0 THEN customer_id ELSE NULL END) AS inactive
FROM customer
GROUP BY store_id
*/