path = 'H:\My Drive\EC503 Learning From Data\project\archive\';
datasets = table;
datasets.business = 'business.csv';
datasets.Clean = 'Clean_Dataset.csv';
datasets.economy = 'economy.csv';

t = readtable([path datasets.economy]);
time = string(t.time_taken);

% 1-hot
airline = string(unique(t.airline))';
airline_features = double(t.airline == airline);

% 1-hot
ch_code = string(unique(t.ch_code))';
ch_code_features = double(t.ch_code == ch_code);

% numeric
dates_num = datenum(string(t.date), 'dd-mm-yy');
dates_num = dates_num - min(dates_num);

% 1-hot
stops = string(unique(t.stop))';
stop_features = double(t.stop == stops);

% 1-hot
to = string(unique(t.to))';
to_features = double(t.to == to);

% 1-hot
from = string(unique(t.from))';
from_features = double(t.from == from);

% numeric
price_feature = str2double(string(t.price));

% numeric
time_taken_num = 60 * str2double(extractBefore(time, 'h')) + ...
    str2double(extractBetween(time, ' ', 'm'));

% numeric
arr_time = string(t.arr_time);
arr_time_num = 60 * str2double(extractBefore(arr_time, ":")) + str2double(extractAfter(arr_time, ":"));

% numeric
dep_time = string(t.dep_time);
dep_time_num = 60 * str2double(extractBefore(dep_time, ":")) + str2double(extractAfter(dep_time, ":"));

num_code = unique(t.num_code)';
num_code_features = t.num_code == num_code;

y = price_feature;

X = [airline_features to_features from_features time_taken_num arr_time_num ...
    dep_time_num dates_num ch_code_features stop_features num_code_features];


writematrix(X, 'X.csv');
writematrix(y, 'y.csv');

% file = 'H:\My Drive\EC503 Learning From Data\project\archive_ATP1D\atp1d.csv';

