function DTCell = train_gradientboosted_dt(Xtr, ytr, n_trees, alpha, depth, max_depth, min_samples_leaf)
    % Initialize DT
    DTCell = cell(T,1);
    
    DTCell{1} = rtree(Xtr, ytr, depth, max_depth, min_samples_leaf);
    y_pred = tree_predict(DTCell{1}, Xtr);
    
    for i = 2:n_trees
        residuals = ytr - y_pred;
        
        tree = rtree(Xtr, residuals, depth, max_depth, min_samples_leaf);
        
        y_pred = y_pred + alpha * tree_predict(tree, Xtr); % add the predictions up with the results from training on residuals
        
        DTCell{i} = tree;
    end
end
