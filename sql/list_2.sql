-- Pobierz plik z bazą danych filmów z serwisu IMDB oraz bazę danych opisujących państwa i odtwórz bazy na serwerze SQL.
USE imdb;
USE countries2;

-- Sprawdź z pomocą MS SQL Server Management Studio, z jakich tabel składa się baza IMDB i countries.
SELECT
    'imdb'
    TABLE_SCHEMA,
    TABLE_NAME
FROM imdb.INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
UNION ALL
SELECT
    'countries2'
    TABLE_SCHEMA,
    TABLE_NAME
FROM countries2.INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- Posortuj rosnąco nazwiska ludzi z tabeli people według kolumny name.
SELECT name
FROM people
ORDER BY name;

-- Wyświetl nazwiska z tabeli people posortowane rosnąco według daty urodzenia.
SELECT name, birthdate
FROM people
ORDER BY birthdate;

-- Wyświetl tytuły filmów, mających premierę w roku 2000 lub 2012 z tabeli films posortowane według roku premiery (release_year)
SELECT title, release_year
FROM films
WHERE release_year IN (2000, 2012)
ORDER BY release_year;

-- Wyświetl wszystkie dane na temat filmów (z tabeli films) z poszczególnych lat poza filmami mającymi premierę w roku 2015 i posortuj je rosnąco według czasu ich trwania (duration).
SELECT *
FROM films
WHERE release_year NOT IN (2015)
ORDER BY duration;

-- Wyświetl tytuły filmów zaczynających się na literę ‘M’ oraz ich przychody (gross) posortowane alfabetycznie.
SELECT title, gross 
FROM films
WHERE title LIKE 'M%'
ORDER BY title;

-- Pobierz punkty IMDB oraz identyfikatory filmów dla wszystkich filmów z tabeli reviews posortowane malejącą zgodnie z punktacją.
SELECT imdb_score, film_id
FROM reviews
ORDER BY imdb_score DESC;

-- Wyświetl tytuły filmów z tabeli films w odwrotnej kolejności alfabetycznej
SELECT title
FROM films
ORDER BY title DESC;

-- Wyświetl tytuły filmów i czas ich trwania od najdłuższego do najkrótszego filmu
SELECT title, duration
FROM films
ORDER BY duration DESC;

-- Pobierz daty urodzenia oraz nazwiska osób z tabeli people w kolejności ich urodzenia, w przypadku tych samych dat zastosuj kolejność alfabetyczną
SELECT birthdate, name
FROM people
ORDER BY birthdate, name;

-- Pobierz tytuł filmu, rok premiery (release_year) oraz czas trwania (duration) w kolejności roku premiery oraz czasu trwania
SELECT title, release_year, duration
FROM films
ORDER BY release_year, duration;

-- Pobierz certyfikaty (certification), rok premiery oraz tytuł filmu posortowane według certyfikatu (alfabetycznie) i roku premiery
SELECT certification, release_year, title
FROM films
ORDER BY certification, release_year;

-- Pobierz daty urodzenia i nazwiska osób z tabeli people tak, aby były posortowane według nazwiska i daty urodzenia
SELECT birthdate, name
FROM people
ORDER BY name, birthdate;

-- Wyświetl liczbę filmów, które miały premierę w danym roku, wyświetl również lata premier filmów obok policzonych agregatów
SELECT release_year, COUNT(*) AS numbers_of_films
FROM films
GROUP BY release_year;

-- Pobierz lata premier filmów oraz średnie czasy trwania filmów pogrupowanych względem roku premiery
SELECT release_year, AVG(duration) AS avg_duration
FROM films
GROUP BY release_year;

-- Wyświetl dla kolejnych lat budżety filmów, które w danym roku miały największy budżet, wyświetl również lata premier filmów obok policzonych agregatów
SELECT release_year, MAX(gross) AS max_gross
FROM films
GROUP BY release_year;

-- Wyświetl punktację IMDB (imdb_score) oraz liczbę recenzji filmów pogrupowane względem imdb_score zapisanych w tabeli reviews.
SELECT imdb_score, COUNT(*) AS numbers_of_reviews
FROM reviews
GROUP BY imdb_score;

-- Pobierz najniższe uzyskane dochody z filmów pogrupowane po kolejnych latach premier filmów, wyświetl również lata premier filmów obok agregatów policzonych dla grup.
SELECT release_year, MIN(gross)
FROM films
GROUP BY release_year;

-- Pobierz sumy dochodów dla filmów pogrupowanych po poszczególnych językach (language), wyświetl również języki filmów obok agregatów policzonych dla grup
SELECT language, SUM(gross)
FROM films
GROUP BY language;

-- Wyświetl sumę budżetów filmów z podziałem na państwa (country), wyświetl również nazwy państw dla policzonych agregatów
SELECT country, SUM(gross) AS sum_gross
FROM films
GROUP BY country;

