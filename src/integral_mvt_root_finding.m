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

% Uses the Symbolic Math Toolbox (MATLAB) / symbolic package (Octave)
% از جعبه‌ابزار Symbolic Math (متلب) / بسته symbolic (اکتاو) استفاده می‌کند
if exist('OCTAVE_VERSION', 'builtin') ~= 0
    pkg load symbolic
end

n = 10;                              % number of bisection iterations - تعداد نقاطی که محاسبه می‌کنیم
f = @(x) F(x) - 0.066647988010870;   % target = average value of F on [0, 0.5] - هدف = مقدار میانگین F روی [0, 0.5]

% Initial interval [a, b], midpoint c, and step h that c moves by:
% بازه اولیه [a, b]، نقطه میانی c، و گام h که c با آن جابه‌جا می‌شود:
a = sym(0);
b = sym(0.5);
c = sym(0.5/2);
h = (0.5/4);

fprintf("%-40s %-40s \n------------------------------------------------\n" , "Interval", "Point");
for i = (1:n)
    interval = sprintf("[%s , %s]" , string(a) , string(b));
    fprintf("%-40s %-40s \n" , interval, string(c));

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
end
