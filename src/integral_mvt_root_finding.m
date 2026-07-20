clc;
clear all;
close  all;

%First we use bisection method to get a smaller interval containing the root, for this porpuse
% we use symbolic calculations to get exact rational results:

n = 10; %number of terms we calculate
f = @(x) F(x) - 0.066647988010870;

%Initial inteval [a,b] and midpoint c, and the distance h the point c moves in the next step:
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

