function [ final_rate ] = evaluateResults()
% Read in all genres into a data vector.
% Only use classical, jazz, metal, hiphop, and country genres
folders = {'classical','jazz','metal','hiphop','country'};

% Extract features for each file
windowSize = 2048;
hopSize = 1024;
filesInFolder = 100;
path = '../genres';

K = 3;
nFolds = 10;
numFeatures = 10;

% NOTE: We've included our extracted features for speed. You can uncomment and rerun
% getMetaData if you please.

% [init_features, init_genres] = getMetaData(path, folders, filesInFolder, windowSize, hopSize);
load 'init_features.mat';
load 'init_genres.mat';


% NFold for each individual feature at K = 3;
for i=1:10
    [rate(i), actualLabels] = myNFold(init_genres, init_features, nFolds, i, K);
end

% A plot of the output of the rate generated above.
% rate = [0.404,0.322,0.356,0.356,0.320,0.374,0.300,0.362,0.406,0.396]
bar(rate);
title('K-NN (K=3) classification with 10-fold cross validation for each feature');
Labels = {'Mean ME','Mean SC', 'Mean SCR', 'Mean SF', 'Mean ZCR', 'Std ME', 'Std SC', 'Std SCR', 'Std SF', 'Std ZCR'};
set(gca, 'XTick', 1:10, 'XTickLabel', Labels);

% ------

% Calculated Recursive Foward Selection at K = 7. Step rate is printed at
% each level.
% [f_sel, rate] = forwardSelection( init_genres, init_features, 10, 10, [], 0, 7);
% Features: f_sel = [9,8,3,4,1]
stepRate = [0.4520, 0.5940,0.6300, 0.6580, 0.6720];
bar(stepRate);
title('K-NN (K=7) Forward Selection Improvement');
Labels = {'Std SF','+ Std SCR', '+ Mean SCR', '+ Mean SF', '+ Mean ME'};
set(gca, 'XTick', 1:10, 'XTickLabel', Labels);

% ------

% For K = [1, 3, 7], find the best feature set, compute the classification performance, and generate the confusion matrix. 
% Discuss the resulting confusion matrix, what genres are typically confused with each other? 
% How does K affect the classification results?

% Run each of these individually. The confusion matrix plot is inside 
K = 1;
[f_sel, rate] = forwardSelection( init_genres, init_features, numFeatures, nFolds, [], 0, K);

% ------
K = 3;
[f_sel, rate] = forwardSelection( init_genres, init_features, numFeatures, nFolds, [], 0, K);

% ------
K = 7;
[f_sel, rate] = forwardSelection( init_genres, init_features, numFeatures, nFolds, [], 0, K);


end

