function [pre, C] = evaluate(real_labels, class_labels)
TP = 0;
TN= 0;
FP= 0;
FN = 0;

%% Determine number of true negatives, true positives, false negatives and false positives
for i = 1:length(real_labels)
    if class_labels(i,1) == 1 && real_labels(i,1) == class_labels(i,1)
        TP = TP+1;
    elseif class_labels(i,1) == 0 && real_labels(i,1) == class_labels(i,1)
        TN = TN+1;
    elseif class_labels(i,1) == 0 && real_labels(i,1) ~= class_labels(i,1)
        FN= FN +1;
    elseif class_labels(i,1) == 1 && real_labels(i,1) ~= class_labels(i,1)
        FP = FP+1;
    end
end
%% Calculate Precision and Recall
recall = TP/(TP+FN);
pre = TP/(TP+FP);

disp('Recall');
disp(recall);

%% Display confusion matrix
figure
C= confusionchart(real_labels, class_labels);
end