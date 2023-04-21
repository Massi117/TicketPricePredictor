function tree = rtree(X, y, depth, max_depth, min_samples_leaf)
    % X: input feature matrix, each row represents a sample, each column represents a feature
    % y: vector of labels for each sample in X
    % tree: structure representing the decision tree
    
    % calculate the total number of samples and features
    [m, d] = size(X);
    
    % return a leaf node if max depth or minimum # of samples is reached
    if numel(y) <= min_samples_leaf
        tree.value = mean(y);
        tree.is_leaf = true;
        return
    elseif depth >= max_depth
        tree.value = mean(y);
        tree.is_leaf = true;
        return
    end

    % Determine which rows are categorical
    iscat = [1 1 1 1 1 1 1 1 0 0];
    
    % find the best feature to split on using Gini impurity & MSE
    best_mse_reduction = -Inf;
    for i = 1:d
        % calculate the mse reduction of splitting on feature i
        values = unique(X(:, i));
        if iscat(i)
            mse_prev = mse(mean(y),y);
            for j = 1:numel(values)
                right_idx = X(:, i) >= values(j);
                left_idx = ~right_idx;
                if sum(left_idx) == 0 || sum(right_idx) == 0
                    continue
                end
                % Calculate mse reduction
                mse_left = mse(mean(y(left_idx)),y);
                mse_right = mse(mean(y(right_idx)),y);
                w_left = numel(y(left_idx))/numel(y);
                w_right = numel(y(right_idx))/numel(y);
                mse_reduction = mse_prev - (w_left*mse_left) - (w_right-mse_right);
    
    
                % update the best feature if this one is better
                if mse_reduction > best_mse_reduction
                    best_mse_reduction = mse_reduction;
                    best_feature = i;
                    split = values(j);
                end
            end
        else
            mse_prev = mse(mean(y),y);
            for j = 1:numel(values)
                right_idx = X(:, i) >= values(j);
                left_idx = ~right_idx;
                if sum(left_idx) == 0 || sum(right_idx) == 0
                    continue
                end
                % Calculate mse reduction
                mse_left = mse(mean(y(left_idx)),y);
                mse_right = mse(mean(y(right_idx)),y);
                w_left = numel(y(left_idx))/numel(y);
                w_right = numel(y(right_idx))/numel(y);
                mse_reduction = mse_prev - (w_left*mse_left) - (w_right-mse_right);
    
    
                % update the best feature if this one is better
                if mse_reduction > best_mse_reduction
                    best_mse_reduction = mse_reduction;
                    best_feature = i;
                    split = values(j);
                end
            end
        end
    end
    
    % create a node for the best feature
    tree.split = split;
    tree.col_index = best_feature;
    tree.mse_reduction = best_mse_reduction;
    tree.is_leaf = false;
    
    % split the data on the best feature
    left_idx = X(:, best_feature) < split;
    right_idx = X(:, best_feature) >= split;
        
    % recursively create a subtree for the split data
    tree.left = rtree(X(left_idx, :), y(left_idx), depth+1, max_depth, min_samples_leaf);
    tree.right = rtree(X(right_idx, :), y(right_idx), depth+1, max_depth, min_samples_leaf);
end

