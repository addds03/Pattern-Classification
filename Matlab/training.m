function [Model] = training (feats)
t = templateTree('MaxNumSplits',4);
Model = fitcensemble(feats(:,1:end-1), feats(:,end), 'Method','AdaboostM1', 'Cost', [0 1;17 0],'Learners',t, ...
     'OptimizeHyperparameters',{'NumLearningCycles','LearnRate'});
end

%'Cost', [0 1;17 0],