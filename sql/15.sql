/*
 * Compute the total revenue for each film.
 */

select f.title, coalesce(sum(p.amount), 0.00) as revenue
from film f
left join inventory i on f.film_id = i.film_id
left join rental r on i.inventory_id = r.inventory_id
left join payment p on r.rental_id = p.rental_id
group by f.title
order by revenue desc, length(f.title) desc, f.title desc;
