% Read in the audio file
fs = 44100;
windowSize = 1024;
hopSize = 512;

% Generated sine wave at 441 Hz and 882 Hz
t=(0:(fs-1))*(1/fs);
x = sin(2*pi*441*t);
y = sin(2*pi*882*t);
x = [x,y];
x = x';

[fACF, timeACF] = myPitchTrack_ACF(x, windowSize, hopSize, fs);

figure;
plot(timeACF,fACF);
ylabel('frequency (in Hz)');
xlabel('time (in Seconds)');
title('Pitch Tracking (Autocorrelation) of test signal');

% Create pitch signal
pitch(1:size(fACF,1)/2) = 441;
pitch(size(fACF,1)/2+1:size(fACF,1)) = 882;

error = fACF-pitch';

figure;
plot(timeACF,abs(error));
ylabel('frequency (in Hz)');
xlabel('time (in Seconds)');
title('Error in Pitch Tracking (Autocorrelation) of test signal');


