clear 
clc
%% Select Mode
mode=questdlg('Select a Mode', 'Selection', 'Train', 'Test','End');
switch mode 
    case 'Train'
        testing = false;
    case 'Test'
        testing = true;  
end
%%
if not(testing)
data = readtable ('csv_result-Descriptors_Training.csv');
labels = table2array(data(:,30));
just_Feat = table2array(data(:,2:29));
end
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
F_AND_L = Preprocess(F_AND_L, testing);
[F_AND_L, newPOS] = featureselection(F_AND_L);
