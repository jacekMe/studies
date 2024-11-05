-- Pobierz plik z bazą danych filmów z serwisu IMDB (prowadzący zajęcia wskaże skąd pobrać plik) i odtwórz bazę na serwerze SQL.
USE imdb;

-- Sprawdź z pomocą MS SQL Server Management Studio, z jakich tabel składa się baza IMDB.
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- Pobierz kolumnę title z tabeli films.
SELECT title
FROM films;

-- Pobierz kolumnę release_year z tabeli films.
SELECT release_year
FROM films;

-- Wyświetl nazwiska (name) wszystkich osób z tabeli people.
SELECT name
FROM people;

-- Pobierz kolumnę title i release_year z tabeli films
SELECT title, release_year
FROM films;

-- Pobierz kolumnę title, release_year oraz country z tabeli films
SELECT title, release_year, country
FROM films;

-- Pobierz wszystkie kolumny z tabeli films
SELECT *
FROM films;

-- Pobierz unikalne wartości z kolumny country z tabeli films
SELECT DISTINCT country
FROM films;

-- Zweryfikuj w tabeli films jakie rodzaje certyfikatów są przyznawane filmom.
SELECT certification
FROM films;

-- Pobierz unikalne wartości nazwy stanowisk (role) z tabeli roles
SELECT DISTINCT role
FROM roles;

-- Sprawdź ile rekordów zawiera tabela reviews
SELECT COUNT(*)
FROM reviews;

-- Sprawdź z ilu wierszy składa się tabela people
SELECT COUNT(*)
FROM people;

-- Zlicz ile jest dat urodzenia w tabeli people
SELECT COUNT(birthdate)
FROM people;

-- Zlicz ile jest unikalnych języków w tabeli films
SELECT COUNT(language)
FROM films;

-- Zlicz ile jest unikalnych nazw krajów w tabeli films
SELECT COUNT(DISTINCT country)
FROM films;

-- Wyświetl wszystkie informacje na temat filmów, których premiera była w 2016 roku.
SELECT *
FROM films
WHERE release_year = '2016';

-- Zlicz ile filmów wyprodukowano przed rokiem 2000.
SELECT COUNT(*)
FROM films
WHERE release_year < '2000';

-- Pobierz tytuły i lata wydania filmów (release_year) po 2000 roku
SELECT title, release_year
FROM films
WHERE release_year > '2000';

-- Wyświetl informacje na temat wszystkich francuskojęzycznych filmów
SELECT *
FROM films
WHERE language = 'FRENCH';

-- Pobierz nazwisko oraz datę urodzenia osób urodzonych 11 listopada 1974 roku.
SELECT name, birthdate
FROM people
WHERE birthdate = '1974-11-11';

-- Zlicz ile jest filmów w języku Hindi
SELECT COUNT(*)
FROM films
WHERE language = 'HINDI';

-- Wyświetl dane filmów posiadających certyfikat R
SELECT *
FROM films
WHERE certification = 'R';

-- Pobierz tytuły oraz lata wydań filmów hiszpańskojęzycznych wydanych przed rokiem 2000.
SELECT title, release_year
FROM films
WHERE language = 'Spanish'
AND release_year < '2000';

-- Wyświetl wszystkie dane na temat filmów hiszpańskojęzycznych wydanych po roku 2000
SELECT *
FROM films
WHERE language = 'Spanish'
AND release_year > '2000';

-- Pobierz wszystkie dane na temat filmów hiszpańskojęzycznych wydanych po 2000 roku, ale przed rokiem 2010.
SELECT *
FROM films
WHERE language = 'Spanish'
AND release_year > 2000 
AND release_year < 2010;

SELECT *
FROM films
WHERE language = 'Spanish'
AND release_year BETWEEN 2001 AND 2009;

-- Przygotuj zapytanie, które zwróci tytuł oraz rok wydania filmów, które wydano w latach 90, w języku hiszpańskim lub francuskim z dochodem (gross) większym niż 2 mln.
SELECT title, release_year
FROM films
WHERE release_year BETWEEN 1990 AND 1999
AND (language = 'Spanish' OR language = 'French')
AND gross > '2000000';

-- Pobierz tytuły filmów oraz lata wydania filmów hiszpańskojęzycznych, które wydano pomiędzy 1990 i 2000 rokiem (w wyniku mają być również uwzględnione filmy z roku 1990 i 2000) z budżetem powyżej 100mln 
SELECT title, release_year
FROM films
WHERE language = 'Spanish'
AND release_year BETWEEN 1990 AND 2000
AND gross > '100000000';

-- Pobierz tytuły i lata premier wszystkich filmów wydanych w 1990 lub 2000 roku, które były dłuższe niż dwie godziny. Czas filmów jest zapisany w minutach. (Użyj operatora IN)
SELECT title, release_year
FROM films
WHERE release_year IN  (1990, 2000)
AND duration > '120';

