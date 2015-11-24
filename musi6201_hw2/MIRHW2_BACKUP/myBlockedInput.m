function [blocked_x, numBlocks] = myBlockedInput(x, windowSize, hopSize)
    blocked_x = [];
    for i = 1: hopSize: length(x)
        if i + windowSize -1 > length(x)
            break;
        else
                blocked_x = [blocked_x, x(i: i+windowSize-1)];
        end
    end
    numBlocks = size(blocked_x, 2);    
end