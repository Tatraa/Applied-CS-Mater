### Ćwiczenia nr1

Zaliczenie na stronie Oramusa

3 projekty

4 terminy rozwiązania

Zaliczyć wszystkie 3 projekty - warunek zaliczenia ćwiczeń

Obenocść nieobowiązkowa

Dane do klastra w __usosie__

Mamy działke na marsie, i na tej działće są złoża cczeoś cennego, chcemy zobaczyć gdzie te złoża są najbogatsze - musimy znaleźć maksima jakiejś funkcji. Chcemy w jednym podejściu znaleźć miejsca gdzie chcemy kopać.

W pierwszym kroku kopie, sprawdza co ma pod sobą, robot wykorzystuje antene by sie komunikować z innymi. Obejmuje swoim zasiegiem ileśtam robotów, nie wszystkich. Po antenie sprawdzamy który robot znalazł lepsze miejsce. I wszystko zaczyna się od początku.

`SequentialSwamrp` - działająca wersja, tym się narazie tylko interesujemy, napisana sekwencyjnie, chcemy inaczej

Nasz program musi liczyć i dzielić się danymi

Funkcja którą trzeba liczyć może być niewygodna do liczenia, 

Nie testować clastra na wielu węzłach jeżeli sie nie upewnimy że działa na jednym

`Main` - `before_first_run`- najważniejsza jest instruckja warunkowa `if(!rank)` 

`const.h` - pliczek ze stałymi, ważna ilość robotów i kroków (stepów)

Połączenie na pulpit w pliku `.env`

----------
### Komendy
----------

`sinfo -l` - co jest włączone

Stowrzyłęm katalog A do testowania,
skopiowałem tam pliki `pi.c` i `skrypt`

Załóżmy że mamy  procesy, każdy proces ma swój identyfikator

inkrementując o size, mamy pewność że każdy proces znajdzie dobre dla siebie miejsce

`mpiCC -O pi.c` - kompilacja MPI

instrukcje do odpalania pliku znajdują się w pliku `skrypt`

`sbatch skrypt`

`squeue`

Korzystając ze zrównoleglenia otrzymujemy 3.8 raza szybciej

Sprawdzamy czas i wynik - wynik ma być taki sam, czas szybki

lokalnie `mpirun ./a.out`

`scancel <job_number>` - sprząta kolejke