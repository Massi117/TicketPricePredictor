% Test the random forest

% Load the data
%clear
%loaddata

% Get ideal number of trees T through cross validation
T = 20:5:70;

% Record Errors
errors = zeros(numel(T),1);

% Grow the forest
idx = 1;
for i = T
    forest = trainRF(i, Xtr, ytr);

    yhat = predictRF(forest, Xval);

    % Compute accuracy
    errors(idx) = mse(yhat,yval);
    idx = idx+1;

end




