% Load the ticket data into matlab and seperate into training & testing

% Read the data table from Kaggle
T = readtable('ticket_data.csv');
T.Var1 = [];
%T. = table2cell(T);

% Formatting the data
T.airline = categorical(T.airline);
T.flight = [];
T.source_city = categorical(T.source_city);
T.departure_time = categorical(T.departure_time);
T.stops = categorical(T.stops);
T.arrival_time = categorical(T.arrival_time);
T.destination_city = categorical(T.destination_city);
T.class = categorical(T.class);

% Separate into the inputs and labels
y = T.price/82.04;
X = T;
X.price = [];

% Separate into training and testing data
[m,d] = size(X);
shuffle = randperm(m);
mte = ceil(0.35*m);
mtr = m-floor(0.4*m);

% Create test data
Xte = X(shuffle(1:mtr),:);
yte = y(shuffle(1:mtr));

% Create validation data
Xval = X(shuffle(mtr+1:mtr+mte),:);
yval = y(shuffle(mtr+1:mtr+mte));

% Create training data
Xtr = X(shuffle(mtr+mte+1:m),:);
ytr = y(shuffle(mtr+mte+1:m));

% Prepare Training Error Data
Xtr2 = table2cell(Xtr);

for i = 1:size(Xtr2,2)
    if isa(Xtr2{1,i}, 'categorical')
        for j = 1:size(Xtr2,1)
            Xtr2{j,i} = string(Xtr2{j,i});
        end
    end
end

% Prepare Validation Data
classes = varfun(@class,Xte,'OutputFormat','cell');
Xval = table2cell(Xval);

for i = 1:size(Xval,2)
    if isa(Xval{1,i}, 'categorical')
        for j = 1:size(Xval,1)
            Xval{j,i} = string(Xval{j,i});
        end
    end
end

% Prepare test Data
Xte = table2cell(Xte);

for i = 1:size(Xte,2)
    if isa(Xte{1,i}, 'categorical')
        for j = 1:size(Xte,1)
            Xte{j,i} = string(Xte{j,i});
        end
    end
end
