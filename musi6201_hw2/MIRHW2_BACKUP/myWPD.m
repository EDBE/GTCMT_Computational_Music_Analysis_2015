%% Novelty function: weighted phase deviation
% Paper : S. Dixon, 2006, onset detection revisited 
% [nvt] = myWPD(x, windowSize, hopSize)
% input: 
%   x: N by 1 float vector, input signal
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   nvt: m by 1 float vector, the resulting novelty function 

function [nvt] = myWPD(x, windowSize, hopSize)

% YOUR CODE HERE: 
% 1, Block the signal
[blocked_x, numBlocks] = myBlockedInput(x, windowSize, hopSize);

% 2, FFT for each block
window = hamming(windowSize, 'periodic');
window = repmat(window, 1, numBlocks);
freq_blocked_x = fft(window .* blocked_x);
mag_freq_blocked_x = abs(freq_blocked_x);
phase_freq_blocked_x = (angle(freq_blocked_x));

% 3, Weighted phase deviation calculation
pd  = zeros(numBlocks, 1);
for i = 3   : numBlocks
    % Normalize magnitude
    maxMag = max(mag_freq_blocked_x(:,i));
    minMag = min(mag_freq_blocked_x(:,i));
    mag_freq_blocked_x = ((mag_freq_blocked_x-minMag)./(maxMag-minMag));
    
    d1 = (unwrap(phase_freq_blocked_x(:,i)) - unwrap(phase_freq_blocked_x(:,i-1)));
    d2 = (unwrap(phase_freq_blocked_x(:,i-1)) - unwrap(phase_freq_blocked_x(:,i-2)));
    sd3 = mod((d1 - d2),2*pi) - pi;
    pd(i) = sum(abs(mag_freq_blocked_x(:,i) .* sd3))/windowSize;
end
pd(1) = pd(3);
pd(2) = pd(3);
nvt = pd;
