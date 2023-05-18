function [tsol,ysol] = PredictorCorrector(f,tspan,y0,N)

%finds numeric solution to dy/dt = f(t,y0) using Predictor Corrector method
%user provides function f, tspan, y0 and N

h = (tspan(end) - tspan(1))/N

y_pred = zeros(numel(y0),N+1);
y = zeros(numel(y0),N+1);

T = tspan(1):h:tspan(end);

y(:, 1) = y0;
ypred(:, 1) = y0;

for j = 1:N
    ypred(:, j+1) = y(:, j) + h*f(T(j),y(:, j));
    y(:, j+1) = y(:, j) + 1/2 * h * ( f(T(j),y(:, j)) + f(T(j+1),ypred(:, j+1)));
end

ysol = y
tsol = T
end