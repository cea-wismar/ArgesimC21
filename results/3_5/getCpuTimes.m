function getCpuTimes()
% compare cpu times for running both models
times = importfile('times.txt');
names = times{:,1};
suValues = times{:, 2:6};
siValues = times{:, 7:11};

suMeans = mean(suValues')';
siMeans = mean(siValues')';

suTotal = sum(suMeans);
siTotal = sum(siMeans);

names = [names; 'Total'];
su = [suMeans; suTotal];
si = [siMeans; siTotal];

fprintf('%36s dishu     dishi\n', '')
fprintf('%-36s %6.4f     %6.4f\n', [names, su, si]')

fprintf('\nsuTotal/siTotal =  %6.4f\n', siTotal/suTotal)

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
