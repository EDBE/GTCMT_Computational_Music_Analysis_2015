%% Blockwise Pitch Tracking based on ACF
% [f0, timeInSec] = myPitchTrack_ACF(x, windowSize, hopSize, fs)
% Input:
%   x = N*1 float vector, input signal
%   windowSize = int, window size of the blockwise process
%   hopSize = int, hop size of the blockwise process
%   fs = float, sample rate in Hz
% Output:
%   f0 = numBlocks*1 float vector, detected pitch (Hz) per block
%   timeInSec  = numBlocks*1 float vector, time stamp (sec) of each block
% CW @ GTCMT 2015

function [f0, timeInSec] = myPitchTrack_ACF(x, windowSize, hopSize, fs)

% initialization 
xmat = myBlocking(x, windowSize, hopSize);
[rowsXmat, colsXmat] = size(xmat);

numBlocks = rowsXmat;
f0 = zeros(numBlocks, 1);
timeInSec = zeros(numBlocks, 1);

for i=1:numBlocks
    o = correlation(xmat(i,:), xmat(i,:));
    oLen = size(o,1);   
    % Length is 2*windowSize - 1;
    % ceil((oLen-1)/2) represents half way at freq = 0
    offset = oLen / fs;
    
    mid = ceil((oLen-1)/2);
    thresh = ceil(offset*10);
    [peaks, locs] = findpeaks(o(mid + thresh:end));    
    
    [maxValue, maxIndex] = max(peaks);
    %index = locs(maxIndex+1) - locs(maxIndex);
    if ~isempty(maxIndex)
        index = locs(maxIndex);
        freq = fs/(index + thresh-2);

        if(freq > 2000)
            freq = 0;
        end
    else 
        freq = 0;
    end
        
    %Convert to frequency
    f0(i) =  freq;
    timeInSec(i) = i * hopSize * (1/fs); 
end


end
