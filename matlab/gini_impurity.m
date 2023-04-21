function gini = gini_impurity(y)
    % Calculate the Gini impurity for a vector of labels y
    m = length(y);
    if m == 0
        gini = Inf;
    else
        uv = unique(y);
        counts = histcounts(y,length(uv));
        probs = counts / m;
        gini = 1 - sum(probs .^ 2);
    end

end