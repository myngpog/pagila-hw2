/*
 * Management wants to send coupons to customers who have previously rented one of the top-5 most profitable movies.
 * Your task is to list these customers.
 *
 * HINT:
 * In problem 16 of pagila-hw1, you ordered the films by most profitable.
 * Modify this query so that it returns only the film_id of the top 5 most profitable films.
 * This will be your subquery.
 * 
 * Next, join the film, inventory, rental, and customer tables.
 * Use a where clause to restrict results to the subquery.
 */

/* instead of separating the subquery, I will make it inside the one for practice*/

select distinct customer_id
from customer
join rental using (customer_id)
join inventory using (inventory_id)
join film using (film_id)
where film_id in (
    select film_id
    from (
        select film_id, sum(amount) as profit
        from film
        join inventory using (film_id)
        join rental using (inventory_id)
        join payment using (rental_id)
        group by film_id
        order by profit desc
        limit 5
    ) as top_movies
)
order by customer_id;
