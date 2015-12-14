% compute lag distance matrix 
% input:
%   SDM: numSamples by numSamples float matrix, self-distance matrix
% output:
%   R: numSamples by numSamples float matrix, lag-distance matrix
% Note: R should be a triangular matrix, xaxis = time, yaxis = lag
%       for more details, please refer to Figure 2 in the reference
%       "Paulus et al., Audio-based Music Structure Analysis, 2010"

function R = computeLagDistMatrix(SDM)

R = [];
col_sdm = size(SDM,1);
row_sdm = size(SDM,2);

for i=1:col_sdm
    for j=1:row_sdm
        if(i - j > 0)
            R(i, i - j) = SDM(i,j);
        end
    end
end

figure();


