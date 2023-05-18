%Q1
%Model SIR model
%measure time in units of [days]

%told gamma^-1 = 3 days
gamma = 1/3;
t0 = 250;
tspan = [t0, 7*(46:72)];
R_num = 1.3;
population = 5.2e+7;

yzero = [1-1/population,1/population];

%Beta = gamma * R
Beta = gamma*R_num;

%y = [S, I]
%yprime = [-Beta*S*I, +Beta*S*I - gamma*I]
%yprime = [-Beta*y(1)*y(2), +Beta*y(1)*y(2) - gamma*y(2)]

options = odeset('AbsTol',1e-20,'RelTol',1e-13);

[t, y] = ode45(@SIR,tspan,yzero,options,Beta,gamma)


S = y(:,1)
I = y(:,2)

plot(t,S,'b'); %plot of S(t) against t
hold on
plot(t,I,'r'); %plot of I(t) against t
hold on
R = 1 - S - I;

plot(t,R); %plot of R(t) against t
title('Plotting S(t),I(t) and R(t) against t')
xlabel('t (days)') 
ylabel('Proportion of Population') 
legend("Susceptible population S(t)","Infected Population I(t)","Recovered Population with immunity R(t)",'Location','southwest')
hold off

%%

%data = [week,AH1,AH3,A_untyped,B,total_tested,percent_positive]

%interested only in column 1 (week num) and column 5 (weekly incidence of B
%influenza)
data = [40,1,0,12,2,518,2.9;
41,0,2,8,0,529,1.89;
42,1,0,16,1,612,2.94;
43,0,0,15,2,656,2.59;
44,1,0,24,5,746,4.02;
45,0,2,10,3,578,2.6;
46,1,1,15,0,666,2.55;
47,0,0,18,5,617,3.73;
48,0,3,17,2,636,3.46;
49,0,0,17,6,806,2.85;
50,1,1,1,4,686,1.02;
51,8,3,0,11,904,2.43;
52,3,0,45,17,1037,6.27;
53,8,5,41,18,1230,5.85;
54,4,13,66,18,1164,8.68;
55,17,32,97,18,1291,12.7;
56,29,46,183,43,1545,19.48;
57,33,133,598,83,3194,26.52;
58,64,293,726,112,3651,32.73;
59,45,271,780,157,3752,33.4;
60,56,354,735,254,4159,33.64;
61,33,238,537,234,3401,30.64;
62,16,194,362,202,3001,25.79;
63,6,75,166,151,1923,20.7;
64,21,119,115,114,1903,19.39;
65,2,32,48,126,1157,17.98;
66,1,1,44,72,925,12.76;
67,0,4,25,40,842,8.19;
68,0,3,31,28,681,9.1;
69,0,0,18,15,569,5.8;
70,1,1,19,17,526,7.22;
71,0,0,2,3,371,1.35;
72,0,0,1,4,296,1.69;]

incidence_data = [data(:,1), data(:,5)]

%discard weeks <47 where incidence may = 0
incidence_data(1:7,:) = [];

incidence_data = incidence_data'
T = 7.* incidence_data(1,:);
incidences = incidence_data(2,:);

plot(T,incidences,'-o') %plots incidences for weeks 47 to 72 inclusive


%calculate area from data
%(approx) area under curve in this case is just sum of incidences .* 7

area_d = 7.*sum(incidences)
%%

%process numcerical data (ode45) for comparison:
%discard initial values at initial time t0
S = y(:,1);
I = y(:,2);
R = 1 - S - I;

S(1) = []; I(1) = []; R(1) = [];


%incidence modelled = -diff(S)
incidence_modelled = -diff(S);




%area_numerical
area_n = 7 .* sum(incidence_modelled)

%normalise incidence modelled
incidence_modelled = incidence_modelled .* (area_d/area_n)

plot(T,incidence_modelled)
hold on
plot(T,incidences)
hold off

%check areas are equal
area1 = 7 .* sum(incidence_modelled)
area2 = 7 .* sum(incidences)

SUMofSQUARES = (incidences - incidence_modelled).^2;
leastsquares = (SUMofSQUARES).^(1/2)





