import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt


# symulacja i analityczny bardzo ważny - "dosłownie przyjmuje wartość 1"

# D - tylko sprawdza wykres tyle

# C 


class RuinsParam(object):
    """
    A - Gracz A
    B - Gracz B
    a - kapitał gracza A
    b - kapitał gracza B
    pA - prawdopodobieństwo wygranej tury przez gracza A
    pB - prawdopodobieństwo wygranej tury przez gracza B
    qA - prawdopodobieństwo przegranej tury przez gracza A
    qB - prawdopodobieństwo przegranej tury przez gracza B
    """
    def __init__(self, A, B, a, b, pA, pB, qA, qB):
        self.A = A
        self.B = B
        self.a = a
        self.b = b
        self.pA = pA
        self.pB = pB
        self.qA = qA
        self.qB = qB
        

class GameA(RuinsParam):
    def simulate(self, num_simulations=1000):
        ruins = 0
        for _ in range(num_simulations):
            a, b = self.a, self.b
            while a > 0 and b > 0:
                if np.random.rand() < self.pA:
                    b -= 1
                else:
                    a -= 1
            if a == 0:
                ruins += 1
        return ruins / num_simulations


