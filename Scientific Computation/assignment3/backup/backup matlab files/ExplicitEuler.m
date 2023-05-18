function [tsol,ysol] = ExplicitEuler(f,tspan,y0,N)

%finds numeric solution to dy/dt = f(t,y0) using Explicit Euler Method
%user provides function f, tspan, y0 and N

h = (tspan(end) - tspan(1))/N

y = zeros(numel(y0),N+1);

T = tspan(1):h:tspan(end);

y(:, 1) = y0;

for j = 1:N
    y(:, j+1) = y(:, j) + h.* f(T(j),y(:, j));
end

ysol = y
tsol = T

end