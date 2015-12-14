% Maximum Envelop (ME): textbook page 

% =================================
% Input
% X: block of input signal (time domain)
% fs: sample rate of input signal
% =================================
% Output
% me: maximum envelope
% =================================

%code starts from here:

function [me] = mySME (block)

me = max(abs(block));

end