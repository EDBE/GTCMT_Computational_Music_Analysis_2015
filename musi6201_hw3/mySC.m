% Spectral Centroid (SC): textbook page 45

% =================================
% Input
% X: spectrogram of input signal 
% fs: sample rate of input signal
% =================================
% Output
% sc: spectral centroid (in Hz)
% =================================

function [sc] = mySC (X, fs)

    X	= X.^2;
    % for silent frames
    if sum(X, 1) == 0
       sc = 0; 
    else
        sc = ([0:size(X,1)-1]*X)./sum(X,1);
        % calculate frequency from index
        sc = sc / size(X,1) * fs/2;
    end
end