%% onset detection with adaptive thresholding
% [onsetTimeInSec] = myOnsetDetection(nvt, fs, windowSize, hopSize)
% input: 
%   x: N by 1 float vector, input signal
%   fs: float, sampling frequency in Hz
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   onsetTimeInSec: n by 1 float vector, onset time in second

function [onsetTimeInSec] = myOnsetDetection(nvt, fs, windowSize, hopSize)

%Normalize nvt from [0,1]
maxNvt = max(nvt);
minNvt = min(nvt);
nvt = ((nvt-minNvt)./(maxNvt-minNvt));

%Calculate the adaptive threshold 
out = myMedianThres(nvt, 33, 0.5);

% %Normalize out from [0,1]
% maxOut = max(out);
% minOut = min(out);
% out = ((out-minOut)./(maxOut-minOut));

% figure;
% plot(nvt,'red');
% hold on;
% plot(out,'green');
% hold off;

lengthNvt = length(nvt(:,1));

%Calculate the onsets
[onsets, locs] = findpeaks(out);

%Calculate time
onsetTimeInSec = locs .* hopSize/fs;


