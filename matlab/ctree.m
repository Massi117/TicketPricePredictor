function tree = ctree(X, y, depth, max_depth)
    % X: input feature matrix, each row represents a sample, each column represents a feature
    % y: vector of labels for each sample in X
    % tree: structure representing the decision tree
    
    % calculate the total number of samples and features
    [m, d] = size(X);
    
    % if all samples belong to the same class, return a leaf node
    y_vals = unique(y);
    if length(y_vals) == 1
        tree.value = y(1);
        tree.is_leaf = true;
        return
    elseif depth == max_depth
        tree.value = mode(y);
        tree.is_leaf = true;
        return
    end
    
    % find the best feature to split on using Gini impurity
    best_gini = Inf;
    for i = 1:d
        % calculate the Gini impurity of splitting on feature i
        values = unique(X(:, i));
        for j = 1:length(values)
            left = y(X(:, i)<values(j));
            right = y(X(:, i)>=values(j));
            gini_left = gini_impurity(left);
            gini_right = gini_impurity(right);
            gini = (length(left) / m) * gini_left + (length(right) / m) * gini_right;
            % update the best feature if this one is better
            if gini < best_gini
                best_gini = gini;
                best_feature = i;
                split = values(j);
            end
        end
    end
    
    % create a node for the best feature
    tree.split = split;
    tree.col_index = best_feature;
    tree.gini_value = best_gini;
    tree.is_leaf = false;
    
    % split the data on the best feature
    left_idx = X(:, best_feature) < split;
    right_idx = X(:, best_feature) >= split;
        
    % recursively create a subtree for the split data
    tree.left = ctree(X(left_idx, :), y(left_idx), depth+1, max_depth);
    tree.right = ctree(X(right_idx, :), y(right_idx), depth+1, max_depth);
end
