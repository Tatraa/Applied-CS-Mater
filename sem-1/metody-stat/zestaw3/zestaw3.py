import numpy as np
import matplotlib.pyplot as plt

# Generator liczb pseudolosowych z rozkładu normalnego metodą Boxa-Mullera
def box_muller(n):
    u1 = np.random.rand(n)
    u2 = np.random.rand(n)
    z0 = np.sqrt(-2 * np.log(u1)) * np.cos(2 * np.pi * u2)
    z1 = np.sqrt(-2 * np.log(u1)) * np.sin(2 * np.pi * u2)
    return z0, z1

# Funkcja analityczna rozkładu normalnego
def normal_distribution(x):
    return (1/np.sqrt(2*np.pi)) * np.exp(-0.5 * x**2)

# Generowanie liczb i rysowanie histogramu
n = 10000
z0, z1 = box_muller(n)
data = np.concatenate((z0, z1))

plt.hist(data, bins=50, density=True, alpha=0.6, color='g')

# Rysowanie funkcji analitycznej
x = np.linspace(-4, 4, 1000)
plt.plot(x, normal_distribution(x), linewidth=2, color='r')
plt.title('Histogram liczb pseudolosowych z rozkładu normalnego')
plt.show()