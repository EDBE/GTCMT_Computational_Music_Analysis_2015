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
window = hamming(windowSize, 'periodic');
window = repmat(window, 1, numBlocks);
freq_blocked_x = fft(window .* blocked_x);
mag_freq_blocked_x = abs(freq_blocked_x);
blocks = size(mag_freq_blocked_x, 1);

% 3, Spectral flux calculation
nvt = zeros(numBlocks, 1);
nvt = sqrt(sum(diff([mag_freq_blocked_x(:, 1), mag_freq_blocked_x], 1, 2) .^ 2) / blocks);
nvt = nvt';
end