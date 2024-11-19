# Programowanie Rozproszone i równoległe

Egzamin stacjonarny jak zwykle. Wielokrotny wybór, ujemne punkty, można omijać pytania.

## Wykład 1

Część związana z projektami zaliczeniowymi
---------------------------------

- Wstęp/historia
- IPC
- MPI
- Java
- RMI
- OpenMP
- Optymalizacja Kodu

----------------------------------
Na cześć wykładu
----------------------------------

- CUDA
- REST
- (g)RPC
- XML + SOAP

-----------------------------------

Strona Oramusa: 

Logowanie: PRiR / @FAIS

Liczymy równolegle, bo czasami inaczej sie nie da:

Podagoda(X, Y, Z) -> temperatura, ciśnienie, wilgotność, kierunek wiatru; Siatka nad Polską z komórek elementarnych; Złożoność obliczeniowa; Sumulacja 4 dni z krokiem czasowym 5 min; Do wykonania w chuj operacji zmiennoprzecinkowych; Jeden CPU wykona taką operacje w 10 dni.

Program sekwencyjny składa się z jednego ciągu instrukcji. Przekształcają one dane wejściowe w wyjściowe. Program taki uruchamiany jako proces sekwencyjny i wykonywany jest przez jeden wirtualny, umowny procesor.

W programie sekwencyjnym operacje wykonywane są kolejno po sobie. Musimy poczekać na zakończenie operacji poprzedniej zanim zaczniemy następny.

Ze współbieżnością mamy do czynienia, gdy dwie lub więcej czynności mogą dziać w tym samym czasie. Dwie operacje są współbieżne, gdy w trakcie trwania jednej rozpoczęto drugą.

Program współbieżny to taki, w którym problem potrafimy podzielić i realizować w postaci wielu zadań, które mogą być realizowane współbieżnie.

Generalnie, w programie wpsółbieżnym nie sposób ustalić kiedy operacje należące do różnych zadań będą wykonane. Nie wiadomo, któa operacja jednego zadania poprzedzi rozpoczęcie realizacji operacji z innego zadania. Procesy współbieżne działają asynchronicznie. Można synchronizawać ale to kosztuje!

Synchronizacja wykonania programu współbieżnego oznacza jakąś formę komunikacji pomiędzy zadaniami. Tracimy wtedy czas procesora.

Program współbieżny - procesy mogą być wykonywane w tym samym czasie. Dodatkowo program ten musi rozwiązać problemu synchronizacji i komunikacji pomiędzy procesami. Wynik działania powinien być taki sam jak dla programu sekwencyjnego.

Program równoległy - program współbieżny plus zasoby sprzętowe, które umożliwiają równoległe (jednoczesne) wykonywanie procesów współbieżnych

Program rozproszony - program współbieżny, który używa zasobów wielu komputerów, czyli procesory są w tym przypadku rozproszone.

Przeplot rozwiązuje problem braku zasobów, ale sam z siebie generuje dodatkowe koszty związane z przełączeniem kontekstu.

Aby zminimalizować liczbę przełączeń kontekstu systemy operacyjne przeplot wykonują co pewien czas. Procesy otrzymują dostęp do procesora na pewien czas. W trakcie trwania jednego takieo okresu, proces wykonuje wiele operacji. System operacyjny musi szeregować zadania różnych programów, obsługiwać przerwanai i uwzględniać priorytety procesów.

Proces to działający program. Proces otrzymuje od systemu operacyjnego zasoby: pamięć uchwyty do plików, gniazda sieciowe...

Instrukcje procesu wykonuje co najmniej jeden wątek. Wątki procesu mają dostęp do zasobów procesu.

Maszyny typu Multiple Instruction Multiple Data (MIMD)
![alt text](../../img/MIMD.png)

Są jeszcze rozproszone maszyny z pamięcią wspólną. Rozwiązania sprzętowe lub programowe.

Hierarchiczna Pamięć Współbieżna - czas dostępu do pamięci zależy od lokalizacji pamięci.

__Wnioski__:

