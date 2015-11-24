% Spectral Crest Factor (SCF): textbook page 54

% =================================
% Input
% X: spectrogram of input signal 
% fs: sample rate of input signal
% =================================
% Output
% scr: spectral crest factor
% =================================

%code starts from here:

function [scr] = mySCR (X)

% for silent frames
   if sum(X, 1) == 0
      scr = 0; 
   else
    scr = max(abs(X),[],1) ./ sum(abs(X),1);
   end
end