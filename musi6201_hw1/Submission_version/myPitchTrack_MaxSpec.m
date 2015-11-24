%% Blockwise Pitch Tracking based on Maximum Peak of Spectrum
% [f0, timeInSec] = myPitchTrack_MaxSpec(x, windowSize, hopSize, fs)
% Input:
%   x = N*1 float vector, input signal
%   windowSize = int, window size of the blockwise process
%   hopSize = int, hop size of the blockwise process
%   fs = float, sample rate in Hz
% Output:
%   f0 = numBlocks*1 float vector, detected pitch (Hz) per block
%   timeInSec  = numBlocks*1 float vector, time stamp (sec) of each block
% CW @ GTCMT 2015

function [f0, timeInSec] = myPitchTrack_MaxSpec(x, windowSize, hopSize, fs)

    % Initialization 
    xLen = length(x);

    % Apply blocking
    xmat = myBlocking(x, windowSize, hopSize);
    [rowsXmat, colsXmat] = size(xmat);

    compl = zeros(rowsXmat, colsXmat);

    % Apply a window function
    window = hamming(windowSize, 'periodic');
    [rowsXmat, colsXmat] = size(xmat);

    % Make sure blockSize == colsXmat
	for i = 1:rowsXmat
        xmat(i,:) = fft(window'.*(xmat(i,:)));
        mag = abs(xmat(i,:));
        %thresh = ceil(windowSize/fs*1);
        thresh = 1;
        cap = ceil(windowSize/fs*2000);
        [maxValue, maxIndex] = max(mag(1: cap));
        
        [peaks, locs] = findpeaks(mag(1: cap));
        if ~isempty(locs)
            if size(locs,1)>2
              diff = locs(2)-locs(1);
              q = abs(diff-locs(1))/locs(1);
              if q<0.1
                maxIndex = locs(1);
              else 
                maxIndex = locs(2);
              end
            end
        end
        
        freq = (maxIndex+thresh-2) * fs/windowSize;
    
        %Outputs
        f0(i) = freq;
        timeInSec(i) = i * hopSize * (1/fs);
        
    end
    
    f0 = f0';
    
end