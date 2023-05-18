function yprime = pend(t,y)

%PEND - simple pendulum
% YPRIME = PEND(T,Y)

yprime = [y(2); -sin(y(1)) ]