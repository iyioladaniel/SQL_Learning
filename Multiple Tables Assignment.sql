USE mavenmovies;
/*
-- INNER JOIN
SELECT title, description, store_id, inventory_id
FROM film
	INNER JOIN inventory
		ON film.film_id=inventory.film_id
LIMIT 5000

-- LEFT JOIN
SELECT title, COUNT(actor_id)
FROM film
	LEFT JOIN film_actor
		ON film.film_id=film_actor.film_id
GROUP BY title
LIMIT 5000;

-- Bridging two tables
SELECT 
	actor.actor_id,
	actor.first_name, 
    actor.last_name, 
    film.title
FROM actor
	INNER JOIN film_actor
		ON actor.actor_id=film_actor.actor_id
	INNER JOIN film
        ON film_actor.film_id=film.film_id
ORDER BY actor_id;

-- Multi-Condition JOIN
SELECT DISTINCT film.title,
	film.description
FROM film
	INNER JOIN inventory
		ON film.film_id=inventory.film_id
        AND store_id=2

-- UNION
SELECT 'staff_member' AS type,
	first_name,
    last_name
FROM staff
UNION
SELECT 'advisor' AS type,
	first_name,
    last_name
FROM advisor
ORDER BY type;
*/
