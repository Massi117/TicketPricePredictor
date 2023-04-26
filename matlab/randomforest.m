% Implements a random forest

% Load the data
clear;
loaddata;

%% Define dimensions
[m,d] = size(Xtr);
T = 25;                         % # of trees in random forest
mtest = size(Xval,1);
classes = varfun(@class,Xte,'OutputFormat','cell');
Xval2 = table2cell(Xval);

% Select a subsample with replacement (boostraping)
mt = ceil(m/50);               % # of samples used per tree
theta = randi(m,mt,T);

% # of featues used per tree
num_feat = d;       

% Build and train the random forrest
DTCell = cell(T,1);             % Initilize the forrests
predictions = zeros(mtest,T);   % Initilize predictions

for i = 1:T
    % Bootstraping and feature selection
    feat = 1:d;%randsample(d,num_feat);
    Xi = Xtr(theta(:,i),feat);
    yi = ytr(theta(:,i));
    
    weights = 1/numel(yi);
    DTCell{i} = rtree(Xi, yi, 0, 30, 5, weights);
    
    % Get predictions
    predictions(:,i) = tree_predict(DTCell{i}, Xval2(:,feat), classes(feat));
    disp(i)
end

% Find the mean for all the predictors
yhat = mean(predictions,2);

% Compute accuracy
error = mse(yhat, yval);
fprintf('RMSE: %.2f\n', sqrt(error));

