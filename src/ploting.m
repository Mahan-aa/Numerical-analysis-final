x_vals = linspace(0, 0.5, 200); 

% Calculate custom F(x) values
y_custom = arrayfun(@F, x_vals);

% Calculate built-in version values
integrand_native = @(t) exp(-(t - 1).^2);
y_native = arrayfun(@(x) integral(integrand_native, 0, tan(x)), x_vals);


fig = figure('Position', [50, 100, 1400, 450]); 

% --- Subplot 1: Custom F(x) ---
subplot(1, 3, 1);
plot(x_vals, y_custom, 'b-', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('F(x)');
title('Custom F(x) using Simpson''s Rule & Taylor Series');

% --- Subplot 2: F(x) using built-in Functions ---
subplot(1, 3, 2);
plot(x_vals, y_native, 'r--', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('Integral Value');
title('F(x) using built-in functions');

% --- Subplot 3: Both Put Together ---
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
saveas(fig, '../figures/comparison.png');

% Keep the window open
waitfor(fig); 

