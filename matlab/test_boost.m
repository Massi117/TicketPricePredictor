clear
loaddata

[alpha, DTCell] = train_boosted_dt(Xtr, ytr, 3);
%% test
ypred = test_boosted_dt(Xte, alpha, DTCell);

mse(ypred,yte)

