function [result,iterations_performed,flag] = DampedNewtonfunc(N,g,g_u,k_MAX,TOL)%outputs result, no. of iterations performed and flag
%input -> size of mesh N, input function g,derivative of g wrt u:  g_u , k_max no. of max iterations and
%stopping criterion TOL
x = linspace(0,1,N+1)
x(1) = []; x(end) = []; 

U = [zeros(N-1,1)];


k = [0:5]
alphas = [1./(2.^k)]


iterations_performed = 0

    for range = 1:k_MAX
            Un = -[g(x,U)] + [g_u(x,U)].*U;%rhs u(n)_
            
            
            b = -(N^2)*ones(N-1,1); %the diagonals directly beneath and above A
            c = (2*N^2)*ones(N-1,1); %the main diagonal of A
            A = spdiags([b c b], [1 0 -1], N-1, N-1); %using spdiags to create A using the vectors b and c that we just created
            
            a = [g_u(x,U)];
            B = spdiags([a], [0], N-1, N-1);

            C = A+B;
            
            
            U_next = C\(Un); %find lhs -> calculates u(n+1) %U_next represents u(n+1)
            
            
            
            V= U_next - U
            
            test_vals = []
            for i = 1:length(alphas)
                %index of min value of f(x,Un+alpha*V) should correspond to the optimum alpha's
                %index
                
                test_vals(end+1) = max(abs(A*(U + alphas(i).*V ) + g(x,U + alphas(i).*V ) ) )  
            end
            [M, I] = min(test_vals)
            alpha_optimum = alphas(I)
            
            diff = [(U+ alpha_optimum.*V) - U];
            
            
            iterations_performed = iterations_performed + 1;
            
            
            
            if  (max(abs(diff)) < TOL) & (max(abs(A*(U+ alpha_optimum.*V) + g(x,(U+ alpha_optimum.*V))  )) < TOL  )
                flag = 1;
                break
                
            else
                flag = 0;
                U = (U+ alpha_optimum.*V);
            end
            
    end
    
    result = (U+ alpha_optimum.*V)
    iterations_performed = iterations_performed
    flag
            
end


