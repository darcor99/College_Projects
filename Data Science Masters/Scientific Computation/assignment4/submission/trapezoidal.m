function result = trapezoidal(f,a,b,N) %trapezoidal integration for fn of  1 variable
h = (b-a)/N;
values = [a:h:b];
values(1) = []; values(end) = [];
middle = sum(2.*f(values));
result = (h/2 .* (f(a) + middle + f(b)));
end

