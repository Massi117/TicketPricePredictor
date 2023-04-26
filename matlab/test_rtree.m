% Test the regression tree
clear
close all

% Load data
loaddata

%% Compare with best
TREE = fitrtree(Xtr,ytr,'MaxNumSplits',30,'MinLeafSize',5,'Prune','off');

%% Make the tree
weights = 1/numel(ytr);
tree = rtree(Xtr, ytr, 0, 30, 5, weights);

%% Make predictions
yhat = predict(TREE, Xte);
classes = varfun(@class,Xte,'OutputFormat','cell');
Xte2 = table2cell(Xte);
y_pred = tree_predict(tree, Xte2,classes);

% Compute accuracy
error = mse(y_pred, yte);
ERROR = mse(yhat, yte);
fprintf('RMSE: %.2f\n', sqrt(error));
fprintf('RMSE of best: %.2f\n', sqrt(ERROR));

