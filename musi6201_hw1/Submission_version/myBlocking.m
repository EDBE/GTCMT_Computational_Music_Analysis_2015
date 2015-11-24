% MUSI 6202 HW5 - My blocking 
% CW @ GTCMT 2015
% objective: partition your signal into overlapping blocks
% xmat = myBlocking(x, windowSize, hopSize)
% x = float, N*1 vector of input signal
% windowSize = int, window size in samples
% hopSize = int, hop size in samples
% xmat = float, windowSize*numBlocks matrix of signal

function [xmat] = myBlocking(x, windowSize, hopSize)

lenX = length(x);
numBlocks = ceil(((lenX-windowSize)/hopSize) + 1);
xmat = zeros(numBlocks, windowSize);
y = [x;zeros(windowSize,1)];

for i = 1:numBlocks
    strt = (i-1)*hopSize+1;
    fnsh = strt + windowSize-1;
    xmat(i,:) = y(strt:fnsh);
end

end
