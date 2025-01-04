import numpy as np
import matplotlib.pyplot as plt

# Parametry
lambda_rate = 1  # Intensywność procesu (1/min)
n_steps = 100     # Liczba skoków

# Funkcja generująca czas losowy metodą odwracania dystrybuanty
def generate_exponential_time(lambda_rate, size=1):
    u = np.random.uniform(0, 1, size)  # Losowe wartości z [0, 1]
    return -np.log(1 - u) / lambda_rate

# Generowanie trajektorii procesu Poissona
interarrival_times = generate_exponential_time(lambda_rate, n_steps)  # Czas między skokami
arrival_times = np.cumsum(interarrival_times)  # Czasy przyjścia

# Wartość procesu w czasie
time_points = np.insert(arrival_times, 0, 0)  # Dodaj czas początkowy
process_values = np.arange(len(time_points)) - 1  # Wartości procesu (zaczynamy od 0)

# Wizualizacja
plt.step(time_points, process_values, where='post', label="Proces Poissona")
plt.xlabel("Czas [min]")
plt.ylabel("Wartość procesu")
plt.title("Trajektoria procesu Poissona")
plt.grid()
plt.legend()
plt.show()