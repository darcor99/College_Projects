%Implementation of fixed iteration method for our problem:
%-u(x)'' + f(x,u) = 0, u(0) = u(1) = 0

g1 = @(x,U)(U - [cos(x)]')/(2-U) - [exp(4.*x)]';%defining f(x,u) in the equation -u'' + f(x,u) = 0
g2 = @(x,U) 3.*(U'.^4 - 1) -[x.^2 .*exp(5*x)]';
g3 = @(x,U) 200.*(U'.^4 - 1) - [x.^2 .*exp(5.^x)]';

%define N
N = 100

x = linspace(0,1,N+1)%define x
x(1) = []; x(end) = []; 

U = [zeros(N-1,1)]'; %define U

b = (N^2)*ones(N-1,1); %the diagonals directly beneath and above A
c = -(2*N^2)*ones(N-1,1); %the main diagonal of A
A = spdiags([b c b], [1 0 -1], N-1, N-1); %using spdiags to create A using the vectors b and c that we just created
A;

%[result,iterations_performed,flag] = FixedIterfunc(N,g1,20,10e-6) %works -
%5 iterations for N=100 and N = 1000


[result,iterations_performed,flag] = FixedIterfunc(N,g2,2,1) %does not work as expected -> does not hit stopping criteria

%[result,iterations_performed,flag] = FixedIterfunc(N,g3,5,10e-6) 
%gives inconsistent solutions for first few iterations and then plots
%trivial solution for any n iterations after
% -> fixed iteration not effective for this function -> divergent

U_final = [0,result',0]

x = [0,x,1] 

plot(x,U_final)
xlabel('x') 
ylabel('u(x)')

fprintf('Iterations Performed = %d \n',iterations_performed);

fprintf('Flag = %d \n', flag);

%%
%Implementation of Newton's method (Newton-Raphson) for our problem:
%-u(x)'' + f(x,u) = 0, u(0) = u(1) = 0


g1 = @(x,U)([U] - [cos(x)]')./(2-[U]) - [exp(4.*x)]';
g2 = @(x,U) 3.*([U].^4 - 1) -[x.^2 .*exp(5.*x)]';
g3 = @(x,U) 200.*([U].^4 - 1) - [x.^2 .*exp(5.^x)]';

g1_u = @(x,U)(2-[cos(x)]')./([2-[U]].^2); %derivatives wrt u
g2_u = @(x,U)12.*[U.^3]
g3_u = @(x,U)800.*[U.^3]

%define N
N = 100

x = linspace(0,1,N+1)%define x
x(1) = []; x(end) = []; 

U = [zeros(N-1,1)]; %define U

%[result,iterations_performed,flag] = NewtonMethodfunc(N,g1,g1_u,20,10e-6) %works - 4 iterations for N = 100/1000

%[result,iterations_performed,flag] = NewtonMethodfunc(N,g2,g2_u,20,10e-6)
%works - 6 iterations for N = 100 and N = 1000

[result,iterations_performed,flag] = NewtonMethodfunc(N,g3,g3_u,20,10e-6)
%works - 16 iterations - solution appears to 'flatten' from n = 8 onwards

U_final = [0,result',0]

x = [0,x,1] 
plot(x,U_final)
xlabel('x') 
ylabel('u(x)')

fprintf('Iterations Performed = %d \n',iterations_performed);

fprintf('Flag = %d \n', flag);

