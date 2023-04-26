% Test the classification tree
clear
close all

load fisheriris.mat

% Shuffle the data to create training and testing data
[m,d] = size(meas);
shuffle = randperm(m);
mte = ceil(0.2*m);
mtr = m-mte;

% Create training data
Xtr = zeros(mtr,d);
ytr = cell(mtr,1);
for i = 1:mtr
    Xtr(i,:) = meas(shuffle(i),:);
    ytr{i} = species{shuffle(i)};
end

% Create testing data
Xte = zeros(mte,d);
yte = cell(mte,1);
for i = 1:mte
    Xte(i,:) = meas(shuffle(i+mtr),:);
    yte{i} = species{shuffle(i+mtr)};
end

num = grp2idx([yte; ytr]);
yte = num(1:mte);
ytr = num(1+mte:m);

%% Compare with best
TREE = fitctree(Xtr,ytr);

%% Make the tree
tree = ctree(Xtr, ytr, 0, 30);

%% Make predictions
y_pred = predict(tree, Xte);
yhat = predict(TREE, Xte);

% Compute accuracy
accuracy = sum(y_pred == yte) / numel(yte);
ACC = sum(yhat == yte) / numel(yte);
fprintf('Accuracy: %.2f%%\n', accuracy * 100);
fprintf('Accuracy of best: %.2f%%\n', ACC * 100);
