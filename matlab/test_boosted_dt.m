function [ypred] = test_boosted_dt(Xte, alpha, DTCell)

    ypred = 0;
    for i = 1:length(alpha)
        ypred = ypred+(alpha(i)*tree_predict(DTCell{i},Xte));
    end
    ypred = sign(ypred);

end