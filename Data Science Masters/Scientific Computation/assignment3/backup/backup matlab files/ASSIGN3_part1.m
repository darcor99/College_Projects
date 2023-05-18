%problem1 (N=600/1200)
%analytic solution

y_analytic1 = @(t)exp(-t) .* cos(5*t)


%Explicit Euler Method 
yprime = @(t,y)-y -5*exp(-t)*sin(5*t)

tspan = [0 3]; yzero = 1;

[t,y] = ExplicitEuler(yprime,tspan,yzero,1200)

max(abs(y_analytic1(t) - y))
%% 
%Problem1 (N=600/1200) Predictor-Corrector Method
yprime = @(t,y)-y -5*exp(-t)*sin(5*t)
y_analytic1 = @(t)exp(-t) .* cos(5*t)
tspan = [0 3]; yzero = 1;
[t,y] = PredictorCorrector(yprime,tspan,yzero,1200)

max(abs(y_analytic1(t) - y))

%%
%Problem1 (N=600/1200) 4th Order Runge-Kutta Method
yprime = @(t,y)-y -5*exp(-t)*sin(5*t)
y_analytic1 = @(t)exp(-t) .* cos(5*t)
tspan = [0 3]; yzero = 1;
[t,y] = RK4(yprime,tspan,yzero,600)

max(abs(y_analytic1(t) - y))

%%
%problem 2: (N=500/1000)
tspan = [0 10];
yzero = [1; 1];

%Reference Solution
options = odeset('AbsTol',1e-20,'RelTol',1e-13);
[T2,Y2] = ode45(@pend,tspan,yzero, options);

[y1,y2] = meshgrid(-5:0.5:5,-3:0.5:3);
Dy1Dt = y2; Dy2Dt = -sin(y1)
quiver(y1,y2,Dy1Dt,Dy2Dt)
hold on
plot(Y(:,1),Y(:,2))
axis  equal, axis([-5 5 -3 3])
xlabel y_1(t), ylabel y_2(t), hold off

%%
%Explicit Euler solution for Problem 2:
tspan = [0 10];
yzero = [1; 1];
[t,y] = ExplicitEuler(@pend,tspan,yzero,1000); 

plot(t,y(1,:))
%plot(t,y(2,:))
%plot(y(1,:),y(2,:)) %note plot is not continuous


y = y'
yq = interp1(t,y,T2,'spline')
max(abs(Y2 - yq))

%%
%Predictor Corrector Solution for Problem 2:

tspan = [0 10];
yzero = [1; 1];
[t,y] = PredictorCorrector(@pend,tspan,yzero,1000);

plot(y(1,:),y(2,:))

y = y'
yq = interp1(t,y,T2,'spline')
max(abs(Y2 - yq))

%%
%Runge-Kutta 4 for Problem 2:

tspan = [0 10];
yzero = [1; 1];
[t,y] = RK4(@pend,tspan,yzero,1000);

plot(y(1,:),y(2,:))

y = y'
yq = interp1(t,y,T2,'spline')
max(abs(Y2 - yq))
%%
%Problem 3

%Reference Solution
tspan = [0 50];
yzero = [1;1;1];
a= 0.2; b = 0.2; c= 2.5;

options = odeset('AbsTol',1e-20, 'RelTol', 1e-13);
[T3,Y3] = ode45(@rossler,tspan,yzero,options,a,b,c)

%%

%Problem 3 Explicit Euler Solution (N = 20000 / 40000)
tspan = [0 50];
yzero = [1;1;1];
a= 0.2; b = 0.2; c= 2.5;

[t,y] = ExplicitEuler(@rossler,tspan,yzero,40000)

plot(y(1,:),y(2,:))

y=y'
size(y)
size(Y3)


yq = interp1(t,y,T3,'spline')
max(abs(Y3 - yq))

%%

%Problem 3 Predictor Corrector Solution (N = 20000 / 40000)
tspan = [0 50];
yzero = [1;1;1];
a= 0.2; b = 0.2; c= 2.5; %these initial conditions are also set inside the rossler function

[t,y] = PredictorCorrector(@rossler,tspan,yzero,40000) %note MUCH SLOWER to compute than euler
%extremely inefficient method

plot(y(1,:),y(2,:))

y = y'
yq = interp1(t,y,T3,'spline')
max(abs(Y3 - yq))

%%

%Problem 3 Runge-Kutta 4 Solution (N = 20000 / 40000)
tspan = [0 50];
yzero = [1;1;1];
a= 0.2; b = 0.2; c= 2.5;

[t,y] = RK4(@rossler,tspan,yzero,20000) %faster than predictor-corrector and more precise

plot(y(1,:),y(2,:))

y = y'
yq = interp1(t,y,T3,'spline')
max(abs(Y3 - yq))

