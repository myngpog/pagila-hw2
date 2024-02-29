/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */

SELECT DISTINCT film.title
from film
join inventory using (film_id)
left join (
    select (inventory.film_id)
    from inventory
    join rental using (inventory_id)
    join customer using (customer_id)
    join address using (address_id)
    join city using (city_id)
    join country using (country_id)
    where country.country = 'United States'
) as rented_in_us on inventory.film_id = rented_in_us.film_id
where rented_in_us.film_id is null
order by film.title;
