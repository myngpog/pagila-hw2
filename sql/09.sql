/*
 * Count the number of movies that contain each type of special feature.
 * Order the results alphabetically be the special_feature.
*/

select feature as special_features, count(*) as count
from film, unnest(special_features) as feature
group by feature
order by special_features;
