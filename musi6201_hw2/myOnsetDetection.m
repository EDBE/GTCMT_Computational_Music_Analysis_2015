% onset detection with adaptive thresholding
% [onsetTimeInSec] = myOnsetDetection(nvt, fs, windowSize, hopSize)
% input: 
%   x: N by 1 float vector, input signal
%   fs: float, sampling frequency in Hz
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   onsetTimeInSec: n by 1 float vector, onset time in second

function [onsetTimeInSec] = myOnsetDetection(x, fs, windowSize, hopSize)

% YOUR CODE HERE: 
nvt = mySpectralFlux(x, windowSize, hopSize);
thres = myMedianThres(nvt, 50, 1);
[peaks, index] = findpeaks(nvt);
for i = 1: size(peaks, 1)
   if peaks(i) < thres(i)
      peaks(i) = 0; 
   end
end


onsetTimeInSec = index * 1/fs;

