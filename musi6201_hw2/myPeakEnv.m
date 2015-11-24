% Novelty function: peak envelope
% [nvt] = myPeakEnv(x, w, windowSize, hopSize)
% input: 
%   x: N by 1 float vector, input signal
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   nvt: n by 1 float vector, the resulting novelty function 

function [nvt] = myPeakEnv(x, windowSize, hopSize)

% YOUR CODE HERE:

% 1, block the input signal 
[blocked_x numBlocks] = myBlockedInput(x, windowSize, hopSize);

% 2, extract peak envelop
nvt = zeros(numBlocks, 1);
for i = 1: numBlocks
    nvt(i) = max(abs(blocked_x(i,:)));
end