1. Przetwarzamy równolegle, bo czasami inaczej sie nie da
2. To co robił jeden procesor - ma teraz robić ich wiele - ale to oznacza konieczność wymiany informacji, a to z kolei trwa. W sumie, w przypadku równoległym potrzeba większej mocy obliczeniowej niż w przypadku sekwencyjnym aby "odrobić" czas zajmowany na komunikację.

__Równoległość procesowa__ - wykonywanie niezależnych zadań z kolejki przez wiele procesorów

__Równmoległość tablicowa__ - Musztra wojskowa

__Równoległość potokowa__ - taśma produkcyjna, budowa i zespoły pracowników

__Przetwarzanie rozproszone__ - dziedzina wiedzy o systemach zawierających więcej niż jeden element przetwarzający, element przechowujący, proces współbieżny lub działający program, które są ściśle lub luźno ze sobą związane

__System równoległy__ - to ściśle powiązany system rozproszony.

W przetwarzaniu równoległym zasoby systemu są podporządkowane celowi w postaci rozwiązania jednego problemu

System rozproszony może pracować nad kilkoma problemami równocześnie.

System rozproszony -> sieć telefoniczna </br>
System równoległy -> orkiestra

__Poprawność programu współbieżnego__ = poprawność programu sekwencyjnego + bezpieczeństwo + żywotoność

<p align="center">
{p}S{q}
</p>

Poprawność częściowe - każde kończące się wykonanie programu S z danymi zgodnymi z p prowadzi do danych spełniających q.

Warunek stopu - każde wykonanie programu S dla dowolnych danych zgodnych z p, się kończy. Generalnie, trzeba udowodnić, że iteracje w programie się skończą

Poprawność pełna - poprawność częściowa + warunek stopu

Program współbieżny składa się z zadań, które realizowane są sekwencyjnie .Każde z zadań musi być w pełni poprawne

Zadania się ze sobą komunikują. Komunikacja nigdy nie może złamać warunków dotyczących bezpieczeństwa. Jednocześnie, dowolne wykonanie współbieżnych zadań musi "w końcu" doprowadzić do spełnienia warunków żywotności.

Bezpieczeństwo chroni przed czymś złym, Żywotność obiecuje, że stanie się coś dobrego.

Aby zagwarantować bezpieczeństwo aplikacji współbieżnej, działającej na amszynie z pamięcią wspólną, muszą istnieć mechanizmy wzajemnego wykluczania się zadań w dostępie do zasobów - zmienna, plik, terminal, połączenie sieciowe

Wykluczanie oznacza, że danego zasobu może jednocześnie używać tylko jedno zadanie. Sekcja krytyczna to fragment zadania, w którym używamy problematycznego zasobu(ów). __Tylko jedno zadanie może realizować sekcję krytyczną__.

Typowe narzędzie chroniące - Semafor - __typowe przykłady sam przerób__

Nieumiejętne stosowanie sekcji krytycznych może doprowadzić do problemów z programem wpsółbieżnym:

- __Blokada__ - zadanie zostało wstrzymane, ale nigdy nie obudzone, czyli się nie zakończy.
- __Zakleszczenie__ - blokada, która jest wynikiem tego, że zadanie, które może inne obudzić, samo zostało wstrzymane. Zakleszczenie to blokada wielu zadań.
- __Zagłodzenie__ - brak dostępu do wymaganego zasobu. Generalnie, zasób jest wprawdzie przydzielany, ale polityka przydziału nie wgarantuje, że każdemu z zadań dostęp ostatecznie zostanie przyznany.

Aby zadanie doczekało się szczęśliwie dostępui do wymaganego zasobu potrzebna jest uczciwość w zarządzaniu dostępem. 

Uczciwość słaba: proces, który niepezerwanie zgłasza żądanie zostanie kiedyś obsłużony

Uczciwość silna: proces, który nieskończenie wiele razy zgłasza żądanie zostanie kiedyś obsłużony.

