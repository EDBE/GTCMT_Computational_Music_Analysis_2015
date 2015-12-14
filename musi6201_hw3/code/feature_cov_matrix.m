function [pair1, pair2, pair3, pair4, pair5] = feature_cov_matrix(init_features)

% normalize the feature
norm_features = (init_features - repmat(mean(init_features),size(init_features,1),1)) ./ repmat(std(init_features),size(init_features,1),1);

% pairing
pair1 = [norm_features(:, 2) norm_features(:, 3)];
pair2 = [norm_features(:, 4) norm_features(:, 5)];
pair3 = [norm_features(:, 1) norm_features(:, 6)];
pair4 = [norm_features(:, 10) norm_features(:, 8)];
pair5 = [norm_features(:, 7) norm_features(:, 9)];

% visualization
figure(1);

subplot(5,1,1);
c = linspace(1,10,length(pair1));
scatter(pair1(:,1), pair1(:,2), [], c, 'filled');
title('Subplot 1: SC mean and SCR mean');

subplot(5,1,2);
c = linspace(1,10,length(pair2));
scatter(pair2(:,1), pair2(:,2), [], c, 'filled');
title('Subplot 2: SF mean and ZCR mean');

subplot(5,1,3);
c = linspace(1,10,length(pair3));
scatter(pair3(:,1), pair3(:,2), [], c, 'filled');
title('Subplot 3: ME mean and ME std');

subplot(5,1,4);
c = linspace(1,10,length(pair4));
scatter(pair4(:,1), pair4(:,2), [], c, 'filled');
title('Subplot 4: ZCR std and SCR std');

subplot(5,1,5);
c = linspace(1,10,length(pair5));
scatter(pair5(:,1), pair5(:,2), [], c, 'filled');
title('Subplot 5: SC std and SF std');

% covariance matrix computation

cov1 = myCov(norm_features);

% covariance matrix visualization
figure(2);
imagesc(cov1);
colorbar
title('Covariance Matrix Visualization');