function s= Preprocess(feats, testing)
[~, columns] = size(feats);
not_norm = false;
Skew = skewness(feats(:,1:28));
mu = mean(feats(:,1:28));
stD = std(feats(:,1:28));

%% Normalize
feats = feats + abs(min(feats))+1;
for i = 1:columns-1
    if max(abs(Skew))>1
        feats(:,i) = boxcox(feats(:,i));
    end
    feats(:,1) = feats(:,1) /max(feats(:,1));
end
%% Are Features Normally Distributed

for i = 1:columns-1
    norm = kstest(feats(:,i));
    if norm < 1
        not_norm = true;
    end
end

%% Find missing Data
if not(testing) % remove missing data if training
    [rowN, ~] =find(isnan(feats));
    for i = 1:length(rowN)
        feats(rowN(i,1),:) = [];
    end
end
%% Remove Outliers
if not_norm 
    feats = rmoutliers(feats, 'quartiles');
else 
    feats = rmoutliers(feats, 'mean');
end

s=feats;
