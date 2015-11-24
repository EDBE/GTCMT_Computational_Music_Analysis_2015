%% compute binary SDM matrix
% input:
%   SDM: numSamples by numSamples float matrix, self-distance matrix
%   threshold: float, constant value for thresholding the SDM
% output:
%   SDM_binary: numSamples by numSamples int matrix, binary SDM

function [SDM_binary] = computeBinSdm(SDM, threshold)

threshold = repmat(threshold, size(SDM));
SDM_binary = SDM > threshold;

figure();