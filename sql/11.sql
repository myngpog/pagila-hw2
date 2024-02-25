/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */

select distinct actor.first_name || ' ' ||actor.last_name as "Actor Name"
from actor
join film_actor on actor.actor_id = film_actor.actor_id
join film on film_actor.film_id = film.film_id
where 'Behind the Scenes' in (select unnest(film.special_features))
order by "Actor Name";
