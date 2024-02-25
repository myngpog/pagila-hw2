/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 * Order the results alphabetically.
 *
 * HINT:
 * Use `unnest(special_features)` in a subquery.
 */

select title
from film
where rating = 'G' 
and exists (
    select 1
    from unnest(special_features) as feature
    where feature = 'Trailers'
    and film_id = film.film_id
)
order by title;
