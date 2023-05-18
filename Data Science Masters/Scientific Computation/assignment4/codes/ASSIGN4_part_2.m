%ASSIGN 4 Part II

% from assign 1: matrix A for -u'' 

%Q1 -> take N = 40,80,160
N=40

x = linspace(0,1,N+1) 

%Matrix A from assign 1 for equation: -u'' = f
b = -(N^2)*ones(N-1,1); 
c = (2*N^2 + 0)*ones(N-1,1); 
A = spdiags([b c b], [1 0 -1], N-1, N-1); %
A;

lambdas = eig(A) %numerical lambda values corresponding to theoretical values for lambda >0

n = 1:N-1;

analytic_lam = (n.^2 .*pi.^2) %lambda >0 as in q1

plot(n,lambdas,'-o')
hold on
plot(n,analytic_lam,'-o','color','r')
hold off

legend("Numerical Eigenvalues", "Analytical Eigenvalues",'Location','southwest')
title('Comparing Plots of Numerical and Analytical Eigenvalues')
xlabel('n') 
ylabel('\lambda')

%%

%plot and compare the 30 smallest eigenvalues

N = 30000 %interested in N = 31,60,300,3000,30000

x = linspace(0,1,N+1)

b = -(N^2)*ones(N-1,1); 
c = (2*N^2 + 0)*ones(N-1,1); 
A = spdiags([b c b], [1 0 -1], N-1, N-1); %
A;

eigenv_numeric_30 = eigs(A,30, 'smallestabs')

n = 1:30
eigenv_analytical_30 = [(n.^2 .*pi.^2)]

plot(n,eigenv_numeric_30,'o-','color','blue')
hold on
plot(n,eigenv_analytical_30,'o-','color','red')
legend("First 30 smallest Numerical Eigenvalues", "First 30 Analytical Eigenvalues",'Location','southwest')
title('Plotting the first 30 smallest Numerical Eigenvalues vs the first 30 analytical eigenvalues')
xlabel('n') 
ylabel('\lambda')

maxerror = abs(eigenv_analytical_30(30)-eigenv_numeric_30(30))./eigenv_analytical_30(30)

%%


for N = [31,60,300,3000,30000] 
    x = linspace(0,1,N+1)

    b = -(N^2)*ones(N-1,1); 
    c = (2*N^2 + 0)*ones(N-1,1); 
    A = spdiags([b c b], [1 0 -1], N-1, N-1); %
    A;

    eigenv_numeric_30 = eigs(A,30, 'smallestabs')

    n = 1:30
    eigenv_analytical_30 = [(n.^2 .*pi.^2)]

    plot(n,eigenv_numeric_30,'o-')
    hold on
end
plot(n,eigenv_analytical_30,'o-','color','red')
hold off

legend("First 30 Numerical Eigenvalues N = 31","First 30 Numerical Eigenvalues N = 60","First 30 Numerical Eigenvalues N = 300","First 30 Numerical Eigenvalues N = 3000","First 30 Numerical Eigenvalues N = 30000", "First 30 Analytical Eigenvalues",'Location','southwest')
title('Plotting the first 30 smallest Numerical Eigenvalues vs the first 30 analytical eigenvalues for different N where Lv = -v^{\prime \prime}')
xlabel('n') 
ylabel('\lambda')



%%
%Consider Operator Lv = -v'' + a(x)v (from assignment 1 part II)

N = 3000 %N=31,60,300,3000,30000

x = linspace(0,1,N+1)

h = -(N^2)*ones(N-1,1); %the diagonals directly beneath and above A
g = (2*N^2)*ones(N-1,1); %the main diagonal of A
B = spdiags([h g h], [1 0 -1], N-1, N-1); %using spdiags to create A using the vectors b and c that we just created

a = [exp(x.^3 - x)]';
a(1) = []; a(end) = [];

C = spdiags([a], [0], N-1, N-1);
A2 = B + C;

%f2 = [cos(x.^2) + 3./(x+1)]'; %gives f for all x, we dont want f1 or fN+1 in calculating U
%f2(1) = []; f2(end) = []; %removes f(x1) and f(xN+1) from f
%U4 = D\f2; %finds U for U2....UN
%U = [0, U4', 0]'; %defines U(x1=0) =0 and U(xN+1 = 1) = 0

%compute 1st 30 eigenvalues of A

EigenVals30 = eigs(A2,30, 'smallestabs')

plot(1:30,EigenVals30,'o-')
title('Plotting the first 30 smallest Numerical Eigenvalues for Lv = -v^{\prime \prime} + a(x)v')
xlabel('n') 
ylabel('\lambda')

%%

for N = [31,60,300,3000,30000] 
    x = linspace(0,1,N+1)
    
    h = -(N^2)*ones(N-1,1); %the diagonals directly beneath and above A
    g = (2*N^2)*ones(N-1,1); %the main diagonal of A
    B = spdiags([h g h], [1 0 -1], N-1, N-1); %using spdiags to create A using the vectors b and c that we just created

    a = [exp(x.^3 - x)]';
    a(1) = []; a(end) = [];

    C = spdiags([a], [0], N-1, N-1);
    A2 = B + C;
    
    EigenVals30 = eigs(A2,30, 'smallestabs')
    n = 1:30
    
    plot(n,EigenVals30,'o-')
    hold on
end

title('Plotting the first 30 smallest Numerical Eigenvalues for Lv = -v^{\prime \prime} + a(x)v for different N values')
legend("N = 31","N = 60","N = 300","N = 3000","N = 30000",'Location','southwest')
xlabel('n') 
ylabel('\lambda')



%%

%calc reference eigenvalue so we can calculate relative errors:

M = 300000;
x = linspace(0,1,M+1)

h = -(M^2)*ones(M-1,1); %the diagonals directly beneath and above A
g = (2*M^2)*ones(M-1,1); %the main diagonal of A
B2 = spdiags([h g h], [1 0 -1], M-1, M-1); %using spdiags to create A using the vectors b and c that we just created
a = [exp(x.^3 - x)]';
a(1) = []; a(end) = [];
C2 = spdiags([a], [0], M-1, M-1);
A3 = B2 + C2;

LambdaRef = eigs(A3,30, 'smallestabs')
LambdaRef30 = LambdaRef(30)

maxerror = abs(LambdaRef30-EigenVals30(30))./LambdaRef30
