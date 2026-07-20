clc;
clear;
close all;

syms x  t;
g = exp(-(t-1)^2);
F = int(g , t , 0 , tan(x));
d4F = diff(F , 4);
d4g = diff(g , 4);

%Print and plot:

fprintf("4th derivative of g: \n%s\n \n4th derivative of F: \n%s\n" , string(d4g) , string(d4F));
fprintf("\n-----------------------------------------\n")
d4g = matlabFunction(d4g);
d4F = matlabFunction(d4F);
x = linspace(0 , 0.5 , 1000);
d4F_x = arrayfun(d4F , x);
d4g_x  = d4g(x);

fig = figure('Position', [150, 400, 1400, 450]); 
subplot(1, 2, 1);
plot(x, d4g_x, 'b-', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('d4g(x)');
title('4th derivative of e^(-(x-1)^2)');

subplot(1, 2, 2);
plot(x, d4F_x, 'r-', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('d4F(x)');
title('4th derivative of F(x)');

%Upper Bounds:

abs_d4g = @(x) -abs(d4g(x));
abs_d4F = @(x) -abs(d4F(x));
[x1, x1val] = fminbnd(abs_d4g, 0, 0.5);
x1val = -x1val;
[x2, x2val] = fminbnd(abs_d4F, 0, 0.5);
x2val = -x2val;
fprintf("Maximum of |d4g| on [0, 0.5]: %.15f \nMaximum of |d4F| on [0, 0.5]: %.15f \n", x1val, x2val);