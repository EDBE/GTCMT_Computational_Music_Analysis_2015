%% Loop through all test files
path = '/Users/chrislatina/Documents/MATLAB/ODB/audio/';
truth = '/Users/chrislatina/Documents/MATLAB/ODB/ground truth/';

audioFile = fullfile(path, '*.wav');
textFile = fullfile(truth, '*.txt');
d = dir(audioFile);
t = dir(textFile);
numFiles = numel(d);

precisions = zeros(numFiles,1);
recalls = zeros(numFiles,1);
f_measures = zeros(numFiles,1);

for k  = 1: numel(d)
   audioFilename = fullfile(path, d(k).name); 
   textFilename = fullfile(truth, t(k).name); 
   
   
   % Read in the audio file
    [x,fs] = audioread(audioFilename);
    windowSize = 1024;
    hopSize = 256;

    %x = test_generation(441,441,0.5,0.9, fs);
    nvt = mySpectralFlux(x, windowSize, hopSize);
    %nvt = myPeakEnv(x, windowSize, hopSize);
    %nvt = myWPD(x, windowSize, hopSize);

    onsetTimeInSec = myOnsetDetection(nvt, fs, windowSize, hopSize);
    delta = 50;
    annotation = readtable(textFilename,'Delimiter',' ','Format', '%f','ReadVariableNames',false, 'MultipleDelimsAsOne', true);
    timeData = table2array(annotation(:,1));

    [precision, recall, f_measure] = evaluateOnsets(onsetTimeInSec, timeData, delta);
    precisions(k) = precision;
    recalls(k) = recall;
    f_measures(k) = f_measure;
end

p = mean(precisions);
r = mean(recalls);
f = mean(f_measures);

%Spec: 
%Peak: f = 0.8730, p = 0.8439, r = 0.9660, lambda: 0.25, order: 7
%WPD: f = 0.7503, p = 0.6603, r = 0.9456, lambda: 0.25, order: 7
