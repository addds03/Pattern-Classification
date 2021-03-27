function [selected_feats, V_set]= featureselection(feats, test_set)
%% seperate features and labels
y = feats(:,29);
feats= feats(:,1:28);

y_test = test_set(:,29);
test_feats = test_set(:,1:28);

%% Run PCA and Select # of components which cover 95% of the Varience
[coeff, score, ~, ~, expl,mu] = pca(feats);
idx = find(cumsum(expl)>95,1);
feats = score(:, 1:idx);

selected_feats = [feats y];

%% Convert Validation Set into the same coordinate System
test_feats = (test_feats -mu)*coeff(:, 1:idx);
V_set = [test_feats y_test];

end