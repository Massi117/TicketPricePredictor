% Test the regression tree
clear
close all

% Load data
loaddata
Xtr = Xtr(1:10000,:);
ytr = ytr(1:10000);
Xtr2 = Xtr2(1:10000,:);

%% Make the tree
alpha = 0.1;

DTCell = train_gradientboosted_dt(Xtr, ytr, 5, alpha, 0, 50, 20);

ytr_pred = zeros(size(Xtr, 1), 1);
for i = 1:length(DTCell)
    ytr_pred = ytr_pred + alpha * tree_predict(DTCell{i}, Xtr);
end

tr_error = mse(ytr_pred, ytr);
fprintf('Training RMSE: %.2f\n', sqrt(tr_error));

%% Test DT
y_pred = zeros(size(Xval, 1), 1);
for i = 1:length(DTCell)
    y_pred = y_pred + alpha * tree_predict(DTCell{i}, Xval);
end

% Compute accuracy
error = mse(y_pred, yval);
fprintf('Test RMSE: %.2f\n', sqrt(error));

plot_rtree(DTCell{1}, Xtr.Properties.VariableNames);
