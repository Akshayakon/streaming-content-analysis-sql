# Streaming Content Analysis - results


## q01_content_mix
**How is the catalogue split between Movies and TV Shows?**

| type | titles | pct |
|---|---|---|
| Movie | 5377 | 69.1 |
| TV Show | 2410 | 30.9 |

## q02_added_per_year
**Titles added per year, YoY growth and running total**

| year_added | added | yoy_pct | cumulative |
|---|---|---|---|
| 2008 | 2 |  | 2 |
| 2009 | 2 | 0.0 | 4 |
| 2010 | 1 | -50.0 | 5 |
| 2011 | 13 | 1200.0 | 18 |
| 2012 | 3 | -76.9 | 21 |
| 2013 | 11 | 266.7 | 32 |
| 2014 | 25 | 127.3 | 57 |
| 2015 | 88 | 252.0 | 145 |
| 2016 | 443 | 403.4 | 588 |
| 2017 | 1225 | 176.5 | 1813 |
| 2018 | 1685 | 37.6 | 3498 |
| 2019 | 2153 | 27.8 | 5651 |
| 2020 | 2009 | -6.7 | 7660 |
| 2021 | 117 | -94.2 | 7777 |

## q03_type_share_by_year
**Is the platform shifting toward TV Shows over time?**

| year_added | movies | tv_shows | tv_share_pct |
|---|---|---|---|
| 2008 | 1 | 1 | 50.0 |
| 2009 | 2 | 0 | 0.0 |
| 2010 | 1 | 0 | 0.0 |
| 2011 | 13 | 0 | 0.0 |
| 2012 | 3 | 0 | 0.0 |
| 2013 | 6 | 5 | 45.5 |
| 2014 | 19 | 6 | 24.0 |
| 2015 | 58 | 30 | 34.1 |
| 2016 | 258 | 185 | 41.8 |
| 2017 | 864 | 361 | 29.5 |
| 2018 | 1255 | 430 | 25.5 |
| 2019 | 1497 | 656 | 30.5 |
| 2020 | 1312 | 697 | 34.7 |
| 2021 | 88 | 29 | 24.8 |

## q04_top_countries
**Top 10 producing countries (co-productions count for every country)**

| rnk | country | titles | pct_of_titles |
|---|---|---|---|
| 1 | United States | 3297 | 45.3 |
| 2 | India | 990 | 13.6 |
| 3 | United Kingdom | 723 | 9.9 |
| 4 | Canada | 412 | 5.7 |
| 5 | France | 349 | 4.8 |
| 6 | Japan | 287 | 3.9 |
| 7 | Spain | 215 | 3.0 |
| 8 | South Korea | 212 | 2.9 |
| 9 | Germany | 199 | 2.7 |
| 10 | Mexico | 154 | 2.1 |

## q05_top_genres_by_type
**Top 5 genres within Movies and within TV Shows**

| type | genre | titles | rnk |
|---|---|---|---|
| Movie | International Movies | 2437 | 1 |
| Movie | Dramas | 2106 | 2 |
| Movie | Comedies | 1471 | 3 |
| Movie | Documentaries | 786 | 4 |
| Movie | Action & Adventure | 721 | 5 |
| TV Show | International TV Shows | 1199 | 1 |
| TV Show | TV Dramas | 704 | 2 |
| TV Show | TV Comedies | 525 | 3 |
| TV Show | Crime TV Shows | 427 | 4 |
| TV Show | Kids' TV | 414 | 5 |

## q06_top_genre_per_country
**Top 3 genres in each of the top 5 countries**

| country | rank | genre | titles |
|---|---|---|---|
| Canada | 1 | Comedies | 81 |
| Canada | 2 | Dramas | 71 |
| Canada | 3 | Children & Family Movies | 68 |
| France | 1 | International Movies | 191 |
| France | 2 | Dramas | 145 |
| France | 3 | Independent Movies | 61 |
| India | 1 | International Movies | 828 |
| India | 2 | Dramas | 626 |
| India | 3 | Comedies | 308 |
| United Kingdom | 1 | British TV Shows | 212 |
| United Kingdom | 2 | Dramas | 156 |
| United Kingdom | 3 | International Movies | 149 |
| United States | 1 | Dramas | 716 |
| United States | 2 | Comedies | 588 |
| United States | 3 | Documentaries | 478 |

## q07_genre_trend
**Genre momentum: titles added 2016-2018 vs 2019-2021**

