function forest = trainRF(T, X, y)

    % Define dimensions
    [m,d] = size(X);
    
    % Select a subsample with replacement (boostraping)
    mt = ceil(m*0.05);               % # of samples used per tree
    theta = randi(m,mt,T);
    
    % # of featues used per tree
    num_feat = d;       
    
    % Build and train the random forrest
    forest = cell(T,1);             % Initilize the forrests
    
    for i = 1:T
        % Bootstraping and feature selection
        %feat = 1:d;%randsample(d,num_feat);
        Xi = X(theta(:,i),:);
        yi = y(theta(:,i));
        
        weights = 1/mt;
        forest{i} = rtree(Xi, yi, 0, 50, 5, weights);
        
        disp(i)
    end
    



end