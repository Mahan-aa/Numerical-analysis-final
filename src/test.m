integrand = @(x) exp(-(x - 1).^2);
b = tan(0.4);
integral_val = integral(integrand, 0, b);
fprintf('The integral of exp((x-1)^2) from 0 to tan(0.4) using my approximation: %f\n', F(0.4));
fprintf('real value: %f\n', integral_val);


