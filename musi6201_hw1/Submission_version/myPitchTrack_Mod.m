%% Blockwise Pitch Tracking using Modified Approach
% [pitch, time] = myPitchTrack_Mod(x, windowSize, hopSize, fs)
% Input:
%   x = N*1 float vector, input signal
%   windowSize = int, window size of the blockwise process
%   hopSize = int, hop size of the blockwise process
%   fs = float, sample rate in Hz
% Output:
%   pitch = numBlocks*1 float vector, detected pitch (Hz) per block
%   time  = numBlocks*1 float vector, time stamp (sec) of each block
% CW @ GTCMT 2015

function [pitch, time, power] = myPitchTrack_Mod(x, windowSize, hopSize, fs)


%% Please write your code here

% initialization 
xmat = myBlocking(x, windowSize, hopSize);
[rowsXmat, colsXmat] = size(xmat);

numBlocks = rowsXmat;
f0 = zeros(numBlocks, 1);
timeInSec = zeros(numBlocks, 1);

% Apply a window function
window = hamming(windowSize, 'periodic');
[rowsXmat, colsXmat] = size(xmat);

for i=1:numBlocks
    o = correlation(xmat(i,:), xmat(i,:));
    xmat(i,:) = fft(window'.*(xmat(i,:)));
    mag = abs(xmat(i,:));
    
    p = (norm(mag)^2)/length(mag);
    pdb = pow2db(p);
    
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
        
        % Check if fundamental is too high
        if(freq > 2000)
            freq = 0;
        end
        
        %Check if power is too low
        if(pdb <= -8)
            freq = 0;
        end
        
    else 
        freq = 0;
    end
        
    %Convert to frequency
    pitch(i) =  freq;
    power(i)= pdb;
    time(i) = i * hopSize * (1/fs); 
end

pitch = medfilt1(pitch, 10);

end