#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jan 12 11:36:31 2022

@author: tom
"""

import numpy as np
from scipy.optimize import minimize 
import matplotlib.pyplot as plt





def objective(x): 
    return - 100*x[0] - 200*x[1]


def constraint1(x): 
    return - x[0] - x[1] + 150
 
def constraint2(x):
    return - 4*x[0] - 2*x[1] + 440

def constraint3(x):
    return - x[0] - 4*x[1] + 480

def constraint4(x):
    return - x[0] + 90



x0 = [0, 0]
b = (1.0, 5.0)

bnds = (b,b,b,b)
cond1 = {'type': 'ineq', 'fun': constraint1}
cond2 = {'type': 'ineq', 'fun': constraint2}
cond3 = {'type': 'ineq', 'fun': constraint3}
cond4 = {'type': 'ineq', 'fun': constraint4}
conditions = [cond1, cond2, cond3, cond4]

solution = minimize(objective, x0, method='SLSQP', constraints = conditions)
print("Solution : ", solution.x)
print("Résultat : ", solution.fun * -1)




def drawOptimum():
    # Optimum
    plt.plot(solution.x[0], solution.x[1], marker="o", color="red", label="Optimum")



def drawConstraints():
    x = np.arange(0, 125, 0.5)
    y1 = 150 - x
    y2 = (440 - 4*x) / 2
    y3 = (480 - x) / 4
    y4 = 90 + 0*x 
    
    
    # Constraints
    constraintColor = "orange"
    
    plt.plot(x, y1, color=constraintColor, label="Constraints")
    plt.plot(x, y2, color=constraintColor)
    plt.plot(x, y3, color=constraintColor)
    plt.plot(x, y4, color=constraintColor)



# Dessin sans fonction cout. 
drawConstraints()
drawOptimum()

plt.legend()
figure = plt.figure()




# Dessin avec traces

drawConstraints()

x = np.arange(0, 125, 0.5)
for i in np.arange(15000, 40000, 1000): 
    constante = i
    cout = (constante - 100*x) / 200
    plt.plot(x, cout, color='y')

drawOptimum()
plt.legend()
plt.figure()





# Fonction cout
drawConstraints()

cout = (26000 - 100*x) / 200
plt.plot(x, cout, color="r", label="Cout")

drawOptimum()
plt.legend()
plt.figure()



