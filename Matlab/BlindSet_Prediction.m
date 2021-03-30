clear
clc
%% Load in Data Training Data Files and convert to arrays
load('Model_18.mat');
Tdata = readtable ('csv_result-Descriptors_Training.csv');
labels = table2array(Tdata(:,30));
just_Feat = table2array(Tdata(:,2:29));

for i=1:length(labels)
    if strcmp(labels(i,1),'P')
        Label(i) =1;
    else 
        Label(i) = 0;
    end 
end
F_AND_L = [just_Feat transpose(Label)];
clear('just_Feats');
clear ('labels');
%% preprocess Training data
F_AND_L = Preprocess(F_AND_L,0);
F_AND_L = balance_class(F_AND_L);
%% Read in Blind Data Set and convert to array
BlindSet = readtable ('Blind_Test_features.csv');
BlindSet = table2array(BlindSet);
dummyLabels = zeros(length(BlindSet), 1);
BlindSet = [BlindSet dummyLabels];

%% Preprocess Blind Data and apply transformation to PCA space
[BlindSet] = Preprocess(BlindSet,1);
[F_AND_L, BlindSet] = featureselection(F_AND_L, BlindSet);
% Remove dummy Labels
BlindSet = BlindSet(:,1:end-1);

%% Determine Prediction Scores
Model.ScoreTransform = 'doublelogit';
[~,scores] = predict(Model, BlindSet);
scores = scores(:,2);

%% Print Scores to a txt File
writematrix(scores,'Group6_Scores.txt', 'Delimiter', ',')


