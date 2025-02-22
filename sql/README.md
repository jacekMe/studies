# SQL - zapytania analityczne

1. lista I - zapytania analityczne

    - SELEKCJA KOLUMN
        - w języku `SQL` można pobierać dane z tabeli za pomocą instrukcji `SELECT`.
        - aby instrukcja była wykonalna trzeba podać jeszcze z jakiej tabeli 
        chcemy wyświetlić dane, a do tego potrzebna jest instrukcja `FROM`. 
        - przykładowe zapytanie:

            `SELECT <nazwa kolumny/kolumn>
             FROM <nazwa tabeli>`

        - często potrzebujemy pobrać więcej niż jedną kolumnę, wtedy oddzielamy 
        je przecinkami.
        - możemy również ograniczyć liczbę zwracanych wyników, wtedy trzeba użyć
        słowa kluczowego `TOP` (tylko MS SQL)

            `SELECT TOP <wartość> <nazwa kolumny>`

        - często wyniki zawierają zduplikowane wartości, wtedy można pobrać 
        unikalne wartości za pomocą słowa kluczowego `DISTINCT`

            `SELECT DISTINCT <nazwa kolumny>`

        - gwiazdka (`*`) oznacza, że wybieramy wszystkie kolumny z tabeli
        - aby zliczyć liczbę wierszy należy użyć instrukcji 

            `SELECT COUNT(*)`

    - FILTROWANIE WYNIKÓW

        - do filtrowania wyników używamy słowa kluczowego `WHERE`
        - klauzula ta pozwala filtrować wyniki na podstawie tekstu oraz wartości
        liczbowych występujących w tabeli
        - klauzula `WHERE` wykonuje się po klauzuli `FROM`
        - służy do wybrania wyłącznie interesujących nas rekordów
        - istnieje kilka różnych operatorów porównania:
            - `=` equal
            - `<>` not equal
            - `<` less than
            - `>` greater than
            - `<=` less than or equal to
            - `>=` greater than or equal to
        - do zbudowania zapytania składającego się z kilku warunków używamy 
        słowa kluczowego `AND`
        - jeśli chcemy uzyskać wynik, w którym niektóre, ale nie wszystkie 
        warunki muszą być spełnione to używamy operatora `OR`
        - podczas łączenia wielu operatorów `AND` i `OR`, należy pamiętać o 
        umieszczeniu poszczególnych warunków w nawiasach
        - do sprawdzenia zakresów używamy słowa kluczowego `BETWEEN`, który 
        uwzględnia w wynikach wartości początkowe i końcowe (`NOT BETWEEN`)
        - operator `IN` stosujemy kiedy chcemy użyć wielu wartości w klauzuli 
        `WHERE` (`NOT IN`)
        - aby pobrać wartości `NULL` używamy wyrażenia `IS NULL` (`IS NOT NULL`)
        - jeśli chcemy odfiltrować dane nie znając pełnego tekstu, albo tylko 
        część tekstu się pokrywa, to wtedy korzystamy z klauzuli `LIKE`, która 
        wykorzystuje dwa dodatkowe symbole `%` oraz `_`. `%` oznacza symbol 
        wieloznaczny reprezentujący wystąpienie 0, 1 lub wielu znaków tekstu, a
        symbol `_` oznacza wystąpienie dokładnie jednego znaku (`NOT LIKE`)
        - są jeszcze inne operatory takie jak:

            - `EXIST` / `NOT EXIST`
            - `ALL`
            - `ANY`
            - `SOME`

    - FUNKCJE AGREGUJĄCE
        - aby wyznaczyć agregaty z danych używamy funkcji agregujących,
        na przykład:

            - `AVG`
            - `MAX`
            - `MIN`
            - `SUM`
            - `COUNT`


