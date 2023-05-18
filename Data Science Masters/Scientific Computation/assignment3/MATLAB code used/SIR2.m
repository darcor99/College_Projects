function yprime = SIR2(t,y,Beta,gamma,k)

%SIR model adapted for question 3 and 4

yprime = [ -Beta.*[y(1:k)].*[y(k+1:2*k)] ; +Beta .* [y(1:k)].*[y(k+1:2*k)] - gamma.*[y(k+1:2*k)] ];
    
end
    