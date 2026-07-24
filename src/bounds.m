%% =====================================================
%  Simpson's rule error bounds
%  Computes the 4th derivatives of g(t) = exp(-(t-1)^2) and of
%  F(x) = ∫[0,tan(x)] g(t) dt, then finds their maximum absolute
%  value on [0, 0.5] (used to bound the Simpson's rule error).
%
%  Figures for this script are generated separately in ploting.m
%
%  کران خطای قاعده سیمپسون
%  مشتق مرتبه چهارم g(t) = exp(-(t-1)^2) و همچنین
%  F(x) = ∫[0,tan(x)] g(t) dt را محاسبه می‌کند، سپس بیشینه قدر مطلق
%  آن‌ها را روی [0, 0.5] می‌یابد (برای کران خطای قاعده سیمپسون استفاده می‌شود).
%
%  نمودارهای این اسکریپت جداگانه در ploting.m تولید می‌شوند
%% =====================================================

clc;
clear;
close all;

% Uses the Symbolic Math Toolbox (MATLAB) / symbolic package (Octave)
% از جعبه‌ابزار Symbolic Math (متلب) / بسته symbolic (اکتاو) استفاده می‌کند
if exist('OCTAVE_VERSION', 'builtin') ~= 0
    pkg load symbolic
end

syms x t;
g = exp(-(t-1)^2);
F = int(g, t, 0, tan(x));
d4F = diff(F, 4);
d4g = diff(g, 4);

% Print symbolic 4th derivatives
% چاپ مشتق‌های مرتبه چهارم به‌صورت نمادین
fprintf("4th derivative of g: \n%s\n \n4th derivative of F: \n%s\n" , string(d4g) , string(d4F));
fprintf("\n-----------------------------------------\n")

d4g = matlabFunction(d4g);
d4F = matlabFunction(d4F);

x = linspace(0, 0.5, 1000);
d4F_x = arrayfun(d4F, x);
d4g_x = d4g(x);

%% Upper bounds: maximize |d4g| and |d4F| on [0, 0.5]
%  کران بالا: بیشینه‌سازی |d4g| و |d4F| روی [0, 0.5]

abs_d4g = @(x) -abs(d4g(x));
abs_d4F = @(x) -abs(d4F(x));

[x1, x1val] = fminbnd(abs_d4g, 0, 0.5);
x1val = -x1val;

[x2, x2val] = fminbnd(abs_d4F, 0, 0.5);
x2val = -x2val;

fprintf("Maximum of |d4g| on [0, 0.5]: %.15f \nMaximum of |d4F| on [0, 0.5]: %.15f \n", x1val, x2val);
