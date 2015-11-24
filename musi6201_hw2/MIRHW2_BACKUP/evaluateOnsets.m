%% Standard evaluation metrics 
% [precision, recall, fmeasure] = evaluateOnsets(onsetTimeInSec, annotation, deltaTime)
% intput:
%   onsetTimeInSec: n by 1 float vector, detected onset time in second
%   annotation: m by 1 float vector, annotated onset time in second
%   deltaTime: float, maximum time difference for a true positive (millisecond) 
% output:
%   precision: float, fraction of TP from all detected onsets
%   recall: float, fraction of TP from all reference onsets
%   fmeasure: float, the combination of precision and recall

function [precision, recall, fmeasure] = evaluateOnsets(onsetTimeInSec, annotation, deltaTime)

our = length(onsetTimeInSec);
actual = length(annotation);

deltaTime = deltaTime / 1000;

tp = 0;

halfDelta = deltaTime;
for i=1:our
    for j=1:actual
%         if(onsetTimeInSec(i) ~= -1 && annotation(j) ~= -1)
            % Check for true positive
            if(onsetTimeInSec(i) <= (annotation(j) + halfDelta) && onsetTimeInSec(i) >= (annotation(j) - halfDelta))
                tp = tp + 1;
                onsetTimeInSec(i) = -1;
                annotation(j) = -1;
            end
%         end
    end
end

%False Negative
fn = length(annotation(annotation~=-1));
fp = length(onsetTimeInSec(onsetTimeInSec~=-1));



if(tp + fp == 0)
    precision = 0;
else
    precision = tp / (tp + fp);

end


if(tp + fn == 0)
    recall = 0;
else
    recall = tp / (tp + fn);
end

if(precision + recall == 0)
    fmeasure = 0;
else
    fmeasure = 2*(precision * recall / (precision + recall));

end


