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

[fMaxSpec, timeMaxSpec] = myPitchTrack_MaxSpec(x, windowSize, hopSize, fs);

figure;
plot(timeMaxSpec,fMaxSpec);
ylabel('frequency (in Hz)');
xlabel('time (in Seconds)');
title('Pitch Tracking (Autocorrelation) of test signal');

% Create pitch signal
pitch(1:floor(size(fMaxSpec,1)/2)) = 441;
pitch(floor(size(fMaxSpec,1)/2)+1:size(fMaxSpec,1)) = 882;

error = fMaxSpec-pitch';

figure;
plot(timeMaxSpec,abs(error));
ylabel('frequency (in Hz)');
xlabel('time (in Seconds)');
title('Error in Pitch Tracking (Autocorrelation) of test signal');


