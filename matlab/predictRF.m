function yhat = predictRF(forest, X)

    T = numel(forest);
    mtest = size(X,1);
    predictions = zeros(mtest,T);   % Initilize predictions
    
    for i = 1:T
        % Get predictions
        predictions(:,i) = tree_predict(forest{i}, X);
        disp("test")
    end

    % Find the mean for all the predictors
    yhat = mean(predictions,2);

end