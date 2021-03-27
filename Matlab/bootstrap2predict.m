function [UB,LB] = bootstrap2predict(V_set, Model)
%% Seperate Features and labels
feats = V_set(:,1:end-1);
labels = V_set(:,end);


RecallR = 0.5;

%% Count and seperate the positives and negatives 
CP = 1;
CN = 1;
for i= 1:length(feats)
    if labels(i,:) ==1 
        Pos(CP,:) = feats(i,:);
        CP = CP +1;
    elseif labels(i,:) ==0
        Neg(CN,:) = feats(i,:);
        CN = CN +1;
    end
end 
CP = CP-1;
CN = CN -1;

%% Determine the random sampling indices of the positives and negatives seperately to ensure the same class imbalance
idxP = randi(CP, CP, 1000);
idxN = randi(CN, CN, 1000);

%% Populate the precision distribution using previously aquired random sampling indicies
for k = 1:1000
    clear bootstrapP;
    clear bootstrapN;
    for i = 1: CP
        bootstrapP(i,:) = Pos(idxP(i,k),:);
    end
    for i = 1: CN
        bootstrapN(i,:) = Neg(idxN(i,k),:);
    end
    bootstrapP(:,end+1) = 1;
    bootstrapN(:,end+1) = 0;
    bootstrap = [bootstrapP(:,1:end-1);bootstrapN(:,1:end-1)];
    bootlabels = [bootstrapP(:,end);bootstrapN(:,end)];
    
    [~,scores] = predict(Model, bootstrap);
    [X,Y] = perfcurve(bootlabels, scores(:,2), 1, 'XCrit', 'prec');
    where = find(round(Y, 1) == RecallR);
    for j = 1:length(where)
        P(j) = X(where(j));
    end
    prec(k) = max(P);
    
end

%% Determine the Upper and Lower Bounds of the 95% CI for the discovered precision distribution
distribution = sort(prec);
LB = distribution(1000*0.025);
UB = distribution(1000*0.975);
end