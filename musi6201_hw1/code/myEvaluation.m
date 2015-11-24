% Evaluate the results
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
