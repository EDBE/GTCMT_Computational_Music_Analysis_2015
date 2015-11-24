% Spectral Flux (SF): textbook page 44

% =================================
% Input
% X: spectrogram of input signal 
% fs: sample rate of input signal
% =================================
% Output
% sf: spectral flux
% =================================

%code starts from here:

function [sf] = mySF (mag_freq_blocked_x)
blocks = size(mag_freq_blocked_x, 1);

% 3, Spectral flux calculation
% sf = zeros(numBlocks, 1);
delta = diff([mag_freq_blocked_x(:, 1), mag_freq_blocked_x], 1, 2);
sf = sqrt(sum(delta.^ 2)) / blocks;
% sf = sf';

%     % difference spectrum (set first diff to zero)
%     diff_x = diff([X, X_Prev],1,2);
%     
%     % calculate the spectral flux
%     sf = sqrt(sum(diff_x.^2))/size(X,1);
end