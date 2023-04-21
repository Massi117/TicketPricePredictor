function error = mse(yhat,y)
    % This function returns the mean squared error of a prediction compared
    % to its labels.
    error = mean((yhat-y).^2);
end