%assignment 1: using finite difference method to numerically solve the ODE:
%-u(x)'' + 4u(x) = exp(x), u(0) = u(1) = 0 

%define N number of subintervals between 0 and 1
N=100

x = linspace(0,1,N+1) %create vector of N+1 values of x between 0 and 1

%visualise ODE as matrix equation AU = F, where we are trying to solve for U

%create sparse Matrix A, which implements the 2nd order central finite difference
%method to our problem as a matrix equation. A is multiplied by U to give us the
%right hand side of our ODE 

b = -(N^2)*ones(N-1,1); %the diagonals directly beneath and above A
c = (2*N^2 + 4)*ones(N-1,1); %the main diagonal of A
A = spdiags([b c b], [1 0 -1], N-1, N-1); %using spdiags to create A using the vectors b and c that we just created
A;

f = [exp(x)]'; %gives f for all x, we dont want f1 or fN+1 in calculating U
f(1) = []; f(end) = []; %removes f(x1) and f(xN+1) from f

U = A\f %finds U for U2....UN

U1 = [0, U', 0]'; %defines U(x_1=0) =0 and U(x_N+1 = 1) = 0 


%full(U1) %gives solution vector U1

%%

%visualise the spare matrix we created using the spy function
spy(A)
%% 


%solve ODE with a full matrix


S = full(A)

U_ = S\f

U2 = [0, U_', 0]' %defines U(x1=0) =0 and U(xN+1 = 1) = 0
U2



%% 
spy(S)
%%


%plot analytic solution and numerical solution for different values of N on
%the same plot

%plot(x_analytic,u_analytic)
for N = [8,16,32,64,128,256] %plotting the numerical approximation of U(x) for different values of N
    x = linspace(0,1,N+1)
    U1 = NUMsolve1(N)
    plot(x,U1,'.')
    hold on
end
N = 1024 
x = linspace(0,1,N+1)
    
%plot analytical function
u_analytic = -1/3 * (((1- exp(-1))/(exp(-4) -1)) +1)*exp(2*x) + 1/3 * ((1- exp(-1))/(exp(-4) -1))*exp(-2*x) + 1/3 *(exp(x));


plot(x,u_analytic) %plotting the analytical function against x


hold off
title('Plot of Numerical Solution and Analytical solution for different Values of N')
legend({'N = 8','N = 16','N = 32','N = 64','N = 128','N = 256', 'Analytical Solution'},'Location','southwest')
xlabel('x') 
ylabel('u(x)')

%% 


%calculating the maximum difference between the analytical function and the
%numerical approximation that we created
errors = []';

for N = [8,16,32,64,128,256,512]
    x = linspace(0,1,N+1)
    U2 = NUMsolve1(N)
    y2 = [-1/3 * (((1- exp(-1))/(exp(-4) -1)) +1)*exp(2*x) + 1/3 * ((1- exp(-1))/(exp(-4) -1))*exp(-2*x) + 1/3 *(exp(x))]'

    diff1 = U2 -y2
    abs(diff1)
    errors(end+1) = max(abs(diff1))
end

errors 
%maximum nodal errors


%% 

%%%%%%%%%%%%%%% Part 2



%solving the following ODE for given a(x) and given f(x)
%-u(x)'' + a(x)*u(x) = f(x), u(0) = u(1) = 0 

%a(x) = exp(x^3 - x)

%f(x) = 5/(1+x+x^2)

%define N number of subintervals between 0 and 1
N=200

x = linspace(0,1,N+1) %create vector of N+1 values of x between 0 and 1

%visualise ODE as matrix equation AU = F, where we are trying to solve for
%U

%create sparse Matrix A, which implements the 2nd order central finite difference
%method to our problem as a matrix equation. A is multiplied by U to give us the
%right hand side of our ODE 

h = -(N^2)*ones(N-1,1); %the diagonals directly beneath and above A
g = (2*N^2)*ones(N-1,1); %the main diagonal of A
B = spdiags([h g h], [1 0 -1], N-1, N-1); %using spdiags to create A using the vectors b and c that we just created
B

a = [exp(x.^3 - x)]'
a(1) = []; a(end) = [];

C = spdiags([a], [0], N-1, N-1)


D = B + C


f2 = [cos(x.^2) + 3./(x+1)]'; %gives f for all x, we dont want f1 or fN+1 in calculating U
f2(1) = []; f2(end) = []; %removes f(x1) and f(xN+1) from f

U4 = D\f2 %finds U for U2....UN

U3 = [0, U4', 0]'; %defines U(x1=0) =0 and U(xN+1 = 1) = 0 

U3 %numerical solution vector for part II
%% 

plot(x,U3)
title('Plot of Numerical Solution to $$-u^{\prime \prime}(x) + exp(x^3 -x)\cdot u(x) = cos(x^2) + \frac{3}{x+1}$$','interpreter','latex')
xlabel('x') 
ylabel('u(x)')
%%
%%%%%%%%%%%find errors

%use NUMsolve2(N) function I defined to find double mesh errors by finding the maximum
%of the absolute value of the difference between U(N) and U(2N)
dmesh_errors = []';


for N = [16,32,64,128,256,512]
    x = linspace(0,1,N+1)
    U = NUMsolve2(N)
    U2 = NUMsolve2(2*N)
    
    U2(1:2:end-1) = [] %remove 2nd elements in U2 array so we can compare U wtih U2 on the same x points
    
    diff2 = U2 - U %difference between U(N) and U(2N)
 
    dmesh_errors(end+1) = max(abs(diff2))%compute double mesh error for each N
end

dmesh_errors %double mesh errors



