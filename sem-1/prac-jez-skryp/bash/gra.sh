#!/bin/bash

# Inicjalizacja planszy
board=(" " " " " " " " " " " " " " " " " ")

# Funkcja do wyświetlania planszy
display_board() {
    echo " ${board[0]} | ${board[1]} | ${board[2]} "
    echo "---|---|---"
    echo " ${board[3]} | ${board[4]} | ${board[5]} "
    echo "---|---|---"
    echo " ${board[6]} | ${board[7]} | ${board[8]} "
}

# Funkcja do sprawdzania zwycięzcy
check_winner() {
    local lines=(
        "0 1 2" "3 4 5" "6 7 8" # Wiersze
        "0 3 6" "1 4 7" "2 5 8" # Kolumny
        "0 4 8" "2 4 6"         # Przekątne
    )
    for line in "${lines[@]}"; do
        set -- $line
        if [[ ${board[$1]} != " " && ${board[$1]} == ${board[$2]} && ${board[$2]} == ${board[$3]} ]]; then
            echo "Zwycięzca: ${board[$1]}"
            exit 0
        fi
    done
}

# Funkcja do ruchu gracza
player_move() {
    local move
    while true; do
        read -p "Wybierz pole (1-9): " move
        if [[ $move =~ ^[1-9]$ && ${board[$((move-1))]} == " " ]]; then
            board[$((move-1))]="X"
            break
        else
            echo "Nieprawidłowy ruch, spróbuj ponownie."
        fi
    done
}

# Funkcja do ruchu komputera
computer_move() {
    local move
    while true; do
        move=$((RANDOM % 9))
        if [[ ${board[$move]} == " " ]]; then
            board[$move]="O"
            break
        fi
    done
}

# Funkcja do zapisywania gry
save_game() {
    echo "${board[@]}" > savegame.txt
    echo "Gra zapisana."
}

# Funkcja do wczytywania gry
load_game() {
    if [[ -f savegame.txt ]]; then
        read -r -a board < savegame.txt
        echo "Gra wczytana."
        echo "Aktualny stan planszy:"
        display_board
    else
        echo "Brak zapisanej gry."
    fi
}

# Zapytaj użytkownika, czy chce wczytać zapisany stan gry
read -p "Czy chcesz wczytać zapisaną grę? (y/n): " load
if [[ $load == "y" ]]; then
    load_game
fi

# Główna pętla gry
while true; do
    display_board
    player_move
    check_winner
    computer_move
    check_winner
    display_board
    read -p "Czy chcesz zapisać grę? (y/n): " save
    if [[ $save == "y" ]]; then
        save_game
    fi
done