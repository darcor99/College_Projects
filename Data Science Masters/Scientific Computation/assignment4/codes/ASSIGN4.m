%Part I: evaluate integral x^a * (1+x^2) dx from 0 to 1 (a>-1)

%using Trapezoidal Rule for N = 10,100,10000
%a = 2.2,0.5,-0.9

a = 0.5
f = @(x) x.^a .* (1+x.^2)
analytic_int = @(a) 1/(a+1) + 1/(a+3);
%%
N = 10;
trapezoidal(f,0,1,N)
analytic_int(a)
abs(trapezoidal(f,0,1,N) - analytic_int(a))
%%
N = 100;
trapezoidal(f,0,1,N)
analytic_int(a)
abs(trapezoidal(f,0,1,N) - analytic_int(a))
%%
N = 10000;
trapezoidal(f,0,1,N)
analytic_int(a)
abs(trapezoidal(f,0,1,N) - analytic_int(a))
%%
%Finding Area using Quad function for tolerences 1e-2, 1e-4 and 1e-8
analytic_int(a);
Area_quad = quad(f,0,1,1e-2);
abs(Area_quad - analytic_int(a))
%%
analytic_int(a);
Area_quad2 = quad(f,0,1,1e-4);
abs(Area_quad2 - analytic_int(a))
%%
analytic_int(a)
Area_quad = quad(f,0,1,1e-8)
abs(Area_quad - analytic_int(a))

%%
%Q4
%Tailored :
N = 10000 %N = 10,100,10000
a = -0.9 %a = 2.2, 0.5, -0.9
g = @(x) (1+x.^2)

%Tailored Parameters (g,alpha,N)
Area_Tailored1 = tailored(g,a,N)

analytic_int = @(a) 1/(a+1) + 1/(a+3);
abs(Area_Tailored1 - analytic_int(a))
%%
%Q5
N = 10 %N = 10,100,1000,10000,100000
a= -0.9
g2 = @(x) exp(1-2.*x.^3)

Area_Tailored2 = tailored(g2,a,N) 

%%
%Create plots to develop intuition:
N = 100
x = linspace(0,1,N+1)
a = -0.9 %a = 2.2, 0.5, -0.9
f = @(x) x.^a .* (1+x.^2)
plot(x,f(x))

%%
%compare matlabs integration fn int to our fn

a = -0.9 %a = 2.2, 0.5, -0.9
f = @(x) x.^a .* exp(1-2.*x.^3)
integral(f,0,1)