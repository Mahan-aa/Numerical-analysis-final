%% =====================================================
%  All figures for the project are generated here.
%  Each section below is self-contained and recomputes what it
%  needs, so any section can be run on its own.
%% =====================================================

% Figures 2 and 3 below use the Symbolic Math Toolbox (MATLAB) /
% symbolic package (Octave)
if exist('OCTAVE_VERSION', 'builtin') ~= 0
    pkg load symbolic
end

%% Figure 1 : custom F(x) vs. MATLAB's built-in integration
%  (comparison of F.m's Simpson's rule + Taylor series approximation
%  against MATLAB's `integral`)

x_vals = linspace(0, 0.5, 200);

% Calculate custom F(x) values
y_custom = arrayfun(@F, x_vals);

% Calculate built-in version values
integrand_native = @(t) exp(-(t - 1).^2);
y_native = arrayfun(@(x) integral(integrand_native, 0, tan(x)), x_vals);

fig1 = figure('Position', [50, 100, 1400, 450]);

% --- Subplot 1: Custom F(x) ---
subplot(1, 3, 1);
plot(x_vals, y_custom, 'b-', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('F(x)');
title('Custom F(x) using Simpson''s Rule & Taylor Series');

% --- Subplot 2: F(x) using built-in functions ---
subplot(1, 3, 2);
plot(x_vals, y_native, 'r--', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('Integral Value');
title('F(x) using built-in functions');

% --- Subplot 3: both put together ---
subplot(1, 3, 3);
plot(x_vals, y_custom, 'b-', 'LineWidth', 2.5);
hold on;
plot(x_vals, y_native, 'r--', 'LineWidth', 1.5);
grid on;
xlabel('x');
ylabel('Comparison');
title('Combined Comparison');
legend('Custom F(x)', 'Built-in', 'Location', 'best');
hold off;

% Save the entire 3-panel figure as a PNG image
saveas(fig1, '../figures/comparison.png');

%% Figure 2 : 4th derivatives used for the Simpson's rule error bound
%  (see error_bounds.m for the numeric bound values)

syms x t;
g_sym = exp(-(t-1)^2);
F_sym = int(g_sym, t, 0, tan(x));
d4F_sym = diff(F_sym, 4);
d4g_sym = diff(g_sym, 4);

d4g_fn = matlabFunction(d4g_sym);
d4F_fn = matlabFunction(d4F_sym);

x_eb = linspace(0, 0.5, 1000);
d4F_x = arrayfun(d4F_fn, x_eb);
d4g_x = d4g_fn(x_eb);

fig2 = figure('Position', [150, 400, 1400, 450]);

subplot(1, 2, 1);
plot(x_eb, d4g_x, 'b-', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('d4g(x)');
title('4th derivative of e^{-(x-1)^2}');

subplot(1, 2, 2);
plot(x_eb, d4F_x, 'r-', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('d4F(x)');
title('4th derivative of F(x)');

%% Figure 3 : derivative Mean Value Theorem point
%  (F'(x) samples, interpolating polynomial p(x), and the point
%  (c, p(c)) found in derivative_mvt.m)

n_pts = 20;
x_d = linspace(0, 0.5, n_pts);
h_d = (x_d(2) - x_d(1)) / 1000;

dF = zeros(1, n_pts);
for i = 1:n_pts
    dF(i) = (F(x_d(i) + h_d) - F(x_d(i) - h_d)) / (2*h_d);
end

syms X
p_sym = 0;
for i = 1:n_pts
    L = 1;
    for j = 1:n_pts
        if j ~= i
            L = L * (X - x_d(j)) / (x_d(i) - x_d(j));
        end
    end
    p_sym = p_sym + dF(i) * L;
end
p_sym = expand(p_sym);
p = matlabFunction(p_sym);

m = F(0.5) / 0.5;   % average slope of F on [0, 0.5]

% Bisection to find c such that p(c) = m
g_root = @(x) p(x) - m;
a = 0; b = 0.5; tol = 1e-8;
while (b - a)/2 > tol
    c = (a + b)/2;
    if g_root(a)*g_root(c) < 0
        b = c;
    else
        a = c;
    end
end
c = (a + b)/2;

t_d = linspace(0, 0.5, 1000);
p_t = p(t_d);

fig3 = figure('Position', [1000, 100, 650, 600]);

plot(x_d, zeros(1, n_pts), 'r|', 'LineWidth', 2);
hold on;
plot(x_d, dF, 'r.', 'MarkerSize', 20);
hold on;
plot(t_d, p_t, 'g', 'LineWidth', 2);
hold on;
plot(c, p(c), 'yo', 'MarkerSize', 8, 'LineWidth', 2);
grid on;
legend("x(i)", "F'(x(i))", "p(x)", "(c, p(c))");

% Keep the comparison figure window open until closed
waitfor(fig1);
