/*
 * Select the titles of all films that the customer with customer_id=1 has rented more than 1 time.
 *
 * HINT:
 * It's possible to solve this problem both with and without subqueries.
 */

select title
from film
join inventory using (film_id)
join rental using (inventory_id)
where customer_id = 1
group by title
having count(rental_id) > 1;
