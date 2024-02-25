/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */

SELECT DISTINCT film.title
from film
left join inventory on film.film_id = inventory.inventory_id
left join rental on inventory.inventory_id = rental.inventory_id
left join customer on rental.customer_id = customer.customer_id
left join address on customer.address_id = address.address_id
left join city on address.city_id = city.city_id
left join country on city.country_id = country.country_id and country.country = 'United States'
where country.country_id is not null and rental.rental_id is not null
order by film.title;
