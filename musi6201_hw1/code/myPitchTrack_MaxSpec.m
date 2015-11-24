% Blockwise Pitch Tracking based on Maximum Peak of Spectrum
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

% Please write your code here


% Step1: Block the input signal
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

% Step2: transfer signal to frequency domain
[blocked_x, numBlocks] = myBlockedInput(x, windowSize, hopSize);
f0 = zeros(numBlocks, 1);
timeInSec = zeros(numBlocks, 1);
for k = 1: numBlocks
   freq_blocked_x = fft(blocked_x(:,k));
   magn_blocked_x = abs(freq_blocked_x);
  
   [maxValue, maxIndex] = max(magn_blocked_x);
% %    if maxIndex > 1500/(fs/windowSize)
% %        break;
% %    else
      freq = (maxIndex-1) * fs/windowSize;

   % We also tried 'findpeaks'. It represented same result as 'max'   
%     [peaks, peaksIndex] = findpeaks(magn_blocked_x);
%     [maxValue, maxIndex] = max(peaks);
%     index = peaksIndex(maxIndex);
%     if index > 200
%         break;
%     else
%         freq = (index-1) * fs/windowSize;
   
       f0(k) = freq;
       timeInSec(k) = k * hopSize * (1/fs);
%     end
end    

% convert frequency to MIDI pitch
% pitchTrajectory = 69 + 12 .* log(f0 ./ 440);
% figure(2);
% plot(timeInSec, pitchTrajectory);

end