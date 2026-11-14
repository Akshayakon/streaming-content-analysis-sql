-- 02_split.sql : normalise comma-separated columns into one-row-per-value bridge tables.
-- Technique: recursive CTE that peels off the text before each comma (SQLite has no STRING_SPLIT).
-- SQL Server: STRING_SPLIT / CROSS APPLY.  Postgres: unnest(string_to_array(col, ',')).

DROP TABLE IF EXISTS title_genres;
CREATE TABLE title_genres AS
WITH RECURSIVE split(show_id, genre, rest) AS (
  SELECT show_id, '', listed_in || ',' FROM titles WHERE listed_in IS NOT NULL
  UNION ALL
  SELECT show_id,
         TRIM(substr(rest, 1, instr(rest, ',') - 1)),
         substr(rest, instr(rest, ',') + 1)
  FROM split WHERE rest <> ''
)
SELECT show_id, genre FROM split WHERE genre <> '';

DROP TABLE IF EXISTS title_countries;
CREATE TABLE title_countries AS
WITH RECURSIVE split(show_id, country, rest) AS (
  SELECT show_id, '', country || ',' FROM titles WHERE country IS NOT NULL
  UNION ALL
  SELECT show_id,
         TRIM(substr(rest, 1, instr(rest, ',') - 1)),
         substr(rest, instr(rest, ',') + 1)
  FROM split WHERE rest <> ''
)
SELECT DISTINCT show_id, country FROM split WHERE country <> '';

DROP TABLE IF EXISTS title_directors;
CREATE TABLE title_directors AS
WITH RECURSIVE split(show_id, director, rest) AS (
  SELECT show_id, '', director || ',' FROM titles WHERE director IS NOT NULL
  UNION ALL
  SELECT show_id,
         TRIM(substr(rest, 1, instr(rest, ',') - 1)),
         substr(rest, instr(rest, ',') + 1)
  FROM split WHERE rest <> ''
)
SELECT DISTINCT show_id, director FROM split WHERE director <> '';

CREATE INDEX idx_tg ON title_genres(genre);
CREATE INDEX idx_tc ON title_countries(country);