Różnica jest subtelna. Niech przykładowe zadanie zgłasza żądanie dostępu, ale zamiast się zatrzymać w przypadku odmowy, podejmuje inne działania. W przypadku uczciwości słabej nawet nieskończona liczba powtórzeń takiego działania nie gwarantuje, że zadanie otrzyma dostęp.

Monitor to konstrukcja wyższego poziomu od semafora. Gwarantuje wzajemne wykluczanie. Dodatkowo monitor posiada zmienne warunków, na których operuje się za pomocą:

- wait(a) - wstrzymuje proces, który wykonał procedurę monitora i odblokowuje monitor. Proces trafia do kolejki związanej z warunkiem a, którzy jeszcze nie nastąpił i to spowodowało wykonanie wait.
- signal(a) - inny proces tą operacją uwalnia proces z kolejki powiązanej z warunkiem a. Operacja signal wywoływana jest gdy warunek jest już spełniony. Uwolniony proces nie może rozpocząć pracy tak długo jak inny proces jest wciąż aktywny wewnątrz monitora.

S(n,P) = T(n,1)/T(n,P) > P

Slajd 46/47/48/49 - przepisać wzory

__Wnioski__:

3. Zwiększenie udziału kodu równoległego oznacza często zmianę algorytmu
4. Nie ma ucieczki przed przetwarzaniem równoległym
5. Istnieje wiele technologii, ale efektywne ich użycie wymaga zasosowania odpowiedniego sposobu

Dlaczego producenci sprzedają nam procesory z wieloma rdzeniami zamiast szybkich jednostek o jednym rdzeniu?

P = C f V^2 - Maksymalizacja Wydajności

## Wykład 2

Procesy i komunikacja międzyprocesorowa (IPC)

Programowanie równoległe w systemie z pamięcią wspólną:

Potrzeby programistyczne: tworzenie/ niszczenie / identyfikacji wątków / procesów, mechanizmy kontroli dostępu do danych (sekcje krytyczne)

Za zarządzaniem procesami odpowiada jądro systemu operacyjnego, sposób ich obsługi jest różny dla różnych systemów operacyjnych. W systemie operacyjnym każdy proces posiada proces nadrzędny, z kolei każdy proces może

Przkezywanie informacji pomiędzy procesami działającymi na tym samym komputerze

Kolejka komunikatów - mechanizm komunikacji międzyprocesowej umożliwiający wymianę informacji pomiędzy procesami za pomocą kolejki.

Kolejka komunikatów jest asynchronicznym protokołem komunikacyjnym, co oznacza, że odbiorca i nadawca wiadomości nie muszą łączyć się z kolejką w tym samym czasie. Komunikaty przesłane kolejce są przechowywane aż do czasu odebrania przez inny proces.

Key - identyfikator unikalny w skali całego systemu. Procesy, które chcą współużytkować jedną kolejkę komunikatów muszą podać tą samą wartość. `ftok()` - tożsamość plikuo nazwie podanej w pathname oraz 8 najmniej znaczących bitów proj_id do wygenerowania klucza komunikacji międzyprocesowej Systemu V.

Wartość wynikowa jest taka sama dla wszystkich ścieżek stanowiących nazwy tego samego pliku, o ile użyje się tej samej wartości proj_id

Konieczna jest konsekwencja. Jeśli dostęp do danych ma być bezpieczny, to wszędzie w kodzie musi być zabezpieczony

## Wykład 3

Skalowanie poziome (scale-out) - Dodajemy kolejny komputer

Nie dość, że sama komunikacja między procesami w obrębie jednego komputera jest problematyczna, to teraz dochodzi jeszcze obsługa komunikacji za pomocą sieci

Programowanie równoległe w systemie z pamięcią lokalną!

Zadania są wykonywane na maszynach posiadających własną przestrzeń adresową

Potrzeby programistyczne:

- tworzenie/niszczenie procesów
- identyfikacja procesów - aplikacje są często typu SPMD
- komunikacja pomiędzy procesami (a)synchroniczna (nie)blokująca

Nie ma potrzeby stosowania niektórych rozwiązań koniecznych do programowania maszyn ze współdzieloną pamięcią!

