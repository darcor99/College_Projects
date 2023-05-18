function result = tailored(g,alpha,N) %trapezoidal integration for fn of  1 variable
start = 0;
finish = 1;

h = (finish-start)/N;

x_i = [(start+h):h:finish];
x_i_minus_one = [start:h:(finish-h)];

vals = @(x) (g(x_i) - g(x_i_minus_one))./(x_i - x_i_minus_one) .* 1/(alpha + 2) .* (x.^(alpha + 2)) + (x_i.*g(x_i_minus_one) -(x_i_minus_one).*(g(x_i)) )./(x_i - x_i_minus_one) .* 1/(alpha + 1) .* (x.^(alpha + 1))

result = sum(vals(x_i) - vals(x_i_minus_one))

end