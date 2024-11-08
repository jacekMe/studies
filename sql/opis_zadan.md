                SQL - zapytania analityczne

1. lista I
    - SELEKCJA KOLUMN
        - w języku SQL można pobierać dane z tabeli za pomocą instrukcji SELECT.
        - aby instrukcja była wykonalna trzeba podać jeszcze z jakiej tabeli 
        chcemy wyświetlić dane, a do tego potrzebna jest instrukcja FROM. 
        - przykładowe zapytanie:

            SELECT <nazwa kolumny/kolumn>
            FROM <nazwa tabeli>

        - często potrzebujemy pobrać więcej niż jedną kolumnę, wtedy oddzielamy 
        je przecinkami.
        - możemy również ograniczyć liczbę zwracanych wyników, wtedy trzeba użyć
        słowa kluczowego TOP

            SELECT TOP <wartość> <nazwa kolumny>

        - często wyniki zawierają zduplikowane wartości, wtedy można pobrać 
        unikalne wartości za pomocą słowa kluczowego DISTINCT

            SELECT DISTINCT <nazwa kolumny>

        - aby zliczyć liczbę wierszy należy użyć instrukcji COUNT

            SELECT COUNT(*)

    - FILTROWANIE WYNIKÓW
