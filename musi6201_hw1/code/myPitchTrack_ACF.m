% Blockwise Pitch Tracking based on ACF
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

% Please write your code here

% Block the input signal
    function [blocked_x, numBlocks] = myBlockedInput(x, windowSize, hopSize)
        blocked_x = [];
        for i = 1: hopSize: length(x)
            if i + windowSize > length(x)
                break;
            else
                blocked_x = [blocked_x, x(i: i+windowSize)];
            end
        end
        numBlocks = size(blocked_x, 2);
    end

% general correlation function for input signal a and b
    function y = myCorrelation(a, b)    
        L = size(a, 1);
        M = size(b, 1);
        y = zeros((L+M-1), 1);
        
        N = L+M-1;
        temp = zeros(N, 1);
        a_0pad = temp;
        a_0pad(M:end) = a;
        b_0pad = temp;
        b_0pad(1:M) = b;
        
        for j = 1: N
            y(j) = y(j) + [b_0pad(1:j)]' * a_0pad(N-j+1: end);
        end
    end


[blocked_x, numBlocks] = myBlockedInput(x, windowSize, hopSize);
f0 = zeros(numBlocks, 1);
timeInSec = zeros(numBlocks, 1);
% numBlocks

for k = 1: numBlocks
    y = myCorrelation(blocked_x(:, k), blocked_x(:, k));
%       y = xcorr(blocked_x(:,k));

%     y = y(( (length(y)+1) / 2 ) + 30: ( (length(y)+1) / 2 ) + 1000);
    y = y(( (length(y)+1) / 2 ) + 15: end);
%     y = y(( (length(y)+1) / 2 ) + ceil(fs/windowSize): end);
     
    [peaks, peaksIndex] = findpeaks(y);
    [maxValue, maxIndex] = max(peaks);
    index = peaksIndex(maxIndex);
    freq = 1 / ((index+14) * 1/fs);
%     freq = 1 / ((index+ceil(fs/windowSize)-1) * 1/fs);
%     if freq > 1500
%         break;
% %     elseif freq < 50
% %         break;
%     else
        
    


%     [maxValue, maxIndex] = max(y);
%     freq = 1 / ((maxIndex+10-1) * 1/fs);
    
    %belowFifty = floor(fs/50);
    %aboveTwoK = ceil(fs/2000);   
    %peaksIndex(peaksIndex<aboveTwoK) = [];
    %f0(k) = fs/peaksIndex(1);
    
    f0(k) = freq;
    timeInSec(k) = (k)*hopSize*1/fs;
    

end    
%converting the frequency to MIDI pitch
%     pitchTrajectory = 69 + 12 .* log(f0 ./ 440);
%     figure(1);
%     plot(timeInSec, pitchTrajectory);

end