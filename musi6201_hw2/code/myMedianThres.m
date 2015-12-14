% Adaptive threshold: median filter
% [thres] = myMedianThres(nvt, order, lambda)
% input: 
%   nvt: m by 1 float vector, the novelty function
%   order: int, size of the sliding window in samples
%   lambda: float, a constant coefficient for adjusting the threshold
% output:
%   thres = m by 1 float vector, the adaptive median threshold

function [thres] = myMedianThres(nvt, order, lambda)

% YOUR CODE HERE: 
N = size(nvt, 1);
thres_pad0 = zeros(N+order, 1);
nvt_pad0 = zeros(N+order, 1);
nvt_pad0(1:N) = nvt; 

for i = 1: N
        thres_pad0(i) = median(nvt_pad0(i: i + order)) + lambda;
end

thres = thres_pad0(1:N);