%% =====================================================
%  All figures for the project are generated here and saved as PNGs
%  in ../figures/. Each section below is self-contained and
%  recomputes what it needs, so any section can be run on its own.
%
%  تمام نمودارهای این پروژه در اینجا تولید و به‌صورت فایل PNG در
%  ../figures/ ذخیره می‌شوند. هر بخش در زیر مستقل است و هر چه لازم
%  دارد را خودش دوباره محاسبه می‌کند، بنابراین هر بخش را می‌توان
%  به‌تنهایی اجرا کرد.
%% =====================================================

% Figures 3 and 5 below use the Symbolic Math Toolbox (MATLAB) /
% symbolic package (Octave)
% نمودارهای ۳ و ۵ در زیر از جعبه‌ابزار Symbolic Math (متلب) /
% بسته symbolic (اکتاو) استفاده می‌کنند
if exist('OCTAVE_VERSION', 'builtin') ~= 0
    pkg load symbolic
end

figures_dir = '../figures';
if ~exist(figures_dir, 'dir')
    mkdir(figures_dir);
end

%% Figure 1 : custom F(x) vs. MATLAB's built-in integration
%  (comparison of F.m's Simpson's rule + Taylor series approximation
%  against MATLAB's `integral`)
%
%  نمودار ۱: F(x) دست‌ساز در برابر انتگرال‌گیری داخلی متلب
%  (مقایسه تقریب قاعده سیمپسون + سری تیلور در F.m با تابع `integral` متلب)

x_vals = linspace(0, 0.5, 200);

% Calculate custom F(x) values
% محاسبه مقادیر F(x) دست‌ساز
y_custom = arrayfun(@F, x_vals);

% Calculate built-in version values
% محاسبه مقادیر با استفاده از تابع داخلی
integrand_native = @(t) exp(-(t - 1).^2);
y_native = arrayfun(@(x) integral(integrand_native, 0, tan(x)), x_vals);

fig1 = figure('Position', [50, 100, 1400, 450]);

% --- Subplot 1: Custom F(x) ---
% --- زیرنمودار ۱: F(x) دست‌ساز ---
subplot(1, 3, 1);
plot(x_vals, y_custom, 'b-', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('F(x)');
title('Custom F(x) using Simpson''s Rule & Taylor Series');

% --- Subplot 2: F(x) using built-in functions ---
% --- زیرنمودار ۲: F(x) با استفاده از توابع داخلی ---
subplot(1, 3, 2);
plot(x_vals, y_native, 'r--', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('Integral Value');
title('F(x) using built-in functions');

% --- Subplot 3: both put together ---
% --- زیرنمودار ۳: هر دو با هم ---
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

saveas(fig1, fullfile(figures_dir, 'comparison.png'));

%% Figure 2 : error between custom F(x) and the built-in integration
%  The two curves in Figure 1 overlap almost perfectly because the
%  error is tiny compared to F(x) itself, so it is plotted on its
%  own here with the y-axis zoomed to the error's actual range.
%
%  نمودار ۲: خطای بین F(x) دست‌ساز و انتگرال‌گیری داخلی
%  دو منحنی نمودار ۱ تقریباً کاملاً روی هم می‌افتند چون خطا در مقایسه
%  با خود F(x) بسیار ناچیز است، پس اینجا جداگانه و با محور y زوم‌شده
%  روی بازه واقعی خطا رسم می‌شود.

error_vals = y_custom - y_native;

fig2 = figure('Position', [50, 600, 700, 450]);
plot(x_vals, error_vals, 'm-', 'LineWidth', 2);
hold on;
plot([x_vals(1), x_vals(end)], [0, 0], 'k--');
hold off;
grid on;
xlabel('x');
ylabel('F_{custom}(x) - F_{built-in}(x)');
title('Error of custom F(x) vs. built-in integration');

% Zoom the y-axis to the error's own range (with a little padding)
% زوم محور y روی بازه خودِ خطا (با کمی حاشیه)
err_range = max(error_vals) - min(error_vals);
if err_range == 0
    err_range = eps;
end
ylim([min(error_vals) - 0.1*err_range, max(error_vals) + 0.1*err_range]);

saveas(fig2, fullfile(figures_dir, 'F_error.png'));

%% Figure 3 : 4th derivatives used for the Simpson's rule error bound
%  (see error_bounds.m for the numeric bound values)
%
%  نمودار ۳: مشتق‌های مرتبه چهارم استفاده‌شده برای کران خطای قاعده سیمپسون
%  (برای مقادیر عددی کران به error_bounds.m مراجعه شود)

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

fig3 = figure('Position', [150, 400, 1400, 450]);

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

saveas(fig3, fullfile(figures_dir, 'error_bounds.png'));

%% Figure 4 : Integral Mean Value Theorem point
%  Finds c in [0, 0.5] such that F(c) equals the average value of F
%  on [0, 0.5], and plots F(x) together with that average value and
%  the point (c, F(c)).
%
%  نمودار ۴: نقطه قضیه مقدار میانگین انتگرالی
%  یافتن c در [0, 0.5] به‌طوری‌که F(c) برابر با مقدار میانگین F روی
%  [0, 0.5] باشد، و رسم F(x) همراه با آن مقدار میانگین و نقطه (c, F(c)).

n_int = 1000;   % intervals for Simpson's rule - تعداد بازه‌ها برای قاعده سیمپسون
h_int = 0.5 / n_int;
x_int = linspace(0, 0.5, n_int + 1);
y_int = arrayfun(@F, x_int);

integral_F = (h_int / 3) * (y_int(1) + 4*sum(y_int(2:2:end-1)) + 2*sum(y_int(3:2:end-2)) + y_int(end));
avg_F = integral_F / 0.5;   % average value of F on [0, 0.5] - مقدار میانگین F روی [0, 0.5]

% Bisection to find c such that F(c) = avg_F
% روش دوبخشی برای یافتن c به‌طوری‌که F(c) = avg_F
G_root = @(x) F(x) - avg_F;
a = 0; b = 0.5; tol = 1e-8;
while (b - a)/2 > tol
    c_int = (a + b)/2;
    if G_root(a)*G_root(c_int) < 0
        b = c_int;
    else
        a = c_int;
    end
end
c_int = (a + b)/2;

x_F = linspace(0, 0.5, 500);
y_F = arrayfun(@F, x_F);

fig4 = figure('Position', [700, 600, 650, 500]);
plot(x_F, y_F, 'b-', 'LineWidth', 2);
hold on;
plot([x_F(1), x_F(end)], [avg_F, avg_F], 'k--', 'LineWidth', 1.5);
plot(c_int, F(c_int), 'yo', 'MarkerSize', 8, 'LineWidth', 2);
hold off;
grid on;
xlabel('x');
ylabel('F(x)');
title('Integral Mean Value Theorem');
legend('F(x)', 'average value', '(c, F(c))', 'Location', 'best');

saveas(fig4, fullfile(figures_dir, 'integral_mvt.png'));

%% Figure 5 : Derivative Mean Value Theorem point
%  (F'(x) samples, interpolating polynomial p(x), and the point
%  (c, p(c)) found in derivative_mvt.m)
%
%  نمودار ۵: نقطه قضیه مقدار میانگین مشتق
%  (نمونه‌های F'(x)، چندجمله‌ای درون‌یاب p(x)، و نقطه (c, p(c))
%  که در derivative_mvt.m یافت شده است)

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

m = F(0.5) / 0.5;   % average slope of F on [0, 0.5] - شیب متوسط F روی [0, 0.5]

% Bisection to find c such that p(c) = m
% روش دوبخشی برای یافتن c به‌طوری‌که p(c) = m
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

fig5 = figure('Position', [1000, 100, 650, 600]);

plot(x_d, zeros(1, n_pts), 'r|', 'LineWidth', 2);
hold on;
plot(x_d, dF, 'r.', 'MarkerSize', 20);
hold on;
plot(t_d, p_t, 'g', 'LineWidth', 2);
hold on;
plot(c, p(c), 'yo', 'MarkerSize', 8, 'LineWidth', 2);
grid on;
legend("x(i)", "F'(x(i))", "p(x)", "(c, p(c))");

saveas(fig5, fullfile(figures_dir, 'derivative_mvt.png'));

fprintf('Saved 5 figures to %s\n', figures_dir);
