USE countries2;

-- połącz tabelę economies2010 z tabelą economies2015 tak aby wynik nie zawierał duplikatów

SELECT code, year, income_group, gross_savings
FROM economies2010
UNION
SELECT code, year, income_group, gross_savings
FROM economies2015
ORDER BY code, year;

/* Połącz kolumnę country_code z tabeli cities z kolumną code z tabeli currencies. Wynikowa
tabela powinna mieć jedną kolumnę country_code, nie może zawierać duplikatów i powinna
być posortowana alfabetycznie według country_code. */

SELECT country_code
FROM cities
UNION
SELECT code
FROM currencies
ORDER BY country_code;

/* Wyznacz pary (w tym duplikaty) kodu państwa i roku, które występują w tabelach economies
lub populations. Posortuj wynikową tabelę według kodu państwa i roku. */

SELECT code, year
FROM economies
UNION ALL
SELECT country_code, year
FROM populations
ORDER BY code, year;

/* Wyznacz pary kodu państwa i roku, które występują jednocześnie w tabelach economies i populations.
Posortuj wynikową tabelę według kodu państwa i roku. */

SELECT code, year
FROM economies
INTERSECT
SELECT country_code, year
FROM populations
ORDER BY code, year;

/* Korzystając z tabeli countries oraz cities sprawdź, które państwa mają taką samą nazwę jak
miasta. */

SELECT country_name
FROM countries
INTERSECT
SELECT name
FROM cities;

/* Wyznacz nazwy miast z tabeli cities, które nie są wymienione, jako stolice w tabeli countries.
Posortuj wyniki alfabetycznie. Zwróć uwagę, że w tabeli countries brakuje kilku państw w
efekcie niektóre miasta nie będą zaliczone do stolic, podczas gdy w rzeczywistości są
stolicami. */

SELECT name
FROM cities
EXCEPT
SELECT capital
FROM countries
ORDER BY name;

-- Określ nazwy stolic państw, które nie są wymienione w tabeli z miastami.

SELECT capital
FROM countries
EXCEPT
SELECT name
FROM cities
ORDER BY capital;

/* Wykorzystaj koncepcję zapytania semi-join do tego, aby zidentyfikować języki, których używa
się na Bliskim Wschodzie (Middle East). Usuń duplikaty i posortuj wyniki po nazwie języków. */

SELECT DISTINCT name
FROM languages
WHERE code IN
    (SELECT c.code
     FROM countries AS c
     WHERE region = 'Middle East')
ORDER BY name;

-- Zrealizuj zadanie z punktu powyżej wykorzystując INNER JOIN.

SELECT DISTINCT l.name
FROM languages AS l
    INNER JOIN countries AS c
        ON l.code = c.code
WHERE c.region = 'Middle East'
ORDER BY l.name;

/* Korzystając z INNER JOIN wyznacz nazwy walut, które są używane w Oceanii.
Przy nazwie waluty powinna znaleźć się nazwa państwa i kod państwa. */

SELECT co.country_name, co.code, cu.basic_unit
FROM currencies AS cu
    INNER JOIN countries AS co
        ON cu.code = co.code
WHERE co.region IN ('Australia and New Zealand', 'Melanesia', 'Micronesia', 'Polynesia');

/* Wyświetl listę wszystkich państw należących do Oceanii. Niestety w wynikach z poprzedniego 
zadania brakuje niektórych państw należących do Oceanii. Wykorzystaj koncepcję zapytania anti-join
do tego, aby ustalić listę państw z Oceanii, które nie pojawiły się w wynikach z poprzedniego zadania. */

SELECT country_name
FROM countries
WHERE code NOT IN
    (SELECT code
     FROM currencies)
    AND region IN ('Australia and New Zealand', 'Melanesia', 'Micronesia', 'Polynesia');

/* Wykorzystaj operacje na zbiorach do tego, aby znaleźć kody krajów, które występują w
tabelach economies lub currencies, ale których nie ma w tabeli populations. */

SELECT code
FROM currencies
WHERE code NOT IN
    (SELECT country_code
     FROM populations)
ORDER BY code ASC;

SELECT code
FROM currencies
EXCEPT
SELECT country_code
FROM populations;

-- w tabeli 'economies' nie ma kodów krajów, których nie ma w tabeli populations
SELECT code
FROM economies
WHERE code NOT IN
    (SELECT country_code
     FROM populations);

SELECT code
FROM economies
EXCEPT
SELECT country_code
FROM populations;

/* Znajdź nazwy państw dla kodów państw, które uzyskano w poprzednim zadaniu (wykorzystaj do
utworzenia nowego zapytania kod napisany w poprzednim zadaniu). */

-- same NULLe, ponieważ tych kodów nie ma w tabeli countries
SELECT cu.code, co.country_name
FROM currencies AS cu
    LEFT JOIN countries AS co
        ON cu.code = co.code
WHERE cu.code NOT IN
    (SELECT country_code
     FROM populations)
ORDER BY code ASC;

/* Wykorzystaj zagnieżdżanie w WHERE, aby uzyskać dane na temat liczebności ludności w
miastach tylko dla stolic państw. Wyświetl nazwy miast, kody państw oraz
liczebności populacji sortując wyniki malejąco według populacji. */

SELECT name, country_code, urbanarea_pop
FROM cities
WHERE name IN 
    (SELECT capital
     FROM countries)
ORDER BY urbanarea_pop DESC;

/* Określ dla każdego kontynentu państwo z maksymalną stopą inflacji w 2015r. Wyświetl
nazwę kontynentu, państwo oraz stopę inflacji tego państwa. Wykorzystaj zagnieżdżanie
zapytań. */

SELECT
    (SELECT continent
     FROM countries
     WHERE code = e.code) AS continent,
    (SELECT country_name
     FROM countries
     WHERE code = e.code) AS country_name,
     e.inflation_rate AS max_inflation_rate
FROM economies AS e
WHERE e.year = 2015
    AND e.inflation_rate = (
    SELECT MAX(e2.inflation_rate)
    FROM economies AS e2
    WHERE e2.year = 2015
        AND (SELECT continent
            FROM countries
            WHERE code = e2.code) =
            (SELECT continent
            FROM countries
            WHERE code = e.code)
)
ORDER BY continent;