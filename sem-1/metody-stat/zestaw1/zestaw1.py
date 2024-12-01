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
    def __init__(self, A, B, a, b, pA, pB, qA, qB):
        super().__init__(A, B, a, b, pA, pB, qA, qB)
        self.A = A
        self.B = B
        self.a = a
        self.b = b
        self.pA = pA
        self.pB = pB
        self.qA = qA
        self.qB = qB

    def game(self):
        """
        Funkcja symulująca grę
        """
        while self.a > 0 and self.b > 0:
            if np.random.rand() < self.pA:
                self.a += 1
                self.b -= 1
            else:
                self.a -= 1
                self.b += 1
        return self.a

    def game_sim(self, n):
        """
        Funkcja symulująca n gier
        """
        results = []
        for i in range(n):
            results.append(self.game())
        return results

    def game_stats(self, n):
        """
        Funkcja zwracająca statystyki z n gier
        """
        results = self.game_sim(n)
        return pd.Series(results).describe()

    def game_hist(self, n):
        """
        Funkcja rysująca histogram z n gier
        """
        results = self.game_sim(n)
        plt.hist(results, bins=range(min(results), max(results)+1), align='left')
        plt.xlabel('Kapitał gracza A')
        plt.ylabel('Liczba gier')
        plt.title('Histogram kapitału gracza A')
        plt.savefig('histogram.png')
        #plt.show()


if __name__ == '__main__':
    game = GameA('A', 'B', 20, 20, 0.6, 0.4, 0.4, 0.6)
    print(game.game_stats(1000))
    game.game_hist(1000)