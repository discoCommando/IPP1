Celem projektu jest oszczędna implementacja dynamicznej funkcji z historią za pomocą drzew BST.

Dynamiczna funkcja to po prostu funkcja, której wartości mogą się zmieniać. Dziedziną i zbiorem wartości funkcji będą nieujemne liczby całkowite. Początkowo f≡0. Podstawowa zmiana funkcji będzie polegała na wykonaniu operacji przypisania: f(x):=y.

Utrzymywanie historii będzie od nas wymagało możliwości sprawdzenia, jakie wartości przyjmowała funkcja w poszczególnych momentach. Niech ft oznacza postać funkcji po wykonaniu pierwszych t przypisań (początkowa funkcja to f0). W różnych momentach Twój program będzie musiał odpowiadać na pytania postaci suma(t,a..b) oznaczające: „oblicz ft(a)+ft(a+1)+...+ft(b)”.

Funkcję ft będziemy przechowywać w drzewie BST. Każdej dodatniej wartości funkcji będzie odpowiadał węzeł w drzewie o kluczu równym argumentowi funkcji i wartości równej wartości funkcji dla tego argumentu. Porządek BST zadany jest przez klucze węzłów. Niech Dt−1 oznacza drzewo BST powstałe po wykonaniu t−1 przypisań i załóżmy, że wykonujemy właśnie t-te przypisanie: f(x):=y. Wówczas obsługa tego przypisania wymaga rozważenia kilku przypadków:

jeśli ft−1(x)=0 i y>0, to drzewo Dt uzyskujemy, wstawiając do drzewa Dt−1 węzeł o kluczu x i wartości y;
jeśli ft−1(x)>0, y>0 i ft−1(x)≠y, to drzewo Dt otrzymujemy poprzez zmianę w drzewie Dt−1 wartości węzła o kluczu x na wartość y;
jeśli ft−1(x)>0 i y=0, to konstruując drzewo Dt, z drzewa Dt−1 usuwamy węzeł o kluczu x;
w pozostałych przypadkach drzewo Dt jest takie samo jak drzewo Dt−1.
Reprezentacja funkcji musi być oszczędna, tzn. nie możemy pozwolić sobie na to, żeby dla każdej funkcji ft utrzymywać osobne drzewo BST. Jeśli w drzewie Dt znajdują się węzły o identycznych poddrzewach jak w drzewie Dt−1, to takich węzłów nie będziemy tworzyć, tylko z pozostałych węzłów w drzewie Dt podłączymy się wskaźnikami do odpowiednich węzłów z drzewa Dt−1. W przypadku, gdy te drzewa są identyczne, nie tworzymy żadnego nowego węzła, a jedynie kopiujemy wskaźnik na korzeń Dt−1 jako korzeń Dt. Należy także zaimplementować operację czysc(t), która ustawia wszystkie wartości funkcji ft na 0 i usuwa z pamięci wszystkie węzły drzewa Dt, które może usunąć (tzn. takie, które nie są używane w reprezentacji innych drzew Dt′, t′≠t).

Dane i wyniki
Twój program powinien wczytywać polecenia ze standardowego wejścia. Poszczególne polecenia dla programu będą podawane w osobnych wierszach. Poprawne polecenia są jednej z następujących postaci (przy czym x, y, t, a, b są liczbami całkowitymi spełniającymi warunki podane w sekcji Ograniczenia):

f(x):=y
suma(t,a..b)
czysc(t)
W opisie poprawnego polecenia nie są dopuszczalne żadne dodatkowe znaki (w szczególności odstępy ani tabulatory, nawet na końcu polecenia). W przypadku, gdy polecenie w danym wierszu nie jest poprawne, Twój program powinien zignorować to polecenie wypisać wiersz:

zignorowano
i przejść do następnego wiersza.

Twój program powinien wypisać na standardowe wyjście odpowiedzi na wszystkie poprawne polecenia, po jednej w wierszu. Wynikiem dla zapytania pierwszego i trzeciego typu powinien być wiersz:

wezlow: w
gdzie w to liczba całkowita – łączna liczba węzłów drzew BST przechowywanych w pamięci po wykonaniu tego zapytania. Wynikiem dla zapytania drugiego typu powinien być wiersz:

