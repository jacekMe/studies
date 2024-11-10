/* Połącz tabelę countries z tabelą languages za pomocą INNER JOIN. W wyniku zamieść nazwę
państwa `country_name` z aliasem `country`, atrybut `local_name`, nazwę języka `name` z aliasem
`language` oraz atrybut `percent` z tabeli `languages`. Przypisz tabeli `countries` alias `c` a tabeli
`languages` alias `l`. Posortuj wyniki według nazw państw malejąco.*/

SELECT c.country_name AS country, c.local_name, l.name AS language, l.[percent]
FROM countries AS c
INNER JOIN languages AS l
ON c.code = l.code
ORDER BY country DESC;

/* Powtórz zapytanie z zadania 1 ale tym razem dla LEFT JOIN. Porównaj liczbę zwróconych
rekordów przez oba zapytania. Znajdź przykładowe rekordy, które pojawiły się w wyniku dla
LEFT JOIN, ale nie było ich w zapytaniu z INNER JOIN.*/

SELECT c.country_name AS country, c.local_name, l.name AS language, l.[percent]
FROM countries AS c
LEFT JOIN languages AS l
ON c.code = l.code
ORDER BY country DESC;
-- różnica jest w kolumnie ‘language’ pojawiają się NULLe

/* Wyznacz produkt krajowy brutto na mieszkańca (gdp_percapita) dla poszczególnych państw
(country_name) w 2010 roku. Wykorzystaj LEFT JOIN dla tabel countries i economies. */

SELECT c.country_name AS country, e.gdp_percapita
FROM countries AS c
LEFT JOIN economies AS e
ON c.code = e.code
WHERE e.year = 2010;

/* Zmodyfikuj zapytanie z punktu 3 tak, aby uzyskać średnie wartości produktu krajowego
brutto (PKB) w rozbiciu na regiony (region). Pobierz nazwy regionów oraz średnie wartości
PKB (ang. GDP) tworząc alias avg_gdp. Posortuj wyniki malejąco według średniej wartości PKB. */

SELECT c.region, AVG(e.gdp_percapita) AS avg_gdp
FROM countries AS c
LEFT JOIN economies AS e
ON c.code = e.code
GROUP BY c.region
ORDER BY avg_gdp DESC;

/* Przepisz poniższe polecenie łączenia tabel za pomocą LEFT JOIN tak, aby uzyskać te same
wyniki, ale z pomocą RIGHT JOIN */

SELECT cities.name AS city, urbanarea_pop, countries.country_name AS country,
indep_year, languages.name AS language, 'percent'
FROM cities
LEFT JOIN countries
ON cities.country_code = countries.code
LEFT JOIN languages
ON countries.code = languages.code
ORDER BY city, language;

SELECT cities.name AS city, urbanarea_pop, countries.country_name AS country,
indep_year, languages.name AS language, 'percent'
FROM languages
RIGHT JOIN countries
ON languages.code = countries.code
RIGHT JOIN cities
ON countries.code = cities.country_code
ORDER BY city, language;

/* Połącz tabelę languages z tabelą countries za pomocą FULL JOIN. Pobierz nazwę państwa
(country_name), kod państwa (code), nazwę języka (name) z aliasem language. Ogranicz
wyniki do państw, których nazwa zaczyna się na literę V lub przyjmuje wartość NULL.
Posortuj wyniki rosnąco według nazwy państwa. */

SELECT c.country_name, c.code, l.name AS language
FROM languages AS l
FULL JOIN countries AS c
ON c.code = l.code
WHERE c.country_name LIKE 'V%' OR c.country_name IS NULL
ORDER BY c.country_name ASC;

/* Powtórz zapytanie z punktu 1 z wykorzystaniem LEFT JOIN. Sprawdź, jakie zmiany wywołało
to w zwracanych wynikach. */

SELECT c.country_name, c.code, l.name AS language
FROM languages AS l
LEFT JOIN countries AS c
ON c.code = l.code
WHERE c.country_name LIKE 'V%' OR c.country_name IS NULL
ORDER BY c.country_name ASC;
-- nie ma tu wyników z NULL w kolumnie 'language'

/* Powtórz zapytanie z punktu 1 z wykorzystaniem INNER JOIN. Sprawdź, jakie zmiany wywołało
to w zwracanych wynikach. */

SELECT c.country_name, c.code, l.name AS language
FROM languages AS l
INNER JOIN countries AS c
ON c.code = l.code
WHERE c.country_name LIKE 'V%' OR c.country_name IS NULL
ORDER BY c.country_name ASC;
-- nie ma żadnych kolumn w których są NULL

/* Połącz tabelę countries z tabelą languages za pomocą FULL JOIN. Użyj dla tabeli countries
aliasu c1 a dla tabeli languages aliasu l. Pobierz nazwę państwa country_name z aliasem
country, region oraz nazwę języka name z aliasem language. */

SELECT c1.country_name AS country, c1.region, l.name AS language
FROM countries AS c1
FULL JOIN languages AS l
ON c1.code = l.code;

/* Zmodyfikuj zapytanie z punktu 4 tak, aby uzyskane wyniki połączyć z tabelą currencies (czyli
połącz 3 tabele za pomocą FULL JOIN). Pobierz atrybuty takie jak w poprzednim punkcie oraz
dodatkowo z tabeli currencies atrybuty basic_unit i frac_unit. Ogranicz wyniki do państw z
regionów Melanesia i Micronesia (użyj LIKE z 'M%esia'). */

SELECT c1.country_name AS country, c1.region, l.name AS language, c2.basic_unit,
c2.frac_unit
FROM countries AS c1
FULL JOIN languages AS l
ON c1.code = l.code
FULL JOIN currencies AS c2
ON l.code = c2.code
WHERE c1.region LIKE 'M%esia';

-- Sprawdź jak dla powyższego przykładu z miastami I językami zachowa się łączenie INNER JOIN.

SELECT c.name AS city, l.name AS language
FROM cities AS c
INNER JOIN languages AS l
ON c.country_code = l.code
WHERE c.name LIKE 'Hyder%';

/* Przygotuj zapytanie za pomocą LEFT JOIN, aby określić listę 5 krajów z ich regionami, dla
których w 2010 roku oczekiwana długość życia (life_expectancy) była najmniejsza. Wynik
posortuj. */

-- to zapytanie zwraca life_expectancy z samymi NULLami
SELECT c.country_name, c.region, p.life_expectancy
FROM countries AS c
LEFT JOIN populations AS p
ON c.code = p.country_code
WHERE p.year = 2010
ORDER BY p.life_expectancy ASC
OFFSET 0 ROW
FETCH FIRST 5 ROWS ONLY;

-- to zapytanie pomija NULLe
SELECT c.country_name, c.region, p.life_expectancy
FROM countries AS c
LEFT JOIN populations AS p
ON c.code = p.country_code
WHERE p.year = 2010 AND p.life_expectancy IS NOT NULL
ORDER BY p.life_expectancy ASC
OFFSET 0 ROW
FETCH FIRST 5 ROWS ONLY;