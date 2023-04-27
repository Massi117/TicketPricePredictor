% Test the regression tree
clear
close all

% Load data
loaddata
Xtr = Xtr(1:10000,:);
ytr = ytr(1:10000);
Xtr2 = Xtr2(1:10000,:);

%% Make the tree
weights = 1/numel(ytr);
tree = rtree(Xtr, ytr, 0, 50, 1, weights);

% Get training error
ytr_pred = tree_predict(tree,Xtr2);
tr_error = mse(ytr_pred, ytr);
fprintf('Training RMSE: %.2f\n', sqrt(tr_error));

%% Test DT
y_pred = tree_predict(tree,Xval);

% Compute accuracy
error = mse(y_pred, yval);
fprintf('Test RMSE: %.2f\n', sqrt(error));

plot_rtree(tree, Xtr.Properties.VariableNames);

