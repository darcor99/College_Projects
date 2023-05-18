# -*- coding: utf-8 -*-
"""
Created on Mon Nov 14 16:24:21 2022

@author: Dara
"""

#Assignment 5 Scientific Computing:
import numpy as np
import matplotlib.pyplot as plt

def trapezoidal(f,a,b,N):
    h = (b-a)/N
    
    values = np.arange(a,b,h)
    np.delete(values, 0)
    np.delete(values, -1)
    
    middle = 2* sum(f(values))
    result = (h/2) * (f(a) + middle + f(b));
    return result
#%%
def tailored(g,alpha,N):
    start = 0
    finish = 1
    h = (finish-start)/N
    
    x_i = np.linspace(start = (start+h),stop = finish, num = N)
    x_i_minus_one = np.linspace(start = start,stop = (finish-h),num = N)
    
    vals = lambda x: (g(x_i) - g(x_i_minus_one))/(x_i - x_i_minus_one) * (1/(alpha + 2)) * (x**(alpha + 2)) + (x_i*g(x_i_minus_one) -(x_i_minus_one)*(g(x_i)) )/(x_i - x_i_minus_one) * (1/(alpha + 1)) * (x**(alpha + 1))
    
    result = sum(vals(x_i) - vals(x_i_minus_one))
    return result
#%%
#trapezoidal    

N = 10 #10/100/10,000
a = 1.2 #1.2,0.3,-0.9
f = lambda x: x**(a) *(2 + 3*x**3)

Area_Trap = trapezoidal(f,0,1,N)
#print(Area_Trap)

Area_analytic = lambda a: 2/(a+1) + 3/(a+4)

Error = abs(Area_analytic(a) - Area_Trap)
print(Error)
print('{:.4E}'.format(Error))
#%%
#Tailored

N = 10 #10/100/10,000
a = 1.2 #1.2,0.3,-0.9
g = lambda x: (2 + 3*x**3)

Area_Tailored = tailored(g,a,N)
#print(Area_Tailored)

Area_analytic = lambda a: 2/(a+1) + 3/(a+4)

Error = abs(Area_analytic(a) - Area_Tailored)
print(Error)
print('{:.4E}'.format(Error))
#%%
#plot f(x) = x^a(2 + 3x^3), over x = (0,1) for 3 different alpha vals

a = -0.9 #1.2,0.3,-0.9

N=100
x = np.linspace(0,1,N+1);
y = (x**a) * (2 + 3*x**3)

plt.plot(x,y)
plt.xlabel("x")
plt.ylabel("y")
#%%
#EXPLICIT EULER and PREDICTOR CORRECTOR:

def ExplicitEuler(f,tspan,y0,N):

#finds numeric solution to dy/dt = f(t,y0) using Explicit Euler Method
#user provides function f, tspan, y0 and N

    h = (tspan[-1] - tspan[0])/N;

    y = np.zeros(N+1);

    #T = tspan(1):h:tspan(end);
    T = np.linspace(tspan[0],tspan[-1],N+1)

    y[0] = y0;

    for j in range(0,N):
        y[j+1] = y[j] + h* f(T[j],y[j]);
        

    Ysol = y
    Tsol = T
    return [Tsol, Ysol]



def PredictorCorrector(f,tspan,y0,N):

#finds numeric solution to dy/dt = f(t,y0) using Predictor Corrector Method
#user provides function f, tspan, y0 and N

    h = (tspan[-1] - tspan[0])/N;

    ypred = np.zeros(N+1);
    y = np.zeros(N+1);

    #T = tspan(1):h:tspan(end);
    T = np.linspace(tspan[0],tspan[-1],N+1)

    y[0] = y0;
    ypred[0] = y0;

    for j in range(0,N):
        ypred[j+1] = y[j] + h* f(T[j],y[j]);
        y[j+1] = y[j] + (h/2) * ( f(T[j],y[j]) + f(T[j+1],ypred[j+1])  )
        

    Ysol = y
    Tsol = T
    return [Tsol, Ysol]
#%%
#Calculate Errors Explicit Euler
yprime = lambda t,y:  -y -5*np.exp(-t)*np.sin(5*t)
tspan = [0,3]
y0 = 1
N = 500 #,500,1000,2000

[T,Y] = ExplicitEuler(yprime,tspan,y0,N)

y_analytic = lambda t: np.exp(-t) * np.cos(5*t)
Yanalytical = y_analytic(T)

max_error = max(abs(y_analytic(T) - Y))
print(max_error)
print('{:.4E}'.format(max_error))
#%%

#Calculate Errors Predictor Corrector
yprime = lambda t,y:  -y -5*np.exp(-t)*np.sin(5*t)
tspan = [0,3]
y0 = 1
N = 500 #500,1000,2000

[T,Y] = PredictorCorrector(yprime,tspan,y0,N)

y_analytic = lambda t: np.exp(-t) * np.cos(5*t)
Yanalytical = y_analytic(T)

max_error = max(abs(y_analytic(T) - Y))
print(max_error)
print('{:.4E}'.format(max_error))
#%%
#PLOTS

yprime = lambda t,y:  -y -5*np.exp(-t)*np.sin(5*t)
tspan = [0,3]
y0 = 1
N = 600

[T,y1] = ExplicitEuler(yprime,tspan,y0,N)
[T,y2] = PredictorCorrector(yprime,tspan,y0,N)
Yanalytical = y_analytic(T)

plt.figure(dpi=1200)
plt.plot(T,Yanalytical,"--" , markersize=0.5,linewidth = 1.1 ,label = 'Analytical Solution')
plt.plot(T,y1, 'r.', markersize=1.1,markeredgewidth=.1 ,alpha = 0.9,label = "Explicit Euler")
plt.plot(T,y2, 'g.', markersize=1.1,markeredgewidth=.1 ,alpha = 0.9,label = "Predictor Corrector" )
plt.legend()
plt.title("Analytical and Computed Solutions to Problem 1")
plt.xlabel("t")
plt.ylabel("y(t)")
plt.show()
#%%
#PART C: HEAT EQUATION

N = 20

h = 1/N

x = np.linspace(0,1, N+1)
print(x)

U_i =  np.sin(np.pi* x**2) #k = 0 here
U_i[-1] = 0; U_i[0] = 0; #Boundary Condition, U(x=N,k) = 0, U(x=0,k) = 0

#Define Tau
Tau = (h**2)/4

Kappa = round(1/Tau)

U_1 =  np.sin(np.pi* x**2) #U_{i=1}
U_1[-1] = 0; U_i[0] = 0;

plt.figure(dpi=1200)
plt.plot(x,U_1,'o-',linewidth = 0.2, markersize=0.2)

#we want to fill grid with U_i values for every time step k
for K in range(0,(Kappa+1)):
    U_i_k_plus_one = Tau * (U_i[2:(N+1)] -2*U_i[1:N] + U_i[0:(N-1)])/(h**2) + U_i[1:N]
    U_i_k_plus_one = np.append(0,U_i_k_plus_one)
    U_i_k_plus_one = np.append(U_i_k_plus_one,0)
    plt.plot(x,U_i_k_plus_one,'o-', linewidth = 0.2, markersize=0.2 ,alpha = 0.8,)
    U_i = U_i_k_plus_one 
    

plt.title("Heat Equation Solution Plots from t=0 to t=1")
plt.xlabel("x")
plt.ylabel("U(x,t)")   
plt.show()