suma(t,a..b)=s
gdzie s to liczba całkowita równa ft(a)+ft(a+1)+...+ft(b).

Ograniczenia
Po każdym poprawnym przypisaniu funkcja musi spełniać: ft:{0,...,109}↦{0,...,103}.
Wartość t w zapytaniu musi odpowiadać istniejącej funkcji ft.
Argumenty a i b zapytania suma muszą spełniać 0≤a≤b≤109.
Twój program powinien obsłużyć maksymalnie 106 poprawnych poleceń. Dalsze polecenia powinien zignorować (tj. dla każdego z nich wypisać wiersz ze słowem "zignorowano").
Uwagi i wskazówki
Usuwanie z drzew BST należy zrealizować według schematu z drugich zajęć, tzn. po odnalezieniu w drzewie węzła, który mamy usunąć, powinniśmy sprawdzić, czy ma on puste prawe poddrzewo. Jeśli tak, to zastępujemy go jego lewym synem, a jeśli nie, zawartość węzła zastępujemy zawartością węzła o minimalnym argumencie usuniętego z prawego poddrzewa.
Przed zakończeniem Twój program musi zwolnić całą zaalokowaną pamięć.
Przy implementacji operacji czysc pomocne może być utrzymywanie w węzłach liczników dowiązań z innych węzłów drzew (tzw. licznik referencji).
Aby osiągnąć efektywną implementację operacji suma warto w każdym węźle drzewa pamiętać sumę wartości funkcji w węzłach w jego poddrzewie.
Możesz założyć, że głębokość żadnego drzewa nie przekroczy 100 (tj. liczba węzłów na najdłuższej ścieżce z korzenia do liścia to maksymalnie 100). Twój program nie musi (i nie powinien) sprawdzać tego warunku.
Implementacja
Twoje rozwiązanie powinno składać się z dwóch plików: pliku drzewa.pas zawierającego implementację modułu o nazwie drzewa oraz pliku zad1.pas korzystającego z tego modułu. Moduł drzewa powinien dostarczać poniższe procedury i funkcje:

procedure inicjuj;
function przypisanie(argument, wartosc : LongInt) : LongInt;
function suma(nr_funkcji, lewy_argument, prawy_argument : LongInt) : LongInt;
function czysc(nr_funkcji : LongInt) : LongInt;
Wynikiem funkcji powinna być opisana powyżej odpowiedź na polecenie. Implementacja funkcji powinna zakładać, że argumenty funkcji są poprawne.

Punktacja
Podstawą przyznania 10 punktów jest poprawny program przechodzący wszystkie testy. Możliwe są punkty karne za poniższe uchybienia.

Za brak obsługi błędów na wejściu można stracić co najwyżej 3 punkty.
Za błędy stylu kodowania można stracić co najwyżej 2 punkty.
Za brak wyodrębnienia modułu drzewa traci się 2 punkty.
Rozwiązania o gorszej złożoności niż wymagana są narażone na utratę co najmniej 3 punktów.
Przykład
Dla danych wejściowych:

f(1):=1 
f(3)=3 
f(3):=5 
suma(0,1..4)
suma(1,1..4) 
suma(2,1..4) 
suma(3,1..4) 
f(3):=5 
suma(3,1..4) 

f(2):=3 
f(4):=4 
f(3):=-3 
f(3):=0 
f(3) := 0 

suma(5,1..100) 
czysc(5) 
suma(5,1..100) 

suma(6,1..2) 
f(2):=7 
suma(7,1..2)
poprawnym wynikiem jest:

wezlow: 1
zignorowano
wezlow: 3
suma(0,1..4)=0
suma(1,1..4)=1
suma(2,1..4)=6
zignorowano
wezlow: 3
suma(3,1..4)=6
zignorowano
wezlow: 6
wezlow: 9
zignorowano
wezlow: 11
zignorowano
zignorowano
suma(5,1..100)=13
wezlow: 8
suma(5,1..100)=0
zignorowano
suma(6,1..2)=4
wezlow: 11
suma(7,1..2)=8