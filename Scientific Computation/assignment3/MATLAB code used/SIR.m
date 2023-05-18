function yprime = SIR(t,y,Beta,gamma)

%SIR model

yprime = [-Beta*y(1)*y(2); +Beta*y(1)*y(2) - gamma*y(2)];