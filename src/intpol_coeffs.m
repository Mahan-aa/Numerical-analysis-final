% Interpolating polynomial coefficients.
% Takes n points (x(i), y(i)) given as arrays x, y, with x(i) equally
% spaced, and returns the coefficients of the (approximate)
% interpolating polynomial, using Newton's forward-difference formula.

function C = intpol_coeffs(x, y)
    % Uses the Symbolic Math Toolbox (MATLAB) / symbolic package (Octave)
    if exist('OCTAVE_VERSION', 'builtin') ~= 0
        pkg load symbolic
    end

    n = length(x);
    h = x(2) - x(1);
    A = zeros(n, n);   % table of finite differences

    % Calculate the differences:
    for i = (1:n)
        A(i,1) = y(i);
    end

    for j = (2:n)
        for i = (1:n-j+1)
            A(i,j) = A(i+1,j-1) - A(i,j-1);
        end
    end

    % Formulate the polynomial:
    syms t;
    term = 1;       % terms: 1, (t-x(1)), ..., (t-x(1))(t-x(2))...(t-x(n-1))
    p = A(1,1);     % the polynomial

    for j = (2:n)
        term = term * (t - x(j-1));
        p = p + A(1,j)/(factorial(j-1) * h^(j-1)) * term;
    end

    C = vpa(coeffs(p));
end
