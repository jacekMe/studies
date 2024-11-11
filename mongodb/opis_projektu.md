## ZADANIE:
    przygotować plik (30-40 dokumentów) w strukturze JSON, w którym są dane 
    jednej kolekcji, a każdy dokument powinnien zawierać:
        - jeden dokument zagnieżdżony
        - dwie tablice

## CEL:
    stworzyć bazę danych z 35 dokumentami opisującymi jeden z Grand Tour 
    kolarstwa - Giro d'Italia w latach 1990 - 2024

## ZAWARTOŚĆ:
    - 35 dokumentów
    - jeden dokument dla każdego roku od 1990 do 2024
    - struktura dokumentu:
        - "_id"
        - "race_name"
        - "country"
        - "edition"
        - "year"
        - "start_date"
        - "end_date"
        - "stages"
            - "stage_X"
                - "date"
                - "length"
                - "start_city"
                - "finish_city"
                - "winner"
        - "total_length"
        - "teams"
            - "id"
            - "name"
        - "gc_top10"

