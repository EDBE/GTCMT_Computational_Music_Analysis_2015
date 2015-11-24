%% Blockwise Pitch Tracking using Modified Approach
% [pitch, time] = myPitchTrack_Mod(x, windowSize, hopSize, fs)
% Input:
%   x = N*1 float vector, input signal
%   windowSize = int, window size of the blockwise process
%   hopSize = int, hop size of the blockwise process
%   fs = float, sample rate in Hz
% Output:
%   pitch = numBlocks*1 float vector, detected pitch (Hz) per block
%   time  = numBlocks*1 float vector, time stamp (sec) of each block
% CW @ GTCMT 2015

function [pitch, time] = myPitchTrack_Mod(x, windowSize, hopSize, fs)


%% Please write your code here