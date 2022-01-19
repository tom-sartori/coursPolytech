import numpy as np
from scipy.optimize import minimize 
import matplotlib.pyplot as plt


# Exercice 1

def objective(x): 
    return x[0]*x[3]*(x[0]+x[1]+x[2])+x[2]

def constraint1(x): 
    return (x[0]**2 +x[1]**2 + x[2]**2 + x[3]**2) - 40

def constraint2(x):
    return x[0] * x[1] * x[2] * x[3] - 25.0

x0 = [1, 5, 5, 1]

b = (1.0, 5.0)

bnds = (b,b,b,b)
cond1 = {'type': 'eq', 'fun': constraint1}
cond2 = {'type': 'ineq', 'fun': constraint2}
conditions = [cond1, cond2]

sol1 = minimize(objective, x0, method='SLSQP', bounds = bnds, constraints = conditions)
print(sol1)



# Exercice 2.1

def objective(x): 
    return 2*x[0] + x[1]

def constraint1(x): 
    return ( x[0] + 2*x[1] - 8 ) * -1

def constraint2(x): 
    return ( x[0] + x[1] - 5 ) * -1

def constraint3(x): 
    return ( 9*x[0] + 4*x[1] - 36 ) * -1
    
x0 = [0, 0]

cond12 = {'type': 'ineq', 'fun': constraint1}
cond22 = {'type': 'ineq', 'fun': constraint2}
cond32 = {'type': 'ineq', 'fun': constraint3}
constraints = [cond12, cond22, cond32]

sol2 = minimize(objective, x0, method='SLSQP', constraints = constraints)
print(sol2)


# Exercice 2.2

x = np.arange(0, 8.05, 0.05)
y1 = 4 - 0.5 * x
y2 = 5 - x
y3 = 9 - 9 * 1.0 / 4 * x

plt.plot(x, y1)
plt.plot(x, y2)
plt.plot(x, y3)

fig2 = plt.figure()




# Question 3 

fig3 = plt.figure()
plt.plot(x, y1, color='b')
plt.plot(x, y2, color='b')
plt.plot(x, y3, color='b')

for i in np.arange(0, 10, 0.5): 
    cte = i
    cout = cte-2*x
    plt.plot(x, cout, color='y')

plt.show(fig3)



# Question 4 

fing4 = plt.figure()
plt.xlim(0, 10)
plt.ylim(0, 10)

plt.plot(x, y1, color='b')
plt.plot(x, y2, color='r')
plt.plot(x, y3, color='g')

for i in np.arange(0, 10, 0.5): 
    cte = i
    cout = cte-2*x
    plt.plot(x, cout, color='y')
    

# Question 5 

fing5 = plt.figure()
plt.xlim(0, 10)
plt.ylim(0, 10)

plt.plot(x, y1, color='b')
plt.plot(x, y2, color='r')
plt.plot(x, y3, color='g')

for i in np.arange(0, 10, 0.5): 
    cte = i
    cout = cte-x
    plt.plot(x, cout, color='y')


