function newSet = featureTrim(feats, positions)
j=1;
y = feats(:,29);
feats = feats(:, 1:end-1);
% for i= 1:length(positions)
%     newSet(:,i)=feats(:,positions(i));
% end
% newSet = [newSet y];
feats = feats -mean(feats);
score = feats*positions;
newSet = [score y];
end