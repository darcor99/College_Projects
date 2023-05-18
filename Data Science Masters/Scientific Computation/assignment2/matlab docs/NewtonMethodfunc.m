function [result,iterations_performed,flag] = NewtonMethodfunc(N,g,g_u,k_MAX,TOL)%outputs result, no. of iterations performed and flag
%input -> size of mesh N, input function g,derivative of g wrt u:  g_u , k_max no. of max iterations and
%stopping criterion TOL
x = linspace(0,1,N+1)
x(1) = []; x(end) = []; 

U = [zeros(N-1,1)];

iterations_performed = 0

    for range = 1:k_MAX
            Un = -[g(x,U)] + [g_u(x,U)].*U;%rhs u(n)_
            Un
            
            b = -(N^2)*ones(N-1,1); %the diagonals directly beneath and above A
            c = (2*N^2)*ones(N-1,1); %the main diagonal of A
            A = spdiags([b c b], [1 0 -1], N-1, N-1); %using spdiags to create A using the vectors b and c that we just created
            
            a = [g_u(x,U)];
            B = spdiags([a], [0], N-1, N-1);

            C = A+B;
            
            
            U_next = C\(Un); %find lhs -> calculates u(n+1) %U_next represents u(n+1)
            diff = [U_next - U];
            
            
            iterations_performed = iterations_performed + 1;
            
            
            
            if  (max(abs(diff)) < TOL) & (max(abs(A*U_next + g(x,U_next)  )) < TOL  )
                flag = 1;
                break
                
            else
                flag = 0;
                U = U_next;
            end
            
    end
    
    result = U_next
    iterations_performed = iterations_performed
    flag
            
end