| genre | early | recent | growth_pct |
|---|---|---|---|
| Classic Movies | 22 | 81 | 268.2 |
| Teen TV Shows | 14 | 44 | 214.3 |
| Reality TV | 62 | 160 | 158.1 |
| TV Horror | 19 | 48 | 152.6 |
| Cult Movies | 18 | 40 | 122.2 |
| TV Action & Adventure | 46 | 101 | 119.6 |
| Anime Series | 48 | 99 | 106.3 |
| TV Sci-Fi & Fantasy | 24 | 48 | 100.0 |
| TV Thrillers | 16 | 31 | 93.8 |
| Romantic Movies | 186 | 344 | 84.9 |
| Children & Family Movies | 182 | 331 | 81.9 |
| TV Mysteries | 31 | 56 | 80.6 |
| Comedies | 541 | 913 | 68.8 |
| Spanish-Language TV Shows | 57 | 89 | 56.1 |
| Sci-Fi & Fantasy | 84 | 130 | 54.8 |
| Korean TV Shows | 60 | 90 | 50.0 |
| Kids' TV | 160 | 237 | 48.1 |
| Horror Movies | 125 | 183 | 46.4 |
| Thrillers | 199 | 288 | 44.7 |
| Action & Adventure | 304 | 414 | 36.2 |

## q08_genre_pairs
**Most common genre combinations (self-join on the bridge table)**

| genre_a | genre_b | titles |
|---|---|---|
| Dramas | International Movies | 1295 |
| Comedies | International Movies | 732 |
| Dramas | Independent Movies | 514 |
| International TV Shows | TV Dramas | 469 |
| Comedies | Dramas | 436 |
| Action & Adventure | International Movies | 353 |
| International Movies | Romantic Movies | 330 |
| International TV Shows | Romantic TV Shows | 285 |
| Crime TV Shows | International TV Shows | 269 |
| Documentaries | International Movies | 263 |

## q09_movie_length_by_genre
**Average movie runtime by genre (movies only)**

| genre | movies | avg_minutes | shortest | longest |
|---|---|---|---|---|
| Classic Movies | 103 | 115.6 | 18 | 228 |
| Dramas | 2106 | 113.4 | 8 | 312 |
| Action & Adventure | 721 | 113.3 | 5 | 214 |
| International Movies | 2437 | 110.8 | 5 | 312 |
| Romantic Movies | 531 | 110.7 | 46 | 233 |
| Music & Musicals | 321 | 108.7 | 15 | 224 |
| Thrillers | 491 | 106.9 | 28 | 171 |
| Sci-Fi & Fantasy | 218 | 105.8 | 3 | 312 |
| Faith & Spirituality | 57 | 105.2 | 32 | 205 |
| Cult Movies | 59 | 104.7 | 47 | 172 |
| Comedies | 1471 | 104.6 | 23 | 253 |
| Independent Movies | 673 | 100.8 | 15 | 189 |
| Horror Movies | 312 | 97.5 | 29 | 171 |
| Sports Movies | 196 | 95.4 | 12 | 161 |
| LGBTQ Movies | 90 | 94.0 | 17 | 132 |
| Anime Features | 57 | 91.2 | 5 | 130 |
| Documentaries | 786 | 81.4 | 10 | 208 |
| Children & Family Movies | 532 | 79.7 | 3 | 152 |
| Stand-Up Comedy | 329 | 67.1 | 28 | 146 |
| Movies | 56 | 45.9 | 14 | 92 |

## q10_season_distribution
**How many seasons do TV shows run?**

| seasons | shows | pct |
|---|---|---|
| 1 | 1608 | 66.7 |
| 2 | 382 | 15.9 |
| 3 | 184 | 7.6 |
| 4 | 87 | 3.6 |
| 5 | 58 | 2.4 |
| 6 | 30 | 1.2 |
| 7 | 19 | 0.8 |
| 8 | 18 | 0.7 |
| 9 | 8 | 0.3 |
| 10 | 6 | 0.2 |
| 11 | 3 | 0.1 |
| 12 | 2 | 0.1 |
| 13 | 2 | 0.1 |
| 15 | 2 | 0.1 |
| 16 | 1 | 0.0 |

## q11_rating_by_country
**Maturity-rating mix for the top 5 countries**

| country | rating | titles | pct_within_country |
|---|---|---|---|
| Canada | TV-MA | 100 | 24.3 |
| Canada | R | 68 | 16.5 |
| Canada | TV-14 | 47 | 11.4 |
| Canada | TV-Y | 45 | 10.9 |
| Canada | TV-PG | 39 | 9.5 |
| Canada | TV-Y7 | 35 | 8.5 |
| Canada | PG-13 | 28 | 6.8 |
| Canada | PG | 23 | 5.6 |
| Canada | TV-G | 17 | 4.1 |
| Canada | NR | 5 | 1.2 |
| Canada | G | 2 | 0.5 |
| Canada | NC-17 | 1 | 0.2 |
| Canada | TV-Y7-FV | 1 | 0.2 |
| Canada | UR | 1 | 0.2 |
| France | TV-MA | 152 | 43.6 |
| France | R | 49 | 14.0 |
| France | TV-14 | 43 | 12.3 |
| France | PG-13 | 22 | 6.3 |
| France | TV-Y7 | 21 | 6.0 |
| France | PG | 18 | 5.2 |

## q12_release_to_add_lag
**How old is content when it lands on the platform? (by year added)**

| year_added | avg_age_years | pct_new_releases |
|---|---|---|
| 2008 | 1.5 | 50.0 |
| 2009 | 1.0 | 50.0 |
| 2010 | 23.0 | 0.0 |
| 2011 | 19.9 | 7.7 |
| 2012 | 1.0 | 66.7 |
| 2013 | 0.9 | 80.0 |
| 2014 | 3.6 | 80.0 |
| 2015 | 1.3 | 81.8 |
| 2016 | 3.0 | 64.6 |
| 2017 | 4.0 | 58.8 |
| 2018 | 4.1 | 54.6 |
| 2019 | 5.3 | 51.6 |
| 2020 | 4.6 | 56.3 |
| 2021 | 9.6 | 36.8 |

## q13_top_directors
**Most prolific directors (ties share a rank)**

| director | titles | movies | tv_shows | rnk |
|---|---|---|---|---|
| Jan Suter | 21 | 21 | 0 | 1 |
| Raúl Campos | 19 | 19 | 0 | 2 |
| Marcus Raboy | 16 | 15 | 1 | 3 |
| Jay Karas | 15 | 15 | 0 | 4 |
| Cathy Garcia-Molina | 13 | 13 | 0 | 5 |

## q14_monthly_seasonality
**Which months see the most additions?**

| month_added | titles | avg_per_year |
|---|---|---|
| 1 | 757 | 84.1 |
| 2 | 472 | 52.4 |
| 3 | 669 | 95.6 |
| 4 | 601 | 85.9 |
| 5 | 543 | 67.9 |
| 6 | 542 | 77.4 |
| 7 | 600 | 85.7 |
| 8 | 618 | 77.3 |
| 9 | 619 | 68.8 |
| 10 | 785 | 87.2 |
| 11 | 738 | 67.1 |
| 12 | 833 | 92.6 |

## q15_fastest_growing_countries
**Countries with the biggest jump in additions, 2017 to 2020 (min 10 titles in 2020)**

| country | y2017 | y2020 | abs_change | pct_change |
|---|---|---|---|---|
| United States | 471 | 888 | 417 | 88.5 |
| Egypt | 0 | 52 | 52 |  |
| France | 54 | 99 | 45 | 83.3 |
| Canada | 71 | 115 | 44 | 62.0 |
| Nigeria | 1 | 42 | 41 | 4100.0 |
| India | 163 | 203 | 40 | 24.5 |
| Japan | 45 | 83 | 38 | 84.4 |
| United Kingdom | 134 | 167 | 33 | 24.6 |
| Philippines | 1 | 32 | 31 | 3100.0 |
| Germany | 33 | 63 | 30 | 90.9 |

## q16_titles_by_decade
**Titles by release decade with 3-decade moving average**

| decade | titles | moving_avg_3 |
|---|---|---|
| 1920 | 1 | 1.0 |
| 1940 | 14 | 7.5 |
| 1950 | 11 | 8.7 |
| 1960 | 25 | 16.7 |
| 1970 | 67 | 34.3 |
| 1980 | 106 | 66.0 |
| 1990 | 225 | 132.7 |
| 2000 | 728 | 353.0 |
| 2010 | 5711 | 2221.3 |
| 2020 | 899 | 2446.0 |

## q17_data_quality
**Share of missing values per column (cleaning audit)**

| director_missing_pct | cast_missing_pct | country_missing_pct | rating_missing_pct | date_added_missing_pct | duplicates_removed |
|---|---|---|---|---|---|
| 30.7 | 9.2 | 6.5 | 0.1 | 0.1 | 0 |
