%% Evaluate the results
% [err_rms] = myEvaluation(est, ann)
% Input:
%   estimation = numBlocks*1 float vector, estimated pitch (Hz) per block   
%   annotation = numBlocks*1 float vector, annotated pitch (Hz) per block
% Output:
%   errCent_rms = float, rms of the difference between estInMidi and annInMidi 
%                 Note: please exclude the blocks when ann(i) == 0
% CW @ GTCMT 2015

function [errCent_rms] = myEvaluation(estimation, annotation)

% Please write your code here

midiEst = FreqToMidi(estimation);
midiAnno = FreqToMidi(annotation);

length = size(midiAnno,1);
diffEst = zeros(length,1);

for i=1:length   
    if annotation(i) == 0
        midiAnno(i) = 0;
    end
    
    diffEst(i) = midiEst(i) - midiAnno(i);
    
    if diffEst(i) == -Inf
        diffEst(i) = 0;
    end 
        
end

figure;
plot(diffEst);
ylabel('frequency (in MIDI)');
xlabel('time (in Seconds)');
title('Difference in MIDI (Autocorrelation) of audio: 63 M2 AMairena');

errCent_rms = rms(diffEst);