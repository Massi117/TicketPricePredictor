function tree = rtree(X, y, depth, max_depth, min_samples_leaf, weights)
    % X: input feature matrix, each row represents a sample, each column represents a feature
    % y: vector of labels for each sample in X
    % tree: structure representing the decision tree
    
    % calculate the total number of samples and features
    [m, d] = size(X);

    % Define node size
    tree.size = m;

    % Define Node Probability
    prob = m*weights;
    tree.NodeProbability = prob;
    
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

    % find the tree mean
    node_mean = mean(y);
    tree.mean = node_mean;

    % find tree risk and error
    mse_prev = mse(node_mean,y);
    tree.error = mse_prev;
    risk = prob*mse_prev;
    tree.risk = risk;
    
    % find the best feature to split on using Gini impurity & MSE
    best_mse_reduction = -Inf;
    classes = varfun(@class,X,'OutputFormat','cell');
    for i = 1:d
        % Find unique values to split over
        values = unique(X.(i));

        % Determine if data is categorical
        iscat = strcmp(classes{i},'categorical');

        % Calculate the mse reduction of splitting on value j
        for j = 1:numel(values)
            % Split the data
            if iscat
                values = string(values);
                right_idx = string(X.(i)) == values(j);
                left_idx = ~right_idx;
            else
                right_idx = X.(i) >= values(j);
                left_idx = ~right_idx;
            end

            % Exit if data is not split at all
            if sum(left_idx) == 0 || sum(right_idx) == 0
                continue
            end

            % Calculate child node predictions
            right_pred = mean(y(right_idx));
            left_pred = mean(y(left_idx));
            
            % Calculate child node probabilities
            left_size = sum(left_idx);
            right_size = m-left_size;
            w_left = left_size*weights;
            w_right = (right_size)*weights;
            
            % Calculate MSE reduction
            mse_left = mse(left_pred,y);
            mse_right = mse(right_pred,y);
            mse_reduction = risk - (w_left*mse_left) - (w_right-mse_right);
    
            % update the best feature if this one is better
            if mse_reduction > best_mse_reduction
                best_mse_reduction = mse_reduction;
                best_feature = i;
                split = values(j);
            end
        end
    end

    % No better way to split the data
    if best_mse_reduction < 0
        tree.value = mean(y);
        tree.is_leaf = true;
        %disp('no better split')
        return
    end
    
    % create a node for the best feature
    tree.split = split;
    tree.col_index = best_feature;
    tree.CutPredictor = X.Properties.VariableNames{best_feature};
    tree.mse_reduction = best_mse_reduction;
    tree.is_leaf = false;
    
    % split the data on the best feature
    if strcmp(classes{best_feature},'categorical')
        right_idx = X.(best_feature) == split;
        left_idx = ~right_idx;
    else
        right_idx = X.(best_feature) >= split;
        left_idx = ~right_idx;
    end
        
    % recursively create a subtree for the split data
    tree.left = rtree(X(left_idx, :), y(left_idx), depth+1, max_depth, min_samples_leaf, weights);
    tree.right = rtree(X(right_idx, :), y(right_idx), depth+1, max_depth, min_samples_leaf, weights);
end