/* Wyświetl największe budżety (budget) filmów wyznaczone dla grup powstałych dla
poszczególnych państw i lat premier filmów. Posortuj wyniki rosnąco po latach premier i
nazwach państw. Wyświetl przy każdym agregacie nazwę państwa oraz rok premiery.*/
SELECT country, release_year, MAX(gross) AS max_gross
FROM films
GROUP BY country, release_year
ORDER BY release_year, country;

/* Wyświetl wartości najniższych dochodów (gross) wyznaczonych dla grup powstałych z
podziału na państwa i lata premier filmów (tabela films). Posortuj wyniki po nazwach państw i
latach premier. Wyświetl przy każdym agregacie nazwę państwa oraz rok premiery.*/
SELECT country, release_year, MIN(gross) AS min_gross
FROM films
GROUP BY country, release_year
ORDER BY country, release_year;

/* Utwórz zapytanie, które zwróci średnie budżety i średnie dochody dla filmów policzone dla
grup utworzonych z kolejnych lat premier filmów po 1990 roku, jeśli wyliczony średni budżet
jest większy niż 60 milionów dolarów.*/
SELECT AVG(budget) AS avg_budget
    , AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000;

/* Podaj państwa (country) oraz średnie budżety filmów (budget) i średnie dochody (gross) w
rozbiciu na państwa, które nakręciły ponad 10 filmów. Uporządkuj wyniki według nazwy
państwa i ogranicz liczbę wyświetlanych wyników do 5.*/
SELECT country
    , AVG(budget) AS avg_budget
    , AVG(gross) AS avg_gross
FROM films
GROUP BY country
HAVING COUNT(title) > 10
ORDER BY country OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY;

/* Połącz tabelę countries z tabelą economies nadając im odpowiednio aliasy c i e. Pobierz z
wyniku łączenia atrybuty: c.code (nadaj mu alias country_code), country_name, year i inflation_rate */
SELECT c.code AS country_code
    , c.country_name
    , e.year
    , e.inflation_rate
FROM countries AS c
    INNER JOIN economies AS e
        ON c.code = e.code;

/* Wyznacz dla każdego kraju: kod kraju (code), nazwę kraju (country_name), jego region
(region), współczynnik dzietności (fertility_rate) i stopę bezrobocia (unemployment_rate) w
2010 i 2015 r. z połączenia tabel countries (alias c), populations (alias p) i economies (alias e)*/
SELECT c.code AS country_code
    , c.country_name
    , c.region
    , p.fertility_rate
    , e.unemployment_rate
FROM countries AS c
    INNER JOIN populations AS p
        ON c.code = p.country_code
    INNER JOIN economies AS e
        ON c.code = e.code
WHERE e.year IN (2010, 2015);

/* Zmodyfikuj zapytanie tak by wyznaczyć procentowy wzrost populacji, jako atrybut o
nazwie growth_perc */
SELECT p1.country_code, p1.size AS size2010, p2.size AS size2015,
((p2.size - p1.size)/p1.size * 100.0) AS growth_perc
FROM populations AS p1
    INNER JOIN populations AS p2
        ON p1.country_code = p2.country_code
        AND p1.year = p2.year - 5;

-- Utwórz nową tabelę o nazwie countries_plus2 z wykorzystaniem polecenia INTO
SELECT country_name, continent, code, surface_area,
    CASE WHEN surface_area > 2000000
        THEN 'large'
    WHEN surface_area > 350000
        THEN 'medium'
    ELSE 'small' END
    AS geosize_group
INTO countries_plus2
FROM countries;

/* Utwórz nową tabelę pop_plus na podstawie tabeli populations tak, aby nowa tabela
zawierała atrybuty country_code, size oraz popsize_group gdzie popsize_group przyjmuje
wartości na podstawie atrybutu size odpowiednio gdy size > 50000000 to
popsize_group=’large’, gdy 50000000 > size > 1000000 to popsize_group=’medium’ i gdy
size < 1000000 to popsize_group=’small’. */
SELECT country_code, size,
    CASE WHEN size > 50000000
        THEN 'large'
    WHEN size > 1000000
        THEN 'medium'
    ELSE 'small' END
    AS popsize_group
INTO pop_plus
FROM populations;

-- Wyświetl zawartość tabeli pop_plus
SELECT *
FROM pop_plus;

/* Przygotuj zapytanie, które połączy tabelę countries_plus (alias c) z tabelą pop_plus (alias p)
na podstawie wspólnego atrybutu code. Posortuj wyniki według atrybutu geosize_group. Jako
wynik wyświetl atrybuty: country_name, continent, geosize_group, i popsize_group */
SELECT c.country_name, c.continent, c.geosize_group, p.popsize_group
FROM countries_plus2 AS c
    INNER JOIN pop_plus AS p
        ON c.code = p.country_code
ORDER BY geosize_group;