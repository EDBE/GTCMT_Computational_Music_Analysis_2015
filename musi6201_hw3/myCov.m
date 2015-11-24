function [covariance_matrix] = myCov(x)

% ====================================
% input: x is a matrix

% ====================================
% output: covariance matrix of x 

% code starts from here;
% xx = x - mean(x, 1);
% yy = y - mean(y, 1);

x = x';
for i = 1: size(x, 1)
    
    xx(i, :) = x(i, :) - mean(x(i, :));

end

covariance_matrix = 1 / ((size(x, 2) - 1)) * xx * xx';
