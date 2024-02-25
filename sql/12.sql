/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */

/* behind the scenes table */
with bts_movies as (
    select distinct film.title
    from film
    where 'Behind the Scenes' in (select unnest(film.special_features))
    order by title
),

/* trailer movies table */
t_movies as (
    select distinct film.title
    from film
    where 'Trailers' in (select unnest(film.special_features))
    order by title
) 

select t.title
from t_movies t
inner join bts_movies b on t.title = b.title;
