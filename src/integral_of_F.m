%% =====================================================
%  Computes ∫[0, 0.5] F(t) dt using Simpson's rule.
%  Dividing this by the interval length (0.5) gives the average
%  value of F on [0, 0.5], used as the target in
%  integral_mvt_root_finding.m.
%% =====================================================

clc;
clear all;
close all;
format long;

n = 1000;           % number of intervals for Simpson's rule
h = 0.5 / n;

x = linspace(0, 0.5, n+1);
y = arrayfun(@F, x);

% Integral of F from 0 to 0.5, using Simpson's rule:
integral_val_F = (h / 3) * (y(1) + 4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-2)) + y(end));
fprintf("Integral of F from 0 to 0.5: %.15f \n", integral_val_F);
