function [tsol,ysol] = RK4(f,tspan,y0,N)

h = (tspan(end) - tspan(1))/N

y = zeros(numel(y0),N+1);

T = tspan(1):h:tspan(end);

y(:, 1) = y0;

for j = 1:N
    k1 = f(T(j),y(:, j))
    k2 = f(T(j)+h/2,y(:, j)+h*k1/2)
    k3 = f(T(j)+h/2,y(:, j)+h*k2/2)
    k4 = f(T(j)+h/2,y(:, j)+h*k3)
    y(:, j+1) = y(:, j) + 1/6 * (k1 + 2*k2 + 2*k3 + k4)*h;
end

ysol = y
tsol = T
end