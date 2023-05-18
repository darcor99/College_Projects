%problem1 (N=600/1200)
%analytic solution


N = 1200
y_analytic1 = @(t)exp(-t) .* cos(5*t)


%Explicit Euler Method 
yprime = @(t,y)-y -5*exp(-t)*sin(5*t)

tspan = [0 3]; yzero = 1;

[t,y1] = ExplicitEuler(yprime,tspan,yzero,N)

max(abs(y_analytic1(t) - y1))
%% 
%Problem1 (N=600/1200) Predictor-Corrector Method
yprime = @(t,y)-y -5*exp(-t)*sin(5*t)
y_analytic1 = @(t)exp(-t) .* cos(5*t)
tspan = [0 3]; yzero = 1;
[t,y2] = PredictorCorrector(yprime,tspan,yzero,N)

max(abs(y_analytic1(t) - y2))

%%
%Problem1 (N=600/1200) 4th Order Runge-Kutta Method
yprime = @(t,y)-y -5*exp(-t)*sin(5*t)
y_analytic1 = @(t)exp(-t) .* cos(5*t)
tspan = [0 3]; yzero = 1;
[t,y3] = RK4(yprime,tspan,yzero,N)

max(abs(y_analytic1(t) - y3))

%%



plot(t,y_analytic1(t))
hold on
plot(t,y1)
hold on
plot(t,y2)
hold on
plot(t,y3)

title('Problem 1 plots')
xlabel('t') 
ylabel('y') 
legend("Analytical Solution","Explicit Euler Method","Predictor Corrector Method","Runge-Kutta 4",'Location','southwest')


%%
%problem 2: (N=500/1000)
tspan = [0 10];
yzero = [1; 1];

N=500
h = (tspan(end) - tspan(1))/N
tspan2 = tspan(1):h:tspan(end)


%Reference Solution
options = odeset('AbsTol',1e-20,'RelTol',1e-13);
[T2,Y2] = ode45(@pend,tspan2,yzero, options);


%want reference solution accross grid of same size as our solutions:


[y1,y2] = meshgrid(-5:0.5:5,-3:0.5:3);
Dy1Dt = y2; Dy2Dt = -sin(y1);
quiver(y1,y2,Dy1Dt,Dy2Dt);
hold on
plot(Y2(:,1),Y2(:,2));
axis  equal, axis([-5 5 -3 3]);
xlabel y_1(t), ylabel y_2(t), hold off


Y2
%%
%Explicit Euler solution for Problem 2:
tspan = [0 10];
yzero = [1; 1];
[t,y4] = ExplicitEuler(@pend,tspan,yzero,N); 

plot(t,y4(1,:))
%plot(t,y(2,:))
%plot(y(1,:),y(2,:)) %note plot is not continuous


y4 = y4';
max(abs(Y2 - y4))

%%
%Predictor Corrector Solution for Problem 2:

tspan = [0 10];
yzero = [1; 1];
[t,y5] = PredictorCorrector(@pend,tspan,yzero,N);

plot(y5(1,:),y5(2,:))

y5 = y5';
max(abs(Y2 - y5))

%%
%Runge-Kutta 4 for Problem 2:

tspan = [0 10];
yzero = [1; 1];
[t,y6] = RK4(@pend,tspan,yzero,N);

plot(y6(1,:),y6(2,:))

y6 = y6';
max(abs(Y2 - y6))
%%
%Problem 3

%Reference Solution
tspan = [0 50];
yzero = [1;1;1];
a= 0.2; b = 0.2; c= 2.5;

N=20000
h = (tspan(end) - tspan(1))/N
tspan2 = tspan(1):h:tspan(end)

options = odeset('AbsTol',1e-20, 'RelTol', 1e-13);
[T3,Y3] = ode45(@rossler,tspan2,yzero,options,a,b,c);

%%

%Problem 3 Explicit Euler Solution (N = 20000 / 40000)
tspan = [0 50];
yzero = [1;1;1];
a= 0.2; b = 0.2; c= 2.5;

[t,y7] = ExplicitEuler(@rossler,tspan,yzero,N)

plot(y7(1,:),y7(2,:))

y7=y7';
max(abs(Y3 - y7))

%%

%Problem 3 Predictor Corrector Solution (N = 20000 / 40000)
tspan = [0 50];
yzero = [1;1;1];
a= 0.2; b = 0.2; c= 2.5; %these initial conditions are also set inside the rossler function

[t,y8] = PredictorCorrector(@rossler,tspan,yzero,N) 

plot(y8(1,:),y8(2,:))

y8 = y8';
max(abs(Y3 - y8))

%%

%Problem 3 Runge-Kutta 4 Solution (N = 20000 / 40000)
tspan = [0 50];
yzero = [1;1;1];
a= 0.2; b = 0.2; c= 2.5;

[t,y9] = RK4(@rossler,tspan,yzero,N) %faster than predictor-corrector and more precise

plot(y9(1,:),y9(2,:))

y9 = y9';
max(abs(Y3 - y9))

