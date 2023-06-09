function DTCell = train_gradientboosted_dt(Xtr, ytr, n_trees, alpha, depth, max_depth, min_samples_leaf)
    % Initialize DT
    DTCell = cell(n_trees,1);
    residuals = mean(ytr) - ytr;
    weights = 1/numel(ytr);
    
    DTCell{1} = rtree(Xtr, residuals, depth, max_depth, min_samples_leaf, weights);
    y_pred = tree_predict(DTCell{1}, Xtr);
    
    for i = 2:n_trees
        residuals = ytr - y_pred;
        tree = rtree(Xtr, residuals, depth, max_depth, min_samples_leaf, weights);
        y_pred = y_pred + alpha * tree_predict(tree, Xtr);
        DTCell{i} = tree;
        weights = weights .* exp(-alpha * ytr .* tree_predict(tree, Xtr));
    end
end
