%% read in the audio file
[x_stereo, fs] = audioread('03-Sargon-Waiting For Silence.mp3');

% convert stereo to mono
x = mean(x_stereo, 2);

% compute the spectrogram with 4*fs as window size and fs as hopsize
hopScale = 4;
X = spectrogram(x, hamming(hopScale*fs), hopScale*fs - fs,fs*hopScale,fs);
X_mag = abs(X);

%% compute the pitch chroma feature
pc = FeatureSpectralPitchChroma(X_mag, fs);

%% compute the MFCC
mfcc = FeatureSpectralMfccs(X_mag, fs);

%% Self distance matrix computation
pc_SDM = computeSelfDistMat(pc');
mfcc_SDM = computeSelfDistMat(mfcc');
figure();
subplot(1,2,1); imagesc(pc_SDM);
title('Distance Matrix (Pitch Chroma)');
subplot(1,2,2); imagesc(mfcc_SDM);
title('Distance Matrix (MFCCs)');


%%
% Checkboard Kernel Audio Novelty Function
% play around with L = 2, 8, 16
L = 8;

nvt_pc = computeSdmNovelty(pc_SDM, L);
nvt_mfcc = computeSdmNovelty(mfcc_SDM, L);

%% Read annotation data and superimpose on novelty functions

data = readtable('03-Sargon-Waiting For Silence.csv','Delimiter',',','Format', '%f%s','ReadVariableNames',false, 'MultipleDelimsAsOne', false);
time = table2array(data(:,1));
part = table2array(data(:,2));

scale = hopScale - 1;

% Draw a vertical line for PC
figure();
plot(nvt_pc);
hold on;
line([time,time], [0 1]);
hold off;
str_pc = sprintf('Pitch Chroma Novelty Function, L = %i', L);
title(str_pc);

% Draw a vertical line for 
figure();
plot(nvt_mfcc);
hold on;
line([time,time], [0 1]);
hold off;
str_mfcc = sprintf('MFCC Novelty Function, L = %i', L);
title(str_mfcc);

%% Compute lag distance matrix
mfcc_R = computeLagDistMatrix(mfcc_SDM);
imagesc(mfcc_R);
title('Lag Distance Matrix: MFCC');

pc_r = computeLagDistMatrix(pc_SDM);
imagesc(pc_r);
title('Lag Distance Matrix: Pitch Chroma');


%% Create Binary Lag Distance Matrix with threshold
SDM_binary_pc = computeBinSdm(pc_r, mean(mean(pc_r))*1.10 );
colormap default;
imagesc(SDM_binary_pc);
title('Lag Distance Matrix of Binary SDM: Pitch Chroma');

SDM_binary_mfcc = computeBinSdm(mfcc_R, mean(mean(mfcc_R))*1.10);
colormap default;
imagesc(SDM_binary_mfcc);
title('Lag Distance Matrix of Binary SDM: MFCC');


%% Erode qnd dialate.
SDM_ed_pc = erodeDilate(SDM_binary_pc, 4);
SDM_ed_mfcc = erodeDilate(SDM_binary_mfcc, 4);

figure();
imagesc(SDM_ed_pc);
colormap gray;

figure();
imagesc(SDM_ed_mfcc);
colormap gray;