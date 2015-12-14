% Zero Crossing Rate: textbook page 62

% =================================
% Input
% X: input signal 
% windowSize
% hopSize
% fs: sample rate of input signal
% =================================
% Output
% zcr: zero crossing rate (1 by numBlocks)
% timeStamp: timestamp of zero crossing (1 by numBlocks)
% =================================

%code starts from here:

function [zcr, timeStamp] = myZCR(blocked_x, numBlocks, hopSize, fs)
    % initialize the zcr
    zcr = zeros(1,numBlocks);
    windowSize = size(blocked_x,1);
    
    % compute time stamps
    timeStamp = ((0: numBlocks-1) * hopSize + (windowSize/2))/fs;
    
    for i = 1:numBlocks
        % compute the zero crossing rate
        zcr(i) = 0.5 * mean(abs(diff(sign(blocked_x(:,i)))));
    end
end