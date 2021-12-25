/* Indexit */
CREATE INDEX Name_index ON Names_(name_);

/* Hakee 10 suosituinta elokuvaa jolla on yli 10000 ääntä */
CREATE VIEW best_movies AS
SELECT average_rating, num_votes, primary_title
FROM title_ratings, titles
WHERE titles.title_id = title_ratings.title_id and num_votes > 10000 and title_type LIKE '%movie%'
ORDER BY `title_ratings`.`average_rating` DESC LIMIT 10;

/* Hakee Quentin Tarantinon ohgjaamat elokuvat */
CREATE VIEW Tarantino_movies AS
SELECT primary_title
FROM `directors`, `titles`
WHERE name_id LIKE "%nm0000233%" and directors.title_id = titles.title_id and title_type = "movie";

/* Procedure millä haetaan näyttelijöitä ja kertoo kuinka monessa elokuvassa näyttelijä on näytellyt */
DELIMITER $$
CREATE PROCEDURE SearchActors(Actor varchar(100))
    BEGIN
    SELECT N.name_id, N.name_, COUNT(*) AS number_of_films
    FROM Names_ AS N, Had_role AS H, Titles AS T
    WHERE N.name_ LIKE Actor AND T.title_type LIKE '%movie%' AND T.title_id = H.title_id AND N.name_id = H.name_id
    GROUP BY N.name_id ORDER BY `number_of_films` DESC
    LIMIT 10;
    END $$
DELIMITER ;

/* Procedure millä haetaan genren perusteella parhaimmat elokuvat */
DELIMITER $$
CREATE PROCEDURE Genres(search_genre varchar(20))
BEGIN
    SELECT average_rating, num_votes, primary_title
    FROM title_ratings, titles, title_genres
    WHERE titles.title_id = title_ratings.title_id and title_ratings.title_id = title_genres.title_id and num_votes > 50000 and title_type LIKE '%movie%' and 		title_genres.genre LIKE search_genre
    ORDER BY `title_ratings`.`average_rating` DESC LIMIT 10;
END $$
DELIMITER ;
