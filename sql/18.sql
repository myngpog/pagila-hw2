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
        RANK() OVER (ORDER BY COALESCE(SUM(p.amount), 0.00) DESC) AS "rank",
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
), TotalRevenue AS (
    SELECT
        SUM(revenue) AS "total revenue"
    FROM
        FilmRevenue
)
SELECT
    "rank",
    title,
    revenue,
    "total revenue",
    TO_CHAR((100 * "total revenue") / SUM(revenue) OVER (), 'FM900.00') AS "percent revenue"
FROM
    (
        SELECT
            "rank",
            title,
            revenue,
            SUM(revenue) OVER (ORDER BY revenue DESC) AS "total revenue"
        FROM
            (
                SELECT
                    RANK() OVER (ORDER BY COALESCE(SUM(p.amount), 0.00) DESC) AS "rank",
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
            ) as s1
    ) as s2
ORDER BY
    revenue DESC,
    title;
