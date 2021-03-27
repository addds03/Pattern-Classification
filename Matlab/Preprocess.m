function s= Preprocess(feats)
[~, columns] = size(feats);
Skew = skewness(feats(:,1:28));
mu = mean(feats(:,1:28));
stD = std(feats(:,1:28));

%% Normalize
feats(:,1:28) = feats(:,1:28) + abs(min(feats(:,1:28)))+1;
for i = 1:columns-1
    if max(abs(Skew))>1
        feats(:,i) = boxcox(feats(:,i));
    end
    feats(:,i) = feats(:,i) /max(feats(:,i));
end
%% Are Features Normally Distributed

for i = 1:columns-1
    norm = kstest(feats(:,i));
end

%% Remove Outliers
labels = feats(:,29);

[feats TF] = rmoutliers(feats(:,1:28), 'mean');

count = 1;
for j = 1:length(TF)
    if TF(j,1) == 0 
        feats(count,29) = labels(j,1);
        count = count+1;
    end
end

s=feats;