Klastry komputerowe jak narzędzie ogólnego przeznaczenia:

Zalety:

- Awaria węzła nie wyłącza całej maszyny
- Łatwa/tania rozbudowa
- Możliwość łączenia sprzętu różnych dostawców
- Możliwość łączenia różnego rodzaju węzłów (CPU/GPU/FPGA)

Wady:

- Ograniczona wydajność obliczeniowa podejynczego węzła
- Mało pamięci na jednym węźle (typowo 2-4GB/rdzeń)
- Ograniczenia wynikające z szybkości stosowanej sieci połączeniowej

Linda zapewnia pojedynczą, logiczną pamięć dzieloną dla wszystkich procesów w systemie. Każdy proces widzi tę samą przestrzń danych i może pisać lub czytać dane, które są współdzielone przez wsyztskie procesy.

Gniazda - komunikacja z tworzeniem połączania i bezpołączenia.

Zalety:

- Prosty i efektywny sposób transmisji
- Niemal identyczna implementacja w różnych systemach

Wady:

- Serwer przywiązany do stałego portu
- Ograniczenie uprawnienia użytkownika
- Dane przesyłane w formacie binarnym
- Różncie w bibliotekach

__Message Passing Interface (MPI)__ - standard interfejsu przesyłania komunikatów i synchronizacji zadań działających w rzeczywistych lub wirtualnych systemach równoległych.

Zalety:

- darmowy, public domain
- efektywny
- dobra dokumentacja
- programista nie musi wiedzieć jak dokonuje się komunikacja, wystarczy, że wie jak ją zlecić
- komunikacja punkt-punkt i grupowa
- rozwiązuje problem ujednolicenia reprezentacji danych

Wady:

- procesy a nie wątki, czyli brak możliwości użycia pamięci współdzielonej, ale jeśli ktoś dobrze wie jak z MPI korzystać to może stworzyć bardzo wydajny kod nawet dla systemów SMP.

W MPI grupa procesów, które mogą się wzajemnie komunikować oraz pewien kontekst to komunikator. Może być wiele komunikatorów, dla każdego komunikatora każdy proces może być jednoznacznie zidentyfikowany. Transmisja nie musi objąć wszystkich.

MPI - wymiana komunikatów

Z punktu widzenia użytkownika podstawową informacją jest ta, czy wolno mu używać bufora zaraz po zakończeniu funkcji wysyłającej dane. Czyli, czy funkcja wysyłająca dane zakończy się przed wysłaniem wszystkich danych. Ze względu na konieczność synchonizacji pracy programu ważne jest także czy odbierający już dane odbiera.

Tryby komunikacji:

- standard - MPI decyduje, czy wychodząca wiadomość zostanie zbuforowana u nadawcy. Wykonanie funkcji może się zacząć choć odbiorca nie wywołał funkcji odbierającej dane a zakończyć przed wywołaniem funkcji odbierającej dane lub dopiero po dostarczeniu danych
- buffered(B) - można zacząć i zakończyć operację choć odbiorca nie wywołał funkcji odbioru. local - o zakończeniu nei decyduje wywołanie funkcji odbioru. Obszaru pamięci przeznaczony na bufory jest w gesti programisty.
- synchronous(S) - można zacząć przed wywołaniem funkcji odbioru, zakończyć tylko gdy dane zaczęto już przekazywać. Dostarcza wiedzy o tym, w którym miejsci algorytmu jest odbierający dane
- ready(R) - można zacząć tylko gdy odbiorca jest już gotowy na odbiór danych.

## Wykład 4

Wątki stanowią podstawową cechę platformy Java. Z punktu widzenia użytkownika jego aplikacja realizowana jest przed jeden wątek, ale sama JVM używa wielu wątków. Podstawowy wątek aplikacji użytkownika Java to "mian thread".

JVM to pojedynczy proces, choć nasz program może uruchamiać kolejne procesy:
```java
public Process exec(String[] cmdarray)
```

Należy utworzyć obiekt klasy `java.lang.Thread` i użyć metody start().

