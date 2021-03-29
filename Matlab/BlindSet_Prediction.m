clear
clc

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

F_AND_L = Preprocess(F_AND_L);
F_AND_L = balance_class(F_AND_L);
%% read in data
BlindSet = readtable ('Blind_Test_features.csv');
BlindSet = table2array(BlindSet);
dummyLabels = zeros(length(BlindSet), 1);
BlindSet = [BlindSet dummyLabels];
[BlindSet] = Preprocess(BlindSet);
[F_AND_L, BlindSet] = featureselection(F_AND_L, BlindSet);
BlindSet = BlindSet(:,1:end-1);

Model.ScoreTransform = 'doublelogit';
[~,scores] = predict(Model, BlindSet);
scores = scores(:,2);
writematrix(scores,'Group6_Scores.txt')


