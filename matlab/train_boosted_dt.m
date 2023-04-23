function [alpha, DTCell] = train_boosted_dt(Xtr, ytr, T)
    
    % Get dimensions
    [m d] = size(Xtr);

    % Initialize distribution
    D = ones(m,1)/m;

    % Initialize Errors
    alpha = zeros(T,1);

    % Initialize DT
    DTCell = cell(T,1);

    for i = 1:T
        % Run the weak learner
        DTCell{i} = rtree(Xtr,ytr,0,5,5);
        
        % Find the 0/1 loss
        yhat = tree_predict(DTCell{i},Xtr);
        zerooneloss = ytr~=yhat;
        
        % Find the weight of this classifier
        epsilon = sum(D.*zerooneloss);
        alpha(i) = log((1/epsilon)-1)/2;

        % Calculate the new distribution
        D = D.*exp(-alpha(i)*ytr.*yhat);
        D = D/sum(D);

    end

end