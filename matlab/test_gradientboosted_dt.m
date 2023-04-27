function y_pred = test_gradientboosted_dt(DTCell, Xtest, alpha)

    % Make predictions by summing the predictions of all the trees in the model
    y_pred = zeros(size(Xtest, 1), 1);
    for i = 1:length(DTCell)
        y_pred = y_pred + alpha * tree_predict(DTCell{i}, Xtest);
    end
end
