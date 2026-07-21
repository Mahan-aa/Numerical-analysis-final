%% =====================================================
%  Integral Mean Value Theorem - root finding
%  Finds c in [0, 0.5] such that F(c) equals the average value of
%  F on [0, 0.5] (target value taken from integral_of_F.m: the
%  integral of F over [0, 0.5], divided by the interval length).
%
%  Bisection is used first with symbolic (exact rational) arithmetic
%  to narrow down the interval containing the root.
%
%  قضیه مقدار میانگین انتگرالی - یافتن ریشه
%  یافتن c در [0, 0.5] به‌طوری‌که F(c) برابر با مقدار میانگین F روی
%  [0, 0.5] باشد (مقدار هدف از integral_of_F.m گرفته شده: انتگرال F
%  روی [0, 0.5] تقسیم بر طول بازه).
%
%  ابتدا از روش دوبخشی با محاسبات نمادین (کسری دقیق) برای محدود کردن
%  بازه‌ی حاوی ریشه استفاده می‌شود.
%% =====================================================

clc;
clear all;
close all;
format long;

% Uses the Symbolic Math Toolbox (MATLAB) / symbolic package (Octave)
% از جعبه‌ابزار Symbolic Math (متلب) / بسته symbolic (اکتاو) استفاده می‌کند
if exist('OCTAVE_VERSION', 'builtin') ~= 0
    pkg load symbolic
end

%=========================================================
%Bisection method:
%روش دوبخشی:

n = 5;                                     % number of bisection iterations - تعداد نقاطی که محاسبه می‌کنیم
f = @(x) F(x) - 0.066647988010870 / 0.5;   % target = average value of F on [0, 0.5] - هدف = مقدار میانگین F روی [0, 0.5]

% Initial interval [a, b], midpoint c, and step h that c moves by:
% بازه اولیه [a, b]، نقطه میانی c، و گام h که c با آن جابه‌جا می‌شود:
a = sym(0);
b = sym(0.5);
c = sym(0.5/2);
h = (0.5/4);

fprintf("\nBisection Method: \n\n")
fprintf("   %-30s %-30s \n   ------------------------------------------------\n" , "Interval", "Point");
interval = sprintf("[%s , %s]" , string(a) , string(b));
fprintf("   %-30s %-30s \n" , interval, string(c));

for i = (1:n)
    f_c = f(double(c));
    if (f_c > 0)
        b = c;
        c = c - h;
    elseif (f_c < 0)
        a = c;
        c = c + h;
    else
        fprintf("Root found: %s" , string(c));
    end

    h = h / 2;

    interval = sprintf("[%s , %s]" , string(a) , string(b));
    fprintf("   %-30s %-30s \n" , interval, string(c));
end

%=========================================================
%Fixed point method:
%روش نقطه ثابت:

%First we calculate F'(c) using centered 3 point method:
%ابتدا مشتق F در نقطه c را با استفاده از روش سه‌نقطه‌ای مرکزی محاسبه می‌کنیم:

c = double(c);
h = 0.5 / 1000;
dF_c = (F(c + h) - F(c - h)) / (2*h);


%Then use this to define a function g for the fixed point algorithm, and use the starting point c:
%سپس از آن برای تعریف تابع g در الگوریتم نقطه ثابت استفاده می‌کنیم و نقطه شروع c را به کار می‌بریم:

g = @(x) x - f(x) / dF_c;
n = 6;                     %number of steps used for fixed-point algorithm - تعداد گام‌های استفاده‌شده در الگوریتم نقطه ثابت

fprintf("\nFixed-Point Method: \n\n");
fprintf("   %-8s %-20s \n   --------------------------\n", "Step", "Point");

for i = (1:n)
    c = g(c);
    fprintf("   %-8s %.15f \n" , string(i), c);
end