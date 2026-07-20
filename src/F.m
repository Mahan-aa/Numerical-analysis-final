function integral_val = F(x)
    n=1000; % Number of intervals for Simpson's rule - تعداد بازه‌ها برای قاعده سیمپسون
    integral_val = integrand(0) + integrand(mytan(x));
    h = mytan(x) / n;
    
    % Generate all t points simultaneously
    % تولید همزمان تمام نقاط t
    t = linspace(0, mytan(x), n + 1); 
    
    y = integrand(t); 
    
    % Apply Simpson's 1/3 rule weights: 1, 4, 2, 4, ..., 2, 4, 1
    % اعمال ضرایب قاعده ۱/۳ سیمپسون: ۱، ۴، ۲، ۴، ...، ۲، ۴، ۱
    integral_val = (h / 3) * (y(1) + 4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-2)) + y(end));

end

function y = myexp(x)
    % using Taylor series expansion for exp(x) since 0 < x < tan(0.5) ( x is close to 0 )
    % استفاده از بسط سری تیلور برای exp(x) چون 0 < x < tan(0.5) است (x نزدیک به صفر است)
    y = 0;
    for n = 0:50
        y = y + x.^n / factorial(n);
    end
end

function y = mytan(x)
    % using Taylor series expansion for sin and cos for the same reason as myexp since 0 < x < 0.5
    % استفاده از بسط سری تیلور برای سینوس و کسینوس به همان دلیلی که در myexp گفته شد، چون 0 < x < 0.5 است
    sin = 0;
    cos = 0;
    for n = 0:50
        sin = sin + (-1).^n * x.^(2*n + 1) / factorial(2*n + 1);
    end
    for n = 0:50
        cos = cos + (-1).^n * x.^(2*n) / factorial(2*n);
    end
    y = sin / cos;
    
end

function y = integrand(x)
    y = myexp(-1 * (x-1).^2);
end

