function [result,iterations_performed,flag] = FixedIterfunc(N,g,k_MAX,TOL) %outputs result, no. of iterations performed and flag
%input -> size of mesh N, input function g, k_max no. of max iterations and
%stopping criterion TOL

x = linspace(0,1,N+1);
x(1) = []; x(end) = []; 

U = [zeros(N-1,1)]';

b = (N^2)*ones(N-1,1); %the diagonals directly beneath and above A
c = -(2*N^2)*ones(N-1,1); %the main diagonal of A
A = spdiags([b c b], [1 0 -1], N-1, N-1); %using spdiags to create A using the vectors b and c that we just created
A;

iterations_performed = 0

    for range = 1:k_MAX
            Un = g(x,U);%rhs u(n)_
            U_next = A\(Un); %find lhs -> calculates u(n+1)
            diff = [U_next - U'];
            iterations_performed = iterations_performed + 1;
            
            
            if  ( max(abs(diff)) < TOL ) & ( max(abs(-A*U_next + g(x,U))) < TOL ); 
                flag = 1;
                break
                
            else
                flag = 0;
                U = U_next';
            end  
    end
    
    result = U_next
    iterations_performed = iterations_performed
    flag     
end