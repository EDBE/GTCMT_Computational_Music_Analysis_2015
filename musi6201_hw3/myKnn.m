function [estimatedClass] = myKnn(trainLabel, trainData, testData, K)
% k-Nearest Neighbor (Knn)

num_train = size(trainData,1);
num_test = size(testData,1);
distance = zeros(num_test, num_train);

for i=1:num_test
   for j=1:num_train
        distance(i,j) = sqrt(sum ((testData(i,:) - trainData(j,:)).^2));
    end
end

%Sort the distances
[B, I] = sort(distance,2,'ascend');

%Select the first K distances
genres = trainLabel(I(:,1:K));
k_dist = B(:,1:K);
all_labels = unique(trainLabel);
num_labels = size(all_labels,1);

% Take the majority with the smallest cumulative distance
for j = 1: size(I,1)
    counts = zeros(num_labels,K);
    sums = zeros(num_labels,1);
    for i = 1:num_labels
        counts(i,:) = strcmp(all_labels(i),genres(j,:));
        sums(i,:) = sum(counts(i,:).*k_dist(j,:));
    end
    
    num_matches = sum(counts,2);
    
    % find ind where num of matches is max
    maxes = (sum(counts,2) == max(sum(counts,2)));
    max_labels = maxes.*sums;
    
    %Take the min distance
    min_dist_inds = find(max_labels);
    if isempty(min_dist_inds)
        %estimatedClass(j,1) = genres(j,1);
        min_dist_inds = 1;
    end
    [min_dist, min_dist_ind] = min(max_labels(min_dist_inds));
    estimatedClass(j,1) = all_labels(min_dist_inds(min_dist_ind));
end

end