Kod, który wykonywany jest jako osobny wątek znajduje się w publicznej chuj chuj

Kończenie pracy wątków. `void stop()` zostało uznane za niebezpieczne i przestarzałe. Programowanie rozproszone i równoległe – wykł.

#### 26.10.24 - kontynuacja wykładu

Zmienne lokalne typów prymitywnych są przechowywane na stosie wątku i nie ma możliwości aby inny wątek miał do nich dostęp

Zmienne lokalne typu referencji pokazują na obiekty znajdujące się na stercie - wiele zmiennych może wskazywać ten sam obiekt

Pola statyczne i składniki tablic przechowywane są na stercie - wątki mogą ich wspólnie używać

Budowa procesora zachęca do skracania czasu dostępu do danych za pomocą pamięci podręcznych i rejestrów. Zmiany nie są automatycznie.

W przypadku jednego wątku odczyt r widzi wartość zapisaną w zmiennej v przez zapis w jeśli

- w występuje w kolejności wykonania programu przed r
- pomiędzy w i r nie ma innego zapisu do zmiennej v

W przypadku wielu waków takiej gwarancji jak powyżej nie ma. Prowadzi to do braku widoczności.

Generalnie z wyścigiem mamy do czynienia wtedy, gdy poprawny wynik uzyskiwany jest wtw gdy mamy szczęście. Wyścig to możliwość uzyskania błędnego wyniku na skutek pechowego układu czasu wykonania wątków

Wyścig danych to brak koordynacji w dostępie do współdzielonych danych, którego skutkiem jest możliwość jednoczesnej modyfikacji i odczytu.

Wyścig sprawdź i wykonaj to pozwolenie na to, aby kod typu `if(warunek)then coś()` .................

Hazard żywotności jest następstwem złej kolejności zakładania blokad, brak zasobów czy livelock

Blokada wzajemna jest wynikiem oczekiwania przez wątek na blokadę, która jest w posiadaniu innego wątku, który nie chce jej zwolnić

Rozpoznawanie blokady wzajemnej: należy narysować graf, którego węzły to wątki a krawędzie reprezentują relację "czekam na blokadę, którą masz ty"

Blokada wzajemna ma miejsce, gdy grag jest cykliczny. Rozwiązanie problemu jest w xcałości po stronie programisty

Zagłodzenie jest skutkiem braku zasobów. Wątek nie może wykonać pracy, bo nie ma dostępu do zasobu, który jest do jej wykanania niezbędny. Tym zasobem może być czas SPU czy rozmiar koleki

Livelock to sytuacja, w której aktywny, niezablokowany wątek nie może kontynuować pracy, bo dochodzi do kolejnych błędów. Błąd występuje na skutek zbytniego optymiuzmu programisty, który założył, że błąd może być naprawiony w trakcie programu, w rzeczywistości błędu naprawić się nie udaje.

Błędna publikacja obiektu - inny wątek otrzymuje dostęp do obiektu jeszcze przed zakończeniem konstruktora - Efekt. ątek używa obiektu, który jeszcz enie został w pełni zainicjalizowany.

Błędna publikacja obiektu II - inny wątek otrzymuje dostęp do obiektu po zakończeniu konstruktora, ale wątki nie synchronizują ze sobą tej operacji - Efekt: wątek widzi poprawną referencję, ale stan obiektu może jeszcze nie być ustalony.

Ucieczka/wyciek obiektu - sytuacja gdy nieświadomie, błędnie udostępniamy obiekt, który udostępniony być nie powinien

Np. Zapusijemy referencje obiektu w dostępnym dla innych polu statycznym; udostępniamy tablicę, kolekcję, która zawiera referencję do obiektów, które nie powinny być udostępnione.

## Wykład 5

Rozwiązaywanie problemów w Javie

Stan obiektu to wszystkie składowe klasy, od których zależy zachowanie obiektu widziane z zewnątrz .Są to po prostu dane, które przechowują zmienne stanowe. Stan może być zapisany w wielu zmiennych stanowych

