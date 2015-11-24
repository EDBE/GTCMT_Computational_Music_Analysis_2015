function [ rate, genres] = myNFold( genres, features, nFold, fold, K)
% Separate data into training and test sets based on nFold

filesInFolder = 100;
nSize = size(features,1);
nSize = nSize / nFold;

% RANDOM
% seed = randperm(size(features,1));
% rand_labels = genres(seed);
% randData = features(seed,:);

% DISTRIBUTED: Interleave vectors
F1 = features(1:filesInFolder,:); 
F2 = features(filesInFolder+1:2*filesInFolder,:);
F3 = features(2*filesInFolder+1:3*filesInFolder,:);
F4 = features(3*filesInFolder+1:4*filesInFolder,:);
F5 = features(4*filesInFolder+1:5*filesInFolder,:);
dist_features = reshape([F1';F2';F3';F4';F5'],10,[])';

G1 = genres(1:filesInFolder,:);
G2 = genres(filesInFolder+1:2*filesInFolder,:);
G3 = genres(2*filesInFolder+1:3*filesInFolder,:);
G4 = genres(3*filesInFolder+1:4*filesInFolder,:);
G5 = genres(4*filesInFolder+1:5*filesInFolder,:);

dist_labels = reshape([G1';G2';G3';G4';G5'],1,[])';

% Do Separation
for i = 1:nFold
    
    % RANDOM
%     s = (i-1)*nSize+1;
%     e = i*nSize;
%     test_feat = randData(s:e,:);
%     test_labels = rand_labels(s:e);
%     train_feat = randData;
%     genres = rand_labels;
%     train_feat(s:e,:) = [];
%     genres(s:e,:) = [];
    
    % DISTRIBUTED: Interleave vectors  
    s = (i-1)*nSize+1;
    e = i*nSize;
    test_feat = dist_features(s:e,:);
    test_labels(:,i) = dist_labels(s:e);
    train_feat = dist_features;
    genres = dist_labels;
    train_feat(s:e,:) = [];
    genres(s:e,:) = [];
    
    % Normalize using z-score
    test_feat = (test_feat - repmat(mean(train_feat),size(test_feat,1),1)) ./ repmat(std(train_feat),size(test_feat,1),1);
    train_feat = (train_feat - repmat(mean(train_feat),size(train_feat,1),1)) ./ repmat(std(train_feat),size(train_feat,1),1);

    % Run K-NN to calculate distance
    estimatedClasses(:,i) = myKnn(genres, train_feat(:,fold), test_feat(:,fold), K);
    rate((i-1)*nSize+1:i*nSize,1) = strcmp(estimatedClasses(:,i), test_labels(:,i));
end

% Generate the Confusion Matrix
[C,order] = confusionmat(test_labels(:),estimatedClasses(:));
figure(3);
imagesc(C);
title('Confusion Matrix');
colormap(flipud(gray));  % Grayscale
textStrings = num2str(C(:),'%0.2f');  % Generate strings for labels
textStrings = strtrim(cellstr(textStrings)); 
[x,y] = meshgrid(1:5);
hStrings = text(x(:),y(:),textStrings(:),... 
                'HorizontalAlignment','center');
midValue = mean(get(gca,'CLim')); 
textColors = repmat(C(:) > midValue,1,3);
set(hStrings,{'Color'},num2cell(textColors,2));

set(gca,'XTick',1:5,...                    
        'XTickLabel',{order{1}, order{2}, order{3}, order{4}, order{5}},...
        'YTick',1:5,...
        'YTickLabel',{order{1}, order{2}, order{3}, order{4}, order{5}},...
        'TickLength',[0 0]);

rate = mean(rate);

end

