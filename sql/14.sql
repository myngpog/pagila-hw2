/*
 * Create a report that shows the total revenue per month and year.
 *
 * HINT:
 * This query is very similar to the previous problem,
 * but requires an additional JOIN.
 */

select
    extract(year from r.rental_date) as "Year",
    extract(month from r.rental_date) as "Month",
    sum(p.amount) as "Total Revenue"
from rental r
join payment p on r.rental_id = p.rental_id
group by rollup(extract(year from r.rental_date), extract(month from r.rental_date))
order by "Year", "Month";