Interesuje nas wyłącznie problem stanu, który jest współdzielony i modyfikowalny

Lepsza jest profilaktyka niż leczenie - czyli bezpieczeństwo wątkowe należy uwzględniać na etapie projektowania

Bezpieczeństwo wątkowe jest tu rozumiane jako poprawność działania pomimo jednoczesnego użycia przez wiele wątków i to bez względu na warunki wykonania

Klasa jest poprawna pod kątem wątków jeśli w żaden sposób nie można doprowadzić do przejścia jej instancji do stanu uznawanego za niepoprawny.

Synchronizacja realizowana w Javie jest za pomocą monitorów

Każdy obiekt w Java posiada pojedynczy monitor. Monitor może zostać zablokowany lub odblokowany przez wątek

W danej chwili tylko jeden wątek może przetrzymywać blokadę monitora.
Wszystkie inne wątki próbujące zablokować ten sam monitor są wstrzymywane do chwili, w której będą mogły uzyskać blokadę.

Użycie blokady wewnętrznej jest możliwe za pomocą słowa kluczowego `synchronized` - może być użyte z blokiem kodu, lecz wtedy explicite wskazać obiekt, którego monitor będzie używany. Można także użyć `synchronizaed` w nagłówku metody. Jeśli metoda jest niestatyczna używany jest monitor obiektu wskazanego przez `this`, jeśli jest statyczna, to używany jest monitor obiektu `class` danej klasy.

Dlaczego element kontroli dostępu to monitor? Monitor to coś bardziej skomplikowanego od semafora binarnego. Monitor to mutex + kolejka oczekiwania - Mutiex zaś to rygiel + prawa własności.

Blokada wewnętrzna rozwiązuje zarówno problem widoczności jak i problem niepodzielności

Blokada jest automatycznie zakładana na rzecz wątku, który wchodzi do sekcji kodu `synchronized` i zwalnia gdy wątek tą sekcje opuszcza. Jeśli blokady używa w tym samym czasie inny wątek trzeba czekać - stąd mutex

Jeśli ta sama blokada jest używana wielokrotnie i jest złożona na rzecz pewnego wątku, to żaden inny wątek do zadnej innej sekcji kodu chronionej tą samą blokadą, nie ma w tym czasie dostępu.

Strona __JavaIII/13 - używane dwa monitory__

Wątek, który założył blokadę może bez przszkód wejść do innego bloku chronionego za pomocą tej samej blokady - stąd blokada ejst wielowejściowa

Blokada wewnętrzna posiada licznik. Jeśli nikt jej nie używa, licznik ma wartość 0. Każde założenie blokady to inkrementacja - każde zwolnienie vblokady to dekrementacja licznika.

Zmienne ulotne (volatile) zapewniają jedynie widoczność pamięci - najnowszy zapis jest dostępny dla innych wątków. Wynika to z tego, że pola `volatile` są traktowane jako współdzielone i nie są buforowane. Ponadto operacje na polach `volatile` zachodzą w kolejności ich zapisu w kodzie źródłowym.

Dostęp do zmiennych ulotnych jest współbieżny - nie wiąże się z zakładaniem blokad - dzięki temu operacje są szybsze

Efekt uboczny: niech dwa wątki A i B współdzielą pewne zmienne i zmienna vz będzie ulotna. Po zapisie w wątku A do zmiennej vz i odczycie jej przez wątek B z wątku B widoczne będą wszystkie zmiienne, które były widoczne w A przed zapisem do vz.

Ałowo `volitile` gwarantuje także atomowość operacji zapisu/odczytu dla zmiennych typu long i double (64ro bitowych)

Zmienne ulotne są wystarczające np. do przekazania stanu flagi wyłączenia wątku

Nawet trywialna operacja inkrementacji jest zbyt złożona aby jej poprawność można było zagwarantować za pomocą zmeinnej ulotnej

Pakiet `java.util.concurent.atomic` - zbiór klas, które umożliwiają bezpieczne wątkowo, niepodzielne operacje na liczbach i referencjach. Przejścia pomiędzy stanami realizowane są atomowo bez konieczności używania blokad. Idealnie nadaje się implementacji stanu, gdy ten jest związany z pojedynczą zmienną stanową

