function [Pe] = Pe16QAM(P, sigma2)
    x = sqrt(2 * P / (10 * sigma2)); % given...
    Pe = 1 - (1 - qfunc(x))^2; % 16-QAM Pe=1-(1-Q(x))^2 union bound
end
