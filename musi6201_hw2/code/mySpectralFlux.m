% Novelty function: spectral flux
% [nvt] = myPeakEnv(x, w, windowSize, hopSize)
% input: 
%   x: N by 1 float vector, input signal
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   nvt: n by 1 float vector, the resulting novelty function 

function [nvt] = mySpectralFlux(x, windowSize, hopSize)

% YOUR CODE HERE: 

% 1, Block the signal
[blocked_x, numBlocks] = myBlockedInput(x, windowSize, hopSize);

% 2, FFT for each block
freq_blocked_x = fft(blocked_x);
mag_freq_blocked_x = abs(freq_blocked_x);

% 3, Spectral flux calculation
nvt = zeros(numBlocks, 1);
nvt = sqrt(sum(diff([mag_freq_blocked_x(:, 1), mag_freq_blocked_x], 1, 2) .^ 2) / size(mag_freq_blocked_x, 1))';

end