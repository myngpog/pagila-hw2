/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */

WITH FilmRevenue AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY COALESCE(SUM(p.amount), 0.00) DESC) AS rank,
        f.title,
        COALESCE(SUM(p.amount), 0.00) AS revenue
    FROM
        film f
    LEFT JOIN
        inventory i ON f.film_id = i.film_id
    LEFT JOIN
        rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN
        payment p ON r.rental_id = p.rental_id
    GROUP BY
        f.title
)
SELECT
    rank,
    title,
    revenue,
    SUM(revenue) OVER (ORDER BY rank) AS "total revenue",
    to_char(((100 * SUM(revenue) OVER (ORDER BY rank)) / SUM(revenue) OVER ()), 'FM99.99')
    AS "percent revenue"
FROM
    FilmRevenue
ORDER BY
    rank,
    title,
    "percent revenue";