Obiekt niezmienny, to taki, którego stan zostaje ustalony w trakcie konstrukcji. Stanu tego nie można potem zmienić - obiekt taki jest automatycznie bezpieczny pod względem wątków

Obiekt niezmienny może zostać bezpiecznie opublikowany - skoro nie można zmienić jego stanu niczym złym to nei grozi.

Zamiast zmiany stanu obiektu musimy wyprodukować nowy obiekt w nmowym stanie. Spadek wydajności spowodowany koniecznością tworzenia nowego obiektu, zamiast aktualizacji zawartości, może nie być znaczącu. Zyskiem jest brak konieczności użycia synchronizacji

Poprawnie zbudowana klasa reprezentująca obiekt niezmienny

- nie posiada metod typu setter
- nie pozwala na ucieczke referencji `this` w trakcie pracy konstruktora
- ma wyłącznie pola finalne
- nie może być dziedziczona

Czy udostępnienie referencji do obiektu niezmiennego gwarantuje, że wątek otrzyma go w prawidłowym stanie?
Oznacza to, że pola finalne są bezpieczne bez konieczności użycia dodatkowej synchronizacji. Jeśli wątek otrzyma referencję do prawidłowo zbudowanego obiektu niezmiennego, to na pewno widzi jego stan.

Generalnie, pola finalne może posłużyć do przechowywania referencji do zmiennego obiektu np. tablicy. Stan pola finalnego zamrażany jest z chwilą zakończenia konstruktora. Wątki, które będą widziały pole finalne poprawnie skonstruowanego obiektu, będą także poprawnie wiedzieć stan obiektu osiągalnego poprzez to pole finalne.

W sumie: obiektyu niezmienne mogą być bezpiecznie stosowane w programie wielowątkowym bez konieczności używania dodatkowej synchronizacji.

Jak poprawnie współdzielić obiekt, czyli jak obiekt poprawnie opublikować?

1) Przechowywać referencje w polu final
2) Przechowywać referencje w polu volatile
3) Obiekt stworzyć w trakcie inicjalizacji statycznej i wpisać jego referencje do pola statycznego
4) Synchronizować wątki tworzący i konsumujący obiekt
    - Za pomocą jawnej synchronizacji
    - Umieszczając referencje w kolekcji, która wykonuje wewnętrzną synchronizację
    - Umieszczając referencję w kolejnce BlockingQueue 

Możliwości:

1) Obiekty bezstanowe - skoro nie mają stanu nie ma czego popsuć!
2) Odosobnienei w wątku - tworzymy obiekt nie jest współdzielony. Skoro nie jest współdzielony nie ma go kto zepsuć. Przykład to komponenty Swing, które nie są bezpieczne wtkowo, ale są w wątku rozdzielającym
3) Użycie klasy `ThreadLocal<T>` - obiekt tej klasy pozwala na wykonanie operacji `set` i `get`, ale dla każdego z wątków realizowane są one neizależnie
4) Obiekty technicznie niezniemnne - są one zwykłymi obiektami, którym odebrano brak możliwości zmiany po publikacji.

Skoro blokada wzajemna wynika z różnej kolejności uzyskiwania blokad wewnętrznych, należy więc konsekwentnie używać blokad w tej samej, ustalonej kolejności.

Jeśli wybór obiektów używanych w blokowaniu jest dynamiczny należy wprowadzić porządek np. za pomocą `identityHashCode()` - metoda zwraca skrót dla przekazanego obiektu wyliczony na podstawie domyślnej metody `hashCode()`

Jeśli porządku nie można zagwarantować należy użyć dodatkowej blokady, która zdecyduje o tym który z wątków będzie mógł założyć blokady

Należy unikać wywoływania obcych metod z wnętrza obszaru chronionego blokadą - zawzwyczaj nie wiemy jak synchronizadcja jest obca metoda a tego skutkiem może być błąd żywotności

