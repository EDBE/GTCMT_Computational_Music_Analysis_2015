% Read in the audio file
[x,fs] = audioread('../trainData/63-M2_AMairena.wav');
windowSize = 1024;
hopSize = 512;

[fMod, timeMaxSpec, power] = myPitchTrack_Mod(x, windowSize, hopSize, fs);

% Part 3
data = readtable('../trainData/63-M2_AMairena.f0.Corrected.txt','Delimiter',' ','Format', '%f%f%f%f','ReadVariableNames',false, 'MultipleDelimsAsOne', true);
tempData = table2array(data(:,3));
timeData = table2array(data(:,1));

%Pad to make sure they are the same length
fMod = fMod';
fMod = [fMod;0];

power = power';
power = [power;0];

rmsMod = myEvaluation(fMod,tempData);
dataLength = size(tempData);

figure;
plot (timeData, fMod, 'r', timeData, tempData, 'b', timeData, power, 'g');
ylabel('frequency (in Hz)');
xlabel('time (in Seconds)');
title('Output of Pitch Tracking (Modified) with power');
