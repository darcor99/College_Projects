# -*- coding: utf-8 -*-
"""
Created on Thu Nov 24 12:24:38 2022

@author: Dara
"""

#assign 5 test


#%%
import numpy as np
import matplotlib.pyplot as plt


N = 50


Kappa = 50

h = 1/N

x = np.linspace(0,1, N+1)

print(x)




U_i =  np.sin(np.pi* x**2) #k = 0 here

#U_iplus1

U_i[-1] = 0; U_i[0] = 0; #Boundary Condition, U(x=N,k) = 0, U(x=0,k) = 0

print(U_i)

#Define Tau
Tau = 4*(h**2)#(h**2)/4



#we want to fill grid with U_i values for every time step k

plt.plot(x,U_i,'o-')

for K in range(1,(Kappa+1)):
    U_i_k_plus_one = np.zeros(N+1)
    for i in range(0,N):
        U_i_k_plus_one[i] = Tau * (U_i[i+1] -2*U_i[i] + U_i[i-1])/(h**2) + U_i[i] #change K to Tau?
    U_i_k_plus_one[0] = 0; U_i_k_plus_one[-1] = 0;
    plt.plot(x,U_i_k_plus_one)
    U_i = U_i_k_plus_one
    

plt.show()
    



#%%


N = 3




h = 1/N

x = np.linspace(0,1, N+1)

print(x)




U_i =  np.sin(np.pi* x**2) #k = 0 here

#U_iplus1

U_i[-1] = 0; U_i[0] = 0; #Boundary Condition, U(x=N,k) = 0, U(x=0,k) = 0

U_i0 = U_i[1:-2]
U_ip1 = U_i[2:-1]
U_im1 = U_i[0:-3]



print(U_i)

#Define Tau
Tau = (h**2)/4#(h**2)/4

Kappa = round(1/Tau)



#we want to fill grid with U_i values for every time step k

plt.plot(x,U_i,'o-')


for K in range(0,(Kappa+1)):
    U_i_k_plus_one = Tau * (U_ip1 -2*U_i0 + U_im1)/(h**2) + U_i0
    U_i_k_plus_one = np.append(0,U_i_k_plus_one)
    U_i_k_plus_one = np.append(U_i_k_plus_one,0)
    plt.plot(x,U_i_k_plus_one)
    U_i0 = U_i_k_plus_one[1:-2]
    U_ip1 = U_i_k_plus_one[2:-1]
    U_im1 = U_i_k_plus_one[0:-3]
    
    

plt.show()

#%%

N
J = np.zeros(N+1)
len(J)
J[N]

#%%

U_i_k_plus_one = Tau * (U_ip1 -2*U_i0 + U_im1)/(h**2) + U_i0

print(len(x))
print(len(U_i_k_plus_one))

#%%


#old method

import numpy as np
import matplotlib.pyplot as plt

N = 20
h = 1/N
x = np.linspace(0,1, N+1)

print(x)

U_i =  np.sin(np.pi* x**2) #k = 0 here
U_i[-1] = 0; U_i[0] = 0; #Boundary Condition, U(x=N,k) = 0, U(x=0,k) = 0

print(U_i)

#Define Tau
Tau = (h**2)/2#(h**2)/4

Kappa = round(1/Tau)

#we want to fill grid with U_i values for every time step k

for K in range(1,(Kappa+1)):
    U_i_k_plus_one = np.zeros(N+1)
    for i in range(0,N):
        U_i_k_plus_one[i] = Tau * (U_i[i+1] -2*U_i[i] + U_i[i-1])/(h**2) + U_i[i] #change K to Tau?
    U_i_k_plus_one[0] = 0; U_i_k_plus_one[-1] = 0;
    plt.plot(x,U_i_k_plus_one)
    U_i = U_i_k_plus_one
    
    
U_i_k0 =  np.sin(np.pi* x**2) #k = 0 here
U_i_k0[-1] = 0; U_i_k0[0] = 0;

plt.plot(x,U_i_k0,'o-')
plt.xlabel("x")

plt.show()
    





#%%

####Better Method?

N = 10

h = 1/N

x = np.linspace(0,1, N+1)
print(x)

U_i =  np.sin(np.pi* x**2) #k = 0 here
U_i[-1] = 0; U_i[0] = 0; #Boundary Condition, U(x=N,k) = 0, U(x=0,k) = 0

U_1 =  np.sin(np.pi* x**2) #U_{i=1}
U_1[-1] = 0; U_i[0] = 0;

#Define Tau
Tau = (h**2)/4#(h**2)/4

Kappa = round(1/Tau)

plt.plot(x,U_1,'o-')

#we want to fill grid with U_i values for every time step k
for K in range(0,(Kappa+1)):
    U_i_k_plus_one = Tau * (U_i[2:(N+1)] -2*U_i[1:N] + U_i[0:(N-1)])/(h**2) + U_i[1:N]
    U_i_k_plus_one = np.append(0,U_i_k_plus_one)
    U_i_k_plus_one = np.append(U_i_k_plus_one,0)
    plt.plot(x,U_i_k_plus_one)
    U_i = U_i_k_plus_one 
    

    
plt.show()

#%%

#method 1 from assignment
import numpy as np
import matplotlib.pyplot as plt

N = 40
h = 1/N
x = np.linspace(0,1, N+1)

print(x)

U_i =  np.sin(np.pi* x**2) #k = 0 here
U_i[-1] = 0; U_i[0] = 0; #Boundary Condition, U(x=N,k) = 0, U(x=0,k) = 0

print(U_i)

#Define Tau
Tau = 2*(h**2)#(h**2)/4

Kappa = round(1/Tau)

#we want to fill grid with U_i values for every time step k


U_i_k0 =  np.sin(np.pi* x**2) #k = 0 here
U_i_k0[-1] = 0; U_i_k0[0] = 0;
plt.plot(x,U_i_k0,'o-')

for K in range(1,(Kappa+1)):
    U_i_k_plus_one = np.zeros(N+1)
    for i in range(0,N):
        U_i_k_plus_one[i] = Tau * (U_i[i+1] -2*U_i[i] + U_i[i-1])/(h**2) + U_i[i] #change K to Tau?
    U_i_k_plus_one[0] = 0; U_i_k_plus_one[-1] = 0;
    plt.plot(x,U_i_k_plus_one)
    U_i = U_i_k_plus_one

plt.xlabel("x")
plt.ylabel("U(x,t)")

plt.show()