2. lista II - zapytania analityczne

    - SORTOWANIE

        - aby posortować dane musimy użyć klauzuli `ORDER BY`
        - możemy sortować malejąco (`DESC`) lub rosnąco (`ASC`) - domyślnie jest `ASC`
        - możemy sortować po jednej lub wielu kolumnach lub wyrażeniach
        - sortowanie jest kosztowną operacją, dlatego nie warto jej nadużywać
        - dobrze jest umieszczać w klauzuli `SELECT` sortowaną kolumne/wyrażenie

    - GRUPOWANIE

        - jeśli chcemy zagregować wyniki względem jakiegoś artybuty lub grupy
        atrybutów należyć użyć klauzuli `GROUP BY`
        - możemy grupować wyniki względem jednej lub kilu kolumnach
        - zwykle `GROUP BY` używanie jest z funkcjami agregującymi
        - klauzula `GROUP BY` wykonywana jest po klauzuli `WHERE`
        - jeśli w `SELECT` pojawi się kolumna, której nie ma w klauzuli `GROUP BY` 
        to SQL zwróci błąd

    - FILTROWANIE WYNIKÓW GRUPOWANIA

        - aby móc filtrować wyniki grupowania używamy klauzuli `HAVING`, która 
        jest wykonywana po klauzuli `GROUP BY`
        - klauzula `HAVING` działa podobnie jak `WHERE`, ale nie na pojedynczych
        rekordach, tylko grupach
        - nie można użyć `HAVING` bez klauzuli `GROUP BY`
        - w `HAVING` możemy używać funkcji agregujących

    - ŁĄCZENIE DANYCH ZA POMOCĄ `INNER JOIN`

        - łączenie danych z dwóch tabel za pomocą `INNER JOIN` w wyniku wyświetla
        tylko rekordy, które mają dopasowanie w obu tabelach
        - podczas łączenia tabel wykorzystuje się aliasy, aby nie musieć 
        wypisywać całej nazwy tabeli (zazwyczaj alias tworzy się z pierwszej 
        litery), np.:

            TABELA populations
            TABELA countries

            `SELECT c.code, c.name, p.country_code, p.size
                FROM countries AS c
                    INNER JOIN populations AS p
                    ON c.code = p.country_code;`

        - można również za pomocą `INNER JOIN` łączyć dane w ramach jednej tabeli

    - WYKORZYSTANIE `CASE WHEN`

        - kiedy musimy przetransformować atrybut liczbowy na atrybut opisujący
        kategorię lub grupę np. za pomocą słów, to w tym celu wykorzustujemy 
        instrukcję `CASE` z `WHEN`, `THEN`, `ELSE` i `END`
        - na przykład kiedy chcielibyśmy pogrupować kraje ze względu na zajmowaną
        powierzchnię:
            - large
            - medium
            - small

            `SELECT country_name, continent, code, surface_area,
                CASE WHEN surface_area > 2000000
                THEN 'large'
                WHEN surface_area > 350000
                THEN 'medium'
                ELSE 'small' END
                AS geosize_group
             FROM countries;` 


3. lista III - zapytania analityczne

    - ŁĄCZENIE DANYCH ZA POMOCĄ `INNER JOIN`

        - pobiera tylko te wiersze, które mają dopasowanie w obu tabelach

    - ŁĄCZENIE DANYCH ZA POMOCĄ `LEFT JOIN`

        - instrukcja ta łączy dwie tabele
        - łączenie to polega na pobraniu wszystkich wierszy z tabeli po lewej 
        stronie, nawet jeśli nie mają dopasowania w tabeli po prawej stronie
        - aby polecenie zadziałało potrzebny jest jeszcze warunek `ON`
        - jeśli brak dopasowania, w kolumnach z tabeli prawej będzie `NULL`

    - ŁĄCZENIE DANYCH ZA POMOCĄ `RIGHT JOIN`

        - podobnie jak `LEFT JOIN` łączymy dwie tabele
        - łączenie polega na pobraniu wszystkich wierszy, ale tym razem z prawej
        strony, nawet jeśli nie mają dopasowania w tabeli po lewej stronie
        - aby polecenie zadziałało potrzebny jest jeszcze warunek `ON`
        - jeśli brak dopasowania, w kolumnach z tabeli prawej będą `NULLe`

    - ŁĄCZENIE DANYCH ZA POMOCĄ `FULL JOIN`

        - łączenie to polega na pobraniu wszystkich wierszy z obu tabel, nawet
        jeśli nie mają dopasowania
        - aby polecenie zadziałało potrzebny jest jeszcze warunek `ON`
        - jeśli wiersz nie ma dopasowania, brakujące wartości są wypełnione `NULL`

    - ŁĄCZENIE DANYCH ZA POMOCĄ `CROSS JOIN`

        - łączenie w taki sposób tworzy iloczyn kartezjański, czyli łączy każdy 
        wiersz z jednej tabeli z każdym wierszem z drugiej tabeli.
        - nie wymaga warunku `ON`


4. lista IV - zapytania analityczne

    - OPERACJE NA ZBIORACH `UNION`

        - operacj `UNION` wyklucza duplikaty

    - OPERACJE NA ZBIORACH `UNION ALL`

        - operacja `UNION ALL` zawiera duplikaty

    - OPERACJE NA ZBIORACH `INTERSECT`

        - operacja ta zwraca w wyniku te wiersze tabel, które znajdują się
        zarówna w lewej jak i prawej tabeli

    - OPERACJE NA ZBIORACH `EXCEPT`

        - operacja ta zwraca wiersze z tabeli po lewej, które nie mają swojego
        odpowiednika w tabeli po prawej

    - `SEMI JOINS` i `ANTI JOINS`

        - pozwalają wybierać dane (lewa tabela) z wykorzystaniem warunku w 
        klauzuli WHERE, który odnosi się do innej tabeli (prawa tabela)
        - czyli dane z prawej tabeli decydują o tym, które rekordy z lewej tabeli
        pojawiają się w wyniku zapytania

    - ZAGNIEŻDŻANIE ZAPYTANIA W `WHERE`
    - ZAGNIEŻDŻANIE ZAPYTANIA W `SELECT`

        - ten sam rezultat można uzyskać korzystając z `INNER JOIN`

    - ZAGNIEŻDŻANIE ZAPYTANIA W `FROM`


5. lista sprawdzająca
    
    - zadania z łączenia tabel i zagnieżdżania