/*
 * Compute the total revenue for each film.
 * The output should include another new column "total revenue" that shows the sum of all the revenue of all previous films.
 *
 * HINT:
 * My solution starts with the solution to problem 16 as a subquery.
 * Then I combine the SUM function with the OVER keyword to create a window function that computes the total.
 * You might find the following stackoverflow answer useful for figuring out the syntax:
 * <https://stackoverflow.com/a/5700744>.
 */

with film_revenue as (
    select
        rank() over (order by coalesce(sum(p.amount), 0.00) desc) as rank,
        f.title,
        coalesce(sum(p.amount),0.00) as revenue
    from film f
    left join inventory i on f.film_id = i.film_id
    left join rental r on i.inventory_id = r.inventory_id
    left join payment p on r.rental_id = p.rental_id
    group by f.title
    order by revenue desc
) 
select
    rank,
    title,
    revenue,
    sum(revenue) over (order by rank) as "total revenue"
from film_revenue
order by rank, title;
