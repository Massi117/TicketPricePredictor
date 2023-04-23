% Implements a random forest

% Load the data
clear;
loaddata;

%% Define dimensions
[m,d] = size(Xtr);
T = 10;                         % # of trees in random forest
mtest = size(Xte,1);

% Select a subsample with replacement (boostraping)
mt = ceil(m/1000);               % # of samples used per tree
theta = randi(m,mt,T);

% Feature selection
num_feat = ceil(sqrt(d));       % # of featues used per tree
feat = randi(d,num_feat,T);

% Build and train the random forrest
DTCell = cell(T,1);             % Initilize the forrest
predictions = zeros(mtest,T);   % Initilize predictions

for i = 1:T
    % Bootstraping and feature selection
    Xi = Xtr(theta(:,i),feat(:,i));
    yi = ytr(theta(:,i));

    DTCell{i} = rtree(Xi, yi, 0, 10, 10);
    
    % Get predictions
    predictions(:,i) = tree_predict(DTCell{i}, Xte(:,feat(:,i)));
    disp(i)
end

% Find the mean for all the predictors
yhat = mean(predictions,2);

% Compute accuracy
error = mse(yhat, yte);
fprintf('Error: %.2f\n', error);

