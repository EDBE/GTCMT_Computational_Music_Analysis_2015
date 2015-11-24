% compute self-distance matrix
% input:
%   featureMatrix: numFeatures by numSamples float matrix, feature matrix
% output:
%   SDM: numSamples by numSamples float matrix, self-distance matrix

function SDM = computeSelfDistMat(featureMatrix)

% row = size(featureMatrix, 1);
% col = size(featureMatrix, 2);
% SDM = zeros(row, col);
% inner_product = featureMatrix' * featureMatrix;
% SDM = bsxfun(@plus, diag(inner_product), diag(inner_product)') - 2*inner_product;

m = size(featureMatrix,1);
n = m;
SDM = sqrt(sum(abs( repmat(permute(featureMatrix, [1 3 2]), [1 n 1]) ...
- repmat(permute(featureMatrix, [3 1 2]), [m 1 1]) ).^2, 3));
        