function s= Preprocess(feats, testing)
[~, columns] = size(feats);
not_norm = false;
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
    if norm < 1
        not_norm = true;
    end
end

% %% Find missing Data
% if not(testing) % remove missing data if training
%     [rowN, ~] =find(isnan(feats));
%     for i = 1:length(rowN)
%         feats(rowN(i,1),:) = [];
%     end
% end
%% Remove Outliers
labels = feats(:,29);
% if not_norm 
%     [feats TF]= rmoutliers(feats(:,1:28), 'quartiles');
% else 
    [feats TF] = rmoutliers(feats(:,1:28), 'mean');
% end
count = 1;
for j = 1:length(TF)
    if TF(j,1) == 0 
        feats(count,29) = labels(j,1);
        count = count+1;
    end
end

s=feats;