-- Pobierz tytuły i języki filmów angielsko-, hiszpańsko- i francuskojęzycznych
SELECT title, language
FROM films
WHERE language IN ('English', 'Spanish', 'French');

-- Pobierz tytuły i certyfikaty filmów z certyfikatem NC-17 i R
SELECT title, certification
FROM films
WHERE certification IN ('NC-17', 'R');

-- Znajdź nazwiska osób z tabeli people, które nadal żyją.
SELECT name
FROM people
WHERE deathdate IS NULL;

-- Pobierz tytuły filmów, dla których nie jest znany budżet
SELECT title
FROM films
WHERE budget IS NULL;

-- Zlicz ilość filmów, które nie posiadają przypisanego języka
SELECT COUNT(*)
FROM films
WHERE language IS NULL;

-- Znajdź nazwiska osób z tabeli people, których nazwiska zaczynają się na literę B
SELECT name
FROM people
WHERE name LIKE 'B%';

-- Znajdź osoby z nazwiskami, które jako drugą literę mają r
SELECT name
FROM people
WHERE name LIKE '_r%';

-- Znajdź nazwiska osób, których nazwiska nie zaczynają się na literę A
SELECT name
FROM people
WHERE name NOT LIKE 'A%';

-- Wyznacz całkowity czas trwania (duration) wszystkich filmów 
SELECT SUM(duration)
FROM films;

-- Wyznacz średni czas trwania (duration) wszystkich filmów
SELECT AVG(duration)
FROM films;

-- Pobierz czas trwania najkrótszego filmu
SELECT MIN(duration)
FROM films;

-- Pobierz czas trwania najdłuższego filmu
SELECT MAX(duration)
FROM films;

-- Wyznacz sumę dochodów (gross) wszystkich filmów
SELECT SUM(gross)
FROM films;

-- Wyznacz średni dochód (gross) filmów
SELECT AVG(gross)
FROM films;

-- Wyznacz sumę dochodów filmów mających premierę w 2000 roku i później
SELECT SUM(gross)
FROM films
WHERE release_year > 1999;

-- Wyznacz wartość średnią dochodów filmów, których tytuł zaczyna się na literę ‘A’
SELECT AVG(gross)
FROM films
WHERE title LIKE 'A%';

-- Znajdź film z najniższym dochodem, który miał premierę w 1994 roku
-- wyświetla samą kwotę
SELECT MIN(gross)
FROM films
WHERE release_year = 1994;

-- wyświetla nazwę filmu i kwotę
SELECT title, gross
FROM films
WHERE release_year = 1994
AND gross = (SELECT MIN(gross)
	          FROM films
	          WHERE release_year = 1994);

-- Wyznacz film z najwyższym dochodem, który miał premierę pomiędzy latami 2000 i 2012 (wliczając rok 2000 i 2012)
-- wyświetla sam kwotę
SELECT MAX(gross)
FROM films
WHERE release_year BETWEEN 2000 AND 2012;

-- wyświetla tytuł i kwotę
SELECT title, gross
FROM films
WHERE release_year BETWEEN 2000 AND 2012
AND gross = (SELECT MAX(gross)
	          FROM films
	          WHERE release_year BETWEEN 2000 AND 2012);

-- Pobierz tytuły filmów oraz ich zyski (wyznaczone jako róznice pomiędzy dochodami i budżetami). Przypisz do kolumny z zyskami tymczasową nazwę net_profit
SELECT title, (gross - budget) AS net_profit
FROM films;

-- Wyznacz tytuły filmów oraz długości ich trwania w godzinach, przypisz wynikowej kolumnie nazwę duration_hours
SELECT title, (duration / 60.0) AS duration_hours
FROM films;

-- Wyznacz średnią wartość trwania filmów w godzinach i zapisz wynik pod nazwą avg_duration_hours
SELECT AVG(duration / 60.0) AS avg_duration_hours
FROM films;

-- Wyznacz z tabeli people procent nieżyjących już ludzi i zapisz wynik pod nazwą percentage_dead
SELECT (COUNT(CASE WHEN deathdate IS NOT NULL THEN 1 END) * 100.0 / COUNT(*))  AS percentage_dead
FROM people;

SELECT (SUM(IIF(deathdate IS NOT NULL, 1, 0)) * 100.0 / COUNT(*)) AS percentage_dead
FROM people;

-- Wyznacz ile lat minęło od premiery najstarszego i najnowszego filmu, zapisz wynik pod nazwą difference
SELECT MAX(release_year) - MIN(release_year) AS difference
FROM films;

-- Wyznacz liczbę dekad jakie minęło od premiery najstarszego i najnowszego filmu, zapisz wynik pod nazwą numer_of_decades
SELECT ((MAX(release_year) - MIN(release_year)) / 10 ) AS numer_of_decades
FROM films;
