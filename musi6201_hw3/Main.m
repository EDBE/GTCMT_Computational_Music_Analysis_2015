% Read in all genres into a data vector.
% Only use classical, jazz, metal, hiphop, and country genres
folders = {'classical','jazz','metal','hiphop','country'};

% Extract features for each file
windowSize = 2048;
hopSize = 1024;
filesInFolder = 100;
path = '../genres';
K = 3;

% NOTE: We've included our extracted features for speed. You can uncomment and rerun
% getMetaData if you please.

% [init_features, init_genres] = getMetaData(path, folders, filesInFolder, windowSize, hopSize);
load 'init_features.mat';
load 'init_genres.mat';


% visualize the feature space of 5 pairs: [SC mean, SCR mean], [SF mean, ZCR mean], 
% [ME mean, ME std], [ZCR std, SCR std], [SC std, SF std]
% Then, compute and visulize the feature covariance matrix

feature_cov_matrix(init_features);


% Normalize metaData -- this doesn't make a difference since we do it later
% norm_features = (init_features - repmat(mean(init_features),size(init_features,1),1)) ./ repmat(std(init_features),size(init_features,1),1);

% Do N-Fold
[rate, actualLabels] = myNFold(init_genres, init_features, 10, 1:10, K);

% Implement your Sequential Forward Selection based on the performance of 10-fold cross validation. Plot your classification performance depending on the number of features selected.
%[f_sel, rate] = forwardSelection( init_genres, init_features, 10, 10, [], 0, K);
