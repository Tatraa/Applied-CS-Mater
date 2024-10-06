import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error

class Test():
    def __init__(self):
        print("Test object created")

    def test(self):
        print("Test method called")

test = Test()
test.test()