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

F_AND_L = Preprocess(F_AND_L);
F_AND_L = balance_class(F_AND_L);
V_set = Preprocess(V_set);

%% Select Features
[F_AND_L, V_set] = featureselection(F_AND_L, V_set);

%% Train Model
Model = training(F_AND_L);

%% Predict and Evaluate Model
[Class_labels,scores] = predict(Model, V_set(:, 1:end-1));

[pre, confusion] = evaluate(V_set(:,end), Class_labels);

[X,Y,T] = perfcurve(V_set(:,end), scores(:,2), 1, 'XCrit', 'prec');
figure;
plot(Y,X);
hold on 
xlabel('Recall');
ylabel('Precision');
title('Precision-Recall Curve of Gradient Boosted Tree Model on Calibration Data');
grid on
hold off

[UB,LB] = bootstrap2predict(V_set, Model);
