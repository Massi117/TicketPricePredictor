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
mte = ceil(0.2*m);
mtr = m-(2*mte);

% Create training data
Xtr = X(shuffle(1:mtr),:);
ytr = y(shuffle(1:mtr));

% Create testing data
Xte = X(shuffle(mtr+1:mtr+mte),:);
yte = y(shuffle(mtr+1:mtr+mte));

% Create validation data
Xval = X(shuffle(mtr+mte+1:m),:);
yval = y(shuffle(mtr+mte+1:m));

