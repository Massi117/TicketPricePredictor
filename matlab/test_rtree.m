% Test the regression tree
clear
close all

% Load data
loaddata

% Ben's Data
%Xtr = readmatrix('Xtrain.csv');
%ytr = readmatrix('ytrain.csv');
%Xte = readmatrix('Xtest.csv');
%yte = readmatrix('ytest.csv');


%% Compare with best
TREE = fitrtree(Xtr,ytr,'MaxNumSplits',30,'MinLeafSize',5);

%% Make the tree
tree = rtree(Xtr, ytr, 0, 30, 5);

%% Make predictions
y_pred = tree_predict(tree, Xte);
yhat = predict(TREE, Xte);

% Compute accuracy
error = mse(y_pred, yte);
ERROR = mse(yhat, yte);
fprintf('Error: %.2f\n', error);
fprintf('Error of best: %.2f\n', ERROR);

