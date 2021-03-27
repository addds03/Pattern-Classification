function bal_feats = balance_class(feats)
%% Combat Class Imbalance

%Separate Classes 
CP = 1;
CN = 1;
for i= 1:length(feats)
    if feats(i,29) ==1 
        Pos(CP,:) = feats(i,:);
        CP = CP +1;
    elseif feats(i,29) ==0
        Neg(CN,:) = feats(i,:);
        CN = CN +1;
    end
end 
CP = CP-1;
CN = CN -1;

% Random OverSampling
for i = 1:(CN-CP)
    rnd = randi(CP);
    Pos(CP+i,:) = Pos(rnd,:);
end

bal_feats = [Pos;Neg];

end