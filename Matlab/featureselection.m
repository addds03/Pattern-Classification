function [selected_feats, position]= featureselection(feats)
% seperate features and labels
y = feats(:,29);
feats= feats(:,1:28);

%% determine the spearmans correlation between each feature and the other features (with no duplicate pairs)
% cnt = 1;
% for i= 1:28-1
%     for j=i+1:28
%         [rho,pval] = corr(feats(:,i), feats(:,j),'Type', 'Spearman');
%         % if correlation is atleast fair (medical definition) and
%         % statistically significant add to correlation directory 
%         if abs(rho)>=.8 && pval<= 0.05
%             correlation(cnt,:) = [i j];
%             cnt = cnt+1;
%         end
%     end
% end
% 
% %% Determine Features most correlated to outcomes using Chi2 test 
% [~, scores] = fscchi2(feats,y);
% cnt = 1;
% 
% %% Select Features
% for i = 1:28
%     % if feature is not correlated to any other feature and reached 
%     % statistical significance on the chi2 test select
%     if not(ismember(i, correlation)) && scores(i) > -log10(0.05)
%         selected_feats(:,cnt) = feats(:,i);
%         position(cnt) = i;
%         cnt= cnt+1;
%     % if feature is correlated to any other feature and scores highest of those features on the chi2 test include    
%     elseif ismember(i, correlation(:,1))
%         where = find(correlation(:,1) ==i);
%         if length(where) > 1
%             for j = 1:length (where)
%                 [~, ind(j)]=max([scores(correlation(where(j,1),1)),scores(correlation(where(j,1),2))]);
%                 
%                 if ind(j) ==2
%                     %if feature does not score highest remove correlated feature in
%                     %column 2 so it may be included in the selected
%                     %features
%                     correlation(where(j),2) = 0;
%                 end
%                 
%             end
%             ind = max (ind);
%         else
%             [~, ind]=max([scores(correlation(where,1)),scores(correlation(where,2))]);
%             if ind ==2
%                 correlation(where,2) = 0;
%             end
%         end
%         
%         if ind==1
%             selected_feats(:,cnt) = feats(:,i);
%             position(cnt) = i;
%             cnt= cnt+1;
%         end
%     end
%     
% end

% selected_feats = [selected_feats y];

[coeff, score, latent] = pca(feats);
selected_feats = [score y];
position = coeff;
%% Ignore the fact that this is basically just less good mRMR ... 
% I only realized late last night and will continue tune it I don't want to
% use straight mRMR because it uses Pearsons correlations which will work
% less good based on the skew of our data even after boxcox 
end