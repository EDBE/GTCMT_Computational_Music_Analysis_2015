% Read in the audio file
[x,fs] = audioread('../trainData/63-M2_AMairena.wav');
windowSize = 1024;
hopSize = 512;

[fACF, timeACF] = myPitchTrack_ACF(x, windowSize, hopSize, fs);
[fMaxSpec, timeMaxSpec] = myPitchTrack_MaxSpec(x, windowSize, hopSize, fs);

% Part 3
data = readtable('../trainData/63-M2_AMairena.f0.Corrected.txt','Delimiter',' ','Format', '%f%f%f%f','ReadVariableNames',false, 'MultipleDelimsAsOne', true);
tempData = table2array(data(:,3));
timeData = table2array(data(:,1));


%Pad to make sure they are the same length
fACF     = [fACF;0];
fMaxSpec = [fMaxSpec;0];

rmsACF = myEvaluation(fACF,tempData);
rmsMaxSpec = myEvaluation(fMaxSpec,tempData);

figure;
%plot(fACF);
plot (timeData, fACF, 'r', timeData, tempData, 'b');
ylabel('frequency (in Hz)');
xlabel('time (in Seconds)');
title('Output of Pitch Tracking (Autocorrelation)');



figure;
plot(fMaxSpec);
ylabel('frequency (in Hz)');
xlabel('time (in Seconds)');
title('Output of Pitch Tracking (Max Spectral)');
