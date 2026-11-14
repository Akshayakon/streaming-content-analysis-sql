-- 03_analysis.sql : business questions. Each query starts with "-- name: <slug> | <question>".
-- The runner exports every query to results/<slug>.csv

-- name: q01_content_mix | How is the catalogue split between Movies and TV Shows?
SELECT type, COUNT(*) AS titles,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM titles GROUP BY type ORDER BY titles DESC;

-- name: q02_added_per_year | Titles added per year, YoY growth and running total
WITH y AS (SELECT year_added, COUNT(*) AS added FROM titles WHERE year_added IS NOT NULL GROUP BY year_added)
SELECT year_added, added,
       ROUND(100.0 * (added - LAG(added) OVER (ORDER BY year_added)) / LAG(added) OVER (ORDER BY year_added), 1) AS yoy_pct,
       SUM(added) OVER (ORDER BY year_added) AS cumulative
FROM y ORDER BY year_added;

-- name: q03_type_share_by_year | Is the platform shifting toward TV Shows over time?
SELECT year_added,
       SUM(type='Movie')   AS movies,
       SUM(type='TV Show') AS tv_shows,
       ROUND(100.0 * SUM(type='TV Show') / COUNT(*), 1) AS tv_share_pct
FROM titles WHERE year_added IS NOT NULL GROUP BY year_added ORDER BY year_added;

-- name: q04_top_countries | Top 10 producing countries (co-productions count for every country)
SELECT RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk, country, COUNT(*) AS titles,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM titles WHERE country IS NOT NULL), 1) AS pct_of_titles
FROM title_countries GROUP BY country ORDER BY titles DESC LIMIT 10;

-- name: q05_top_genres_by_type | Top 5 genres within Movies and within TV Shows
SELECT * FROM (
  SELECT t.type, g.genre, COUNT(*) AS titles,
         DENSE_RANK() OVER (PARTITION BY t.type ORDER BY COUNT(*) DESC) AS rnk
  FROM title_genres g JOIN titles t USING (show_id) GROUP BY t.type, g.genre
) WHERE rnk <= 5 ORDER BY type, rnk;

-- name: q06_top_genre_per_country | Top 3 genres in each of the top 5 countries
WITH top_c AS (SELECT country FROM title_countries GROUP BY country ORDER BY COUNT(*) DESC LIMIT 5),
cg AS (
  SELECT c.country, g.genre, COUNT(*) AS titles,
         ROW_NUMBER() OVER (PARTITION BY c.country ORDER BY COUNT(*) DESC, g.genre) AS rn
  FROM title_countries c JOIN title_genres g USING (show_id)
  WHERE c.country IN (SELECT country FROM top_c) GROUP BY c.country, g.genre
)
SELECT country, rn AS rank, genre, titles FROM cg WHERE rn <= 3 ORDER BY country, rn;

-- name: q07_genre_trend | Genre momentum: titles added 2016-2018 vs 2019-2021
SELECT g.genre,
       SUM(t.year_added BETWEEN 2016 AND 2018) AS early,
       SUM(t.year_added BETWEEN 2019 AND 2021) AS recent,
       ROUND(100.0 * (SUM(t.year_added BETWEEN 2019 AND 2021) - SUM(t.year_added BETWEEN 2016 AND 2018))
             / NULLIF(SUM(t.year_added BETWEEN 2016 AND 2018),0), 1) AS growth_pct
FROM title_genres g JOIN titles t USING (show_id)
GROUP BY g.genre ORDER BY growth_pct DESC;

-- name: q08_genre_pairs | Most common genre combinations (self-join on the bridge table)
SELECT a.genre AS genre_a, b.genre AS genre_b, COUNT(*) AS titles
FROM title_genres a JOIN title_genres b ON a.show_id = b.show_id AND a.genre < b.genre
GROUP BY a.genre, b.genre ORDER BY titles DESC LIMIT 10;

-- name: q09_movie_length_by_genre | Average movie runtime by genre (movies only)
SELECT g.genre, COUNT(*) AS movies, ROUND(AVG(t.duration_min),1) AS avg_minutes, MIN(t.duration_min) AS shortest, MAX(t.duration_min) AS longest
FROM titles t JOIN title_genres g USING (show_id)
WHERE t.type='Movie' GROUP BY g.genre ORDER BY avg_minutes DESC;

-- name: q10_season_distribution | How many seasons do TV shows run?
SELECT seasons, COUNT(*) AS shows,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM titles WHERE type='TV Show' GROUP BY seasons ORDER BY seasons;

-- name: q11_rating_by_country | Maturity-rating mix for the top 5 countries
SELECT c.country, COALESCE(t.rating,'Unrated') AS rating, COUNT(*) AS titles,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY c.country), 1) AS pct_within_country
FROM title_countries c JOIN titles t USING (show_id)
WHERE c.country IN (SELECT country FROM title_countries GROUP BY country ORDER BY COUNT(*) DESC LIMIT 5)
GROUP BY c.country, rating ORDER BY c.country, titles DESC;

-- name: q12_release_to_add_lag | How old is content when it lands on the platform? (by year added)
SELECT year_added, ROUND(AVG(year_added - release_year),1) AS avg_age_years,
       ROUND(100.0 * SUM(year_added - release_year <= 1) / COUNT(*), 1) AS pct_new_releases
FROM titles WHERE year_added IS NOT NULL AND year_added >= release_year
GROUP BY year_added ORDER BY year_added;

-- name: q13_top_directors | Most prolific directors (ties share a rank)
SELECT * FROM (
  SELECT d.director, COUNT(*) AS titles,
         SUM(t.type='Movie') AS movies, SUM(t.type='TV Show') AS tv_shows,
         DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
  FROM title_directors d JOIN titles t USING (show_id) GROUP BY d.director
) WHERE rnk <= 5 ORDER BY rnk, director;

-- name: q14_monthly_seasonality | Which months see the most additions?
SELECT month_added, COUNT(*) AS titles,
       ROUND(1.0 * COUNT(*) / COUNT(DISTINCT year_added), 1) AS avg_per_year
FROM titles WHERE month_added IS NOT NULL GROUP BY month_added ORDER BY month_added;

-- name: q15_fastest_growing_countries | Countries with the biggest jump in additions, 2017 to 2020 (min 10 titles in 2020)
WITH cy AS (
  SELECT c.country, SUM(t.year_added = 2017) AS y2017, SUM(t.year_added = 2020) AS y2020
  FROM title_countries c JOIN titles t USING (show_id) GROUP BY c.country
)
SELECT country, y2017, y2020, y2020 - y2017 AS abs_change,
       ROUND(100.0 * (y2020 - y2017) / NULLIF(y2017,0), 1) AS pct_change
FROM cy WHERE y2020 >= 10 ORDER BY abs_change DESC LIMIT 10;

-- name: q16_titles_by_decade | Titles by release decade with 3-decade moving average
WITH d AS (SELECT (release_year/10)*10 AS decade, COUNT(*) AS titles FROM titles GROUP BY decade)
SELECT decade, titles,
       ROUND(AVG(titles) OVER (ORDER BY decade ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),1) AS moving_avg_3
FROM d ORDER BY decade;

-- name: q17_data_quality | Share of missing values per column (cleaning audit)
SELECT ROUND(100.0*SUM(director IS NULL)/COUNT(*),1) AS director_missing_pct,
       ROUND(100.0*SUM(cast_list IS NULL)/COUNT(*),1) AS cast_missing_pct,
       ROUND(100.0*SUM(country IS NULL)/COUNT(*),1)  AS country_missing_pct,
       ROUND(100.0*SUM(rating IS NULL)/COUNT(*),1)   AS rating_missing_pct,
       ROUND(100.0*SUM(date_added IS NULL)/COUNT(*),1) AS date_added_missing_pct,
       (SELECT COUNT(*) FROM netflix_raw) - COUNT(*) AS duplicates_removed
FROM titles;
