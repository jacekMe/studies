# ZADANIA & PROJEKT

Tutaj znajduje się opis zadań z list, które wykonywałem podczas zajęć oraz 
projekt do samodzielnego wykonania.


1. Lista zadań do wykonania podczas zajęć i w domu. Ćwiczenia wprowadzające
do pracy z grafową bazą danych neo4j.

    - instalacja i uruchomienie bazy serwera neo4j
    - podstawowe pojęcia:
        - label
        - relationships
        - node
        - properties
    - cypher:
        - język do komunikacji użytkownika z bazą neo4j. jest to język deklaratywny
        - klauzule:
            - MATCH
            - OPTIONAL MATCH
            - RETURN
            - WITH
            - UNWIND
            - WHERE
            - ORDER BY
            - SKIP
            - LIMIT
            - CREATE
            - DELETE
            - SET
            - REMOVE
            - FOREACH
            - MERGE
            - CALL {} (subquery)
            - CALL procedure
            - UNION
            - USE
            - LOAD CSV
    - stworzenie prostego modelu (dwa węzły i dwie relacje)
    - modele demonstracyjne:
        - Movie Graph 
            - baza danych filmów, aktorów i reżyserów
        - Northwind Graph
            - baza danych firmy sprzedającej art. spożywcze (towary, dostawcy, klienci, zamówienia klientów)
    - Move Graph, wybrany fragment


2. Projekt do samodzielnego wykonania
    - wymyśl temat projektu z jakich danych ma się składać i utwórz:
        - około 12-15 węzłów
        - około 20-25 relacji między węzłami
        - każdy węzeł powinien mieć przypisaną etykietę (2-3 różne etykiety) 
        - 2-3 właściwości dla każdego węzła oraz dla każdej relacji
        - wykonać 10 zapytań do utworzonej struktury grafowej + funkcje agregujące
        - wykonać 10 poleceń zmieniających dane:
            - modyfikacja
            - dodawanie
            - kasowanie