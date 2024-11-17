USE imdb;

/* Utwórz zapytanie SQL dla tabeli films z bazy danych imdb, które zwróci średnie budżety
(budget) i sumę dochodów (gross-budget) dla filmów policzone dla grup utworzonych z
kolejnych lat premier filmów (release_year) po 2015 roku, jeśli wyliczony średni budżet
(budget) jest większy niż 30 milionów dolarów. */
SELECT release_year, AVG(budget) AS avg_budget, SUM(gross-budget) AS total_income
FROM films
GROUP BY release_year
HAVING release_year > 2015
    AND AVG(budget) > 30000000;

SELECT release_year, AVG(budget) AS avg_budget, SUM(gross-budget) AS total_income
FROM films
WHERE release_year > 2015
GROUP BY release_year
HAVING AVG(budget) > 30000000;

/*Przygotuj zapytanie SQL, które poda liczbę aktorów i reżyserów (tabela people z bazy danych
imdb), którzy nie brali udziału w produkcjach filmów (tabela films z bazy danych imdb)
pomiędzy latami 1999 a 2005 (włącznie).*/

SELECT COUNT(*) AS liczba_osob
FROM people AS p
WHERE (
    p.birthdate IS NOT NULL 
    AND p.birthdate < '1999-01-01'
    ) AND (p.deathdate IS NULL OR p.deathdate > '2005-12-31')
    AND p.id NOT IN (
        SELECT f.id
        FROM films AS f
        WHERE f.release_year BETWEEN 1999 AND 2005
    );

/* Przygotuj zapytanie SQL, które wyświetli nazwy państw, dla których średnia ocena filmów
pochodzących z tych państw jest większa niż średnia ocena dla wszystkich filmów.*/

SELECT f.country, AVG(r.imdb_score)
FROM films AS f
    JOIN reviews AS r
    ON f.id = r.film_id
GROUP BY f.country
HAVING AVG(r.imdb_score) > (
    SELECT AVG(r1.imdb_score)
    FROM reviews r1);


/* Przygotuj zapytanie SQL, które wyświetli filmy z lat, dla których średnia ilość polubień na facebooku 
jest większa niż średnia polubień dla wszystkich filmów.*/

SELECT f.release_year, AVG(r.facebook_likes) AS avg_fb_likes
FROM films AS f
    JOIN reviews AS r
        ON f.id = r.film_id
GROUP BY f.release_year
HAVING AVG(r.facebook_likes) > (
    SELECT AVG(facebook_likes)
    FROM reviews
)