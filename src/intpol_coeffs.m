%Interpolating polynomial coeefficients function: Takes n points (x(i) , y(i)) in arrays x, y (x(i)s equally spaced)
%and returns the coefficients of the interpolating polynomial of them(approximately):

function C = intpol_coeffs(x, y)
    n = length(x);
    h = x(2) - x(1);
    A = zeros(n, n);  %Table of differences

    %Calculating the differences:
    for i = (1:n)
        A(i,1) = y(i);
    end
    

    for j = (2:n)
        for i = (1:n-j+1)
            A(i,j) = A(i+1,j-1) - A(i,j-1);
        end
    end

    %Formulating the polynomial:
    syms t;
    term = 1;       %terms: 1 , (t-x(1)) , ... , (t-x(1))(t-x(2))...(t-x(n-1))
    p = A(1,1);     %the polynomial

    for j = (2:n)
        term = term * (t - x(j-1));
        p = p + A(1,j)/(factorial(j-1) * h^(j-1)) * term;
    end
    
    C = vpa(coeffs(p));
    