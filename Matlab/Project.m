clear 
clc
%% read in data
Tdata = readtable ('csv_result-Descriptors_Training.csv');
Vdata = readtable ('csv_result-Descriptors_Calibration.csv');

%% Convert data to Arrays
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

Vlabels = table2array(Vdata(:,30));
Vjust_Feat = table2array(Vdata(:,2:29));
for i=1:length(Vlabels)
    if strcmp(Vlabels(i,1),'P')
        VLabel(i) =1;
    else 
        VLabel(i) = 0;
    end 
end
V_set = [Vjust_Feat transpose(VLabel)];

clear('just_Feats');
clear ('labels');
clear('Vjust_Feats');
clear ('Vlabels');

%% Balance Classes and Preprocess

F_AND_L = Preprocess(F_AND_L,0);
F_AND_L = balance_class(F_AND_L);
V_set = Preprocess(V_set,1);

[F_AND_L, newPOS] = featureselection(F_AND_L);
V_set = featureTrim(V_set, newPOS);

Model = training(F_AND_L);

Class_labels = predict(Model, V_set(:, 1:end-1));

pre = evaluate(V_set(:,end), Class_labels);


