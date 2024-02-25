/*
 * This problem is the same as 05.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */

select actor.last_name, actor.first_name
from actor
left join customer on actor.last_name = customer.last_name and actor.first_name = customer.first_name
where customer_id is null
order by last_name, first_name;
