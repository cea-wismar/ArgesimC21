function getCpuTimes()
% compare cpu times for running both models
times = importfile('times.txt');
names = times{:,1};
scValues = times{:, 2:6};
shValues = times{:, 7:11};

scMeans = mean(scValues')';
shMeans = mean(shValues')';

scTotal = sum(scMeans);
shTotal = sum(shMeans);

names = [names; 'Total'];
sc = [scMeans; scTotal];
sh = [shMeans; shTotal];

fprintf('%36s shortcut  Shockley\n', '')
fprintf('%-36s %6.4f     %6.4f\n', [names, sc, sh]')

fprintf('\nshTotal/scTotal =  %6.4f\n', shTotal/scTotal)

%---------------------------------------------------------------------
function zeitmessungen = importfile(filename)
% import time measurements, created with import tool
formatSpec = '%36s%7f%7f%7f%7f%7f%7f%7f%7f%7f%f%[^\n\r]';
fileID = fopen(filename,'r');

dataArray = textscan(fileID, formatSpec, inf, ...
    'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', ...
    'HeaderLines', 1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

dataArray{1} = strtrim(dataArray{1});
fclose(fileID);

zeitmessungen = table(dataArray{1:end-1}, 'VariableNames', ...
   {'Run','DIsca','DIscb','DIscc','DIscd','DIsce',...
    'DIsha','DIshb','DIshc','DIshd','DIshe'});