Należy preferować tzw. otwarte wywołania metod - tj. wywołanie obcej metody bez wcześniejszego założenia blokady

Blokada wewnętrzna ma poważną wadę - nie ma możliwości przerwania operacji oczekiwania na wejście do bloku synchronized

## Wykład 6

Przertywanie i koordynacja wątków w Javie

Wiele metod z standardowych klas biblioteki Java posiada możliwość przerwania, specjalna metoda `wait()`, metody obsługi kolejek. W przypadku przerwania metody te natychmiast kończą pracę i zwracają weryfikowalny wyjątej `InterruptedException`

Przerwanie następuje na skutek wywołania z innego wątku metody `interrupt()`. Jest to metoda z klasy `Thread`

Obiekt klasy `Thread` posiada flagę, w której zapamiętywany jest stan przerwania.

Przerwanie metody zwracającej wyjątek `InterruptedException` powoduje, że metoda zwracając wyjątek jednocześnie czyści status przerwania.

Metody z klasy Thread uznane za przestarzałe: `stop()`, `suspend()` + `resume()`. Nie wolno ich używać!

Obecnie w Java nie ma żadnego pewnego mechanizmu wymuszania wyłączenia wątku. Konieczna jest współpraca - wątek musi wyłączyć się sam - tylko taki mechanizm gwarantuje, że stan obiektów nie będą uszkadzany. Zazwyczaj czas reakcji na prośbę wyłączenia jest odwrotnie proporcjonalny do narzutu - aby szybko zareagować na prośbę zakończenia wątku musi on bardzo często sprawdzać umówiony watunek zakończenia. Dobrą metodą współpracy jest użycie przerywania.

Metodsa `notify()` budzi jeden z uśpionych wątków. `notifyAll()` budzi wsyztskie wątki.

Każdy obiekt w Java poza monitorem posaida tzw. Zbiór oczekiwania (wait set). Zbiór oczekiwania jest zbiorem wątków

Zbiór oczekiwania można modyfikować wyłącznie za pomocą metod klasy Object: wait, notify i notifyAll. Dodawanie i usiwanie wątków ze zbioru oczekiwania jest operacją atomową.

Wywołanie metody `yield` jest wskazówką dola programu harmonogramowania wątków, że wątek, który `yield` wywołał aktualnie nie robi nic ważnego i jest gotowy na przerwę w pracy

Model pamięciowy Java definiuje pewien porządek nazywany "zdarzyło się wcześniej"

Gdy jedna akcja zdarza się wcześniej niż druga, to oznacza, że pierwsza jest widoczna dla drugiej

Zasada porządku programu - jeśli w programie jednowątkowym akcja x występuje przed y w porządku programu to x zdarza się wcześniej od y co można zapisać hb(x,y)

Zasada blokady monitora - odblokowanie blokady monitora zdarzyło się wcześniej przed założeniem następnej blokady dla tego samego monitora

Zasada zmiennej ulotnej - zapis do pola volatile zdarza się wcześniej niż każdy odczyt z tego pola

Zasada uruchamiania wątku - wykonanie metody Thread.start zdarza się wczesniej niż dowolna akcja tego wątku

Zasada kończenia wątku - wszystkie aklcje zdarzają się przed możliwością wykrycia, że ten wątek zakończył pracę

Zasada przerwania - wywołąnie metody interrupt w innym wątku zdarza się wcześniej niż możliwość wykrycia przerwania

Zasada finalizacji - zakończenie konstruktora zdarza się wcześniej niż uruchomienie finalizacji obiektu

Zasada przechodniości - chuj

## Wykład 7

Uwagi o `synchronized`
- chroni cały obiekt za pomocą niejawnej blokady
- kod jest zwięzły - mniej szans na błąd
- jak widać z poprzedniego przykładu może działać bardzo szybko
- minus: nie można nie wstzymać watku, który próbuje zająć zasób

....

Jeśli chcemy zmienić zawartość zmiennej w jednym wątku, to w innym watku w tym samym czasie ......

nie chce mi sie już

Sesja __08.02__
