%% =====================================================
%  Numerical Analysis Project
%  Function:
%  F(x) = ∫[0,tan(x)] exp(-(t-1)^2) dt
%  Interval: [0, 0.5]
%
%  Goal: find c in (0, 0.5) satisfying the Mean Value Theorem
%  for Derivatives:  F'(c) = (F(b) - F(a)) / (b - a)
%
%  Figures for this script are generated separately in ploting.m
%
%  پروژه تحلیل عددی
%  تابع:
%  F(x) = ∫[0,tan(x)] exp(-(t-1)^2) dt
%  بازه: [0, 0.5]
%
%  هدف: یافتن c در (0, 0.5) که در قضیه مقدار میانگین برای مشتق صدق کند:
%  F'(c) = (F(b) - F(a)) / (b - a)
%
%  نمودارهای این اسکریپت جداگانه در ploting.m تولید می‌شوند
%% =====================================================

clc
clear
close all

% Uses the Symbolic Math Toolbox (MATLAB) / symbolic package (Octave)
% از جعبه‌ابزار Symbolic Math (متلب) / بسته symbolic (اکتاو) استفاده می‌کند
if exist('OCTAVE_VERSION', 'builtin') ~= 0
    pkg load symbolic
end

%% =====================================================
%  Part 1 : Sample F'(x) at n points
%  (numerically, using the centered three-point method)
%  تولید نقاطی برای محاسبه مقادیر مشتق تابع (روش سه‌نقطه‌ای مرکزی)

n = 20;                        % number of sample points - تعداد نقاط
x = linspace(0, 0.5, n);
h = (x(2) - x(1)) / 1000;      % step size used in the three-point method - فاصله مورد استفاده در روش سه‌نقطه‌ای

dF = zeros(1, n);

for i = 1:n
    dF(i) = (F(x(i) + h) - F(x(i) - h)) / (2*h);
end

disp('Table of F''(x) values:')  % جدول مقادیر مشتق تابع
fprintf("   %-19s %-19s \n" , "x" , "F'(x)")
disp([x' dF'])

%% =====================================================
%  Part 2 : Polynomial interpolation of the derivative samples
%  درون‌یابی چند جمله‌ای

% Method 1: MATLAB's built-in fit
% روش ۱: برازش داخلی متلب
% p = polyfit(x, dF, n - 1);
% disp('Interpolating polynomial coefficients:')
% disp(p)
%%====================================
% Method 2: build the Lagrange interpolating polynomial by hand
% ساخت تابع چندجمله‌ای درون‌یاب لاگرانژ

syms X
p = 0;

for i = 1:n
    L = 1;

    for j = 1:n
        if j ~= i
            L = L * (X - x(j)) / (x(i) - x(j));
        end
    end

    p = p + dF(i) * L;
end

p = expand(p);
p = matlabFunction(p);

%% =====================================================
%  Part 3 : Secant (average) slope of F on [a, b]
%  شیب متوسط تابع  ( m = (F(b) - F(a)) / (b - a), and F(0) = 0 )

m = F(0.5) / 0.5;

disp('Average slope m = ')
disp(m)

%% =====================================================
%  Part 4 : Find c such that p(c) = m  (i.e. F'(c) = m)
%  یافتن ریشه

% Method 1: MATLAB's built-in root finder
% روش ۱: ریشه‌یاب داخلی متلب
% g = @(z) polyval(p, z) - m;
% c = fzero(g, [0 0.5]);
% disp('c = ')
% disp(c)
%%===============================
% Method 2: bisection method
% یافتن ریشه با روش دوبخشی

g = @(x) p(x) - m;
a = 0;
b = 0.5;
tol = 1e-8;

while (b - a)/2 > tol
    c = (a + b)/2;

    if g(a)*g(c) < 0
        b = c;
    else
        a = c;
    end
end

c = (a + b)/2;
disp('c = ')
disp(c)
