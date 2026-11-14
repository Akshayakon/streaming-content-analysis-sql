-- 01_clean.sql : turn netflix_raw (all TEXT, loaded from CSV) into a typed, deduplicated `titles` table.
-- Skills: TRIM/NULLIF, substr/instr string parsing, CASE, window-function dedup.
DROP TABLE IF EXISTS titles;
CREATE TABLE titles AS
WITH trimmed AS (
  SELECT show_id,
         type,
         TRIM(title)                      AS title,
         NULLIF(TRIM(director), '')       AS director,
         NULLIF(TRIM("cast"), '')         AS cast_list,
         NULLIF(TRIM(country), '')        AS country,
         TRIM(date_added)                 AS date_added_txt,
         CAST(release_year AS INTEGER)    AS release_year,
         NULLIF(TRIM(rating), '')         AS rating,
         TRIM(duration)                   AS duration,
         TRIM(listed_in)                  AS listed_in
  FROM netflix_raw
),
parsed AS (
  SELECT *,
    -- 'September 25, 2021' -> 2021-09-25 using instr() on a month lookup string
    CASE WHEN date_added_txt = '' THEN NULL ELSE
      printf('%04d-%02d-%02d',
        CAST(substr(date_added_txt, -4) AS INTEGER),
        (instr('JanFebMarAprMayJunJulAugSepOctNovDec', substr(date_added_txt,1,3)) + 2) / 3,
        CAST(substr(date_added_txt, instr(date_added_txt,' ')+1,
                    instr(date_added_txt,',') - instr(date_added_txt,' ') - 1) AS INTEGER))
    END AS date_added
  FROM trimmed
),
dedup AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY lower(title), type, release_year, director, country
                            ORDER BY CAST(substr(show_id,2) AS INTEGER)) AS rn
  FROM parsed
)
SELECT show_id, type, title, director, cast_list, country, date_added,
       CAST(substr(date_added,1,4) AS INTEGER) AS year_added,
       CAST(substr(date_added,6,2) AS INTEGER) AS month_added,
       release_year, rating,
       CASE WHEN type='Movie'   THEN CAST(substr(duration,1,instr(duration,' ')-1) AS INTEGER) END AS duration_min,
       CASE WHEN type='TV Show' THEN CAST(substr(duration,1,instr(duration,' ')-1) AS INTEGER) END AS seasons,
       listed_in
FROM dedup WHERE rn = 1;

CREATE INDEX idx_titles_type ON titles(type);
CREATE INDEX idx_titles_year ON titles(year_added);
