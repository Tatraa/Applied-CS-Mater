import numpy as np
import matplotlib.pyplot as plt

# Definicja macierzy przejść P
P = np.array([
    [0.64, 0.32, 0.04],  # Przejścia z 0 użytkowników zalogowanych
    [0.4,  0.4,  0.2 ],  # Przejścia z 1 użytkownika zalogowanego
    [0.25, 0.5,  0.25 ]  # Przejścia z 2 użytkowników zalogowanych
])

# Parametry obliczeń
max_iterations = 1000
threshold = 1e-6

# Inicjalizacja
N = P.shape[0]
p_n = P.copy()
p_last = np.zeros_like(P)
difference = []

# Iteracyjna potęga macierzy i sprawdzanie zbieżności
for iteration in range(max_iterations):
    p_last = p_n.copy()
    p_n = np.dot(p_n, P)  # P^(N+1) = P^N * P
    diff = np.max(np.abs(p_n - p_last))
    difference.append(diff)
    if diff < threshold:
        break

# Wyznaczenie rozkładu stacjonarnego (średnia dowolnego wiersza macierzy granicznej)
stationary_distribution = p_n[0]

# Wyniki
print("Macierz przejść P:\n", P)
print("Macierz graniczna P^N:\n", p_n)
print("Rozkład stacjonarny:", stationary_distribution)
print("Liczba iteracji do zbieżności:", iteration)

# Wykres zbieżności
plt.figure(figsize=(10, 6))
for i in range(N):
    for j in range(N):
        values = [p_n_step[i, j] for p_n_step in [np.linalg.matrix_power(P, k) for k in range(iteration + 1)]]
        plt.plot(range(len(values)), values, label=f"P^N[{i},{j}]")

plt.xlabel("N (Iteracje)")
plt.ylabel("P^N[i,j]")
plt.title("Zbieżność elementów macierzy P^N")
plt.legend()
plt.grid()
plt.show()
