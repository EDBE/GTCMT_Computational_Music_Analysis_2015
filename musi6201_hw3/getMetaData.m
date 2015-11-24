function [ features, genres ] = getMetaData(path, folders, filesInFolder, windowSize, hopSize)

%Construct feature matrix and genre vector
folder_size = size(folders,2);
features = zeros(folder_size * filesInFolder, 10);
genres = [];

% Open each file
for i = 1:size(folders,2);
    genre = folders{i};
    filePath = strcat(path, '/',genre,'/*.au');
    files = dir(filePath);
    ind = (i-1)*filesInFolder+1;
    for file = files'
        genres{ind} = genre;
        fullFilePath = strcat(path, '/',genre,'/',file.name);
        [y,Fs] = audioread(fullFilePath);
        %Block signal
        [blocked_x, numBlocks] = myBlockedInput(y, windowSize, hopSize);

        % Calculate ZCR (Time Domain)
        [zcr,ts] = myZCR(blocked_x, numBlocks, hopSize, Fs);
        
        % Windowed FFT of each block
        window = hamming(windowSize, 'periodic');
        window = repmat(window, 1, numBlocks);
        freq_blocked_x = fft(window .* blocked_x);
        mag_freq_blocked_x = abs(freq_blocked_x);
        
        % Extract features per block
        me  = zeros(numBlocks, 1);
        sc  = zeros(numBlocks, 1);
        scr = zeros(numBlocks, 1);
        for j = 1: numBlocks
            me (j) = myME(blocked_x(:,j));
            sc (j) = mySC (mag_freq_blocked_x(:,j), Fs);
            scr(j) = mySCR(mag_freq_blocked_x(:,j));
        end
        
        %Calculate Spectral Flux
        sf = mySF (mag_freq_blocked_x);

        %Calculate mean and std dev.
        features(ind,1) = mean(me);
        features(ind,2) = mean(sc);
        features(ind,3) = mean(scr);
        features(ind,4) = mean(sf);
        features(ind,5) = mean(zcr);
        features(ind,6) = std(me);
        features(ind,7) = std(sc);
        features(ind,8) = std(scr);
        features(ind,9) = std(sf);
        features(ind,10)= std(zcr);
        
%         features(ind,11) = mean(mfcc);
%         features(ind,12) = std(mfcc);
        
        ind = ind + 1;
    end
end

genres = genres';

end

