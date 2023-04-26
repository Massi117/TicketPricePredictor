function y_pred = tree_predict(tree, X, classes)
% Predict the class labels of the test data using the decision tree

% Inputs:
%   - tree: the decision tree model
%   - X_test: the test data (n_test x n_features)

% Output:
%   - y_pred: the predicted class labels (n_test x 1)

m = size(X, 1);
y_pred = zeros(m, 1);

for i = 1:m
    node = tree;
    while ~node.is_leaf
        if strcmp(classes{node.col_index},'categorical')
            if X{i,node.col_index} ~= node.split
                node = node.left;
            else
                node = node.right;
            end
        else
            if X{i,node.col_index} < node.split
                node = node.left;
            else
                node = node.right;
            end
        end
    end
    y_pred(i) = node.value;
end

end
