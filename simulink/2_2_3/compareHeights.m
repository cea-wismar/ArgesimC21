function compareHeights()
% compares height results of Simulink and MapleSim results
[hS10, wS10] = readData('maxTables.txt');
[hS12, wS12] = readData('maxTables12.txt');
[hM10, wM10] = readData('maxTablesms.txt');
[hM12, wM12] = readData('maxTables12ms.txt');

fprintf('\nrelative errors with different Simulink accuracies\n' )
compareData(hS10, wS10, hS12, wS12)

fprintf('\nrelative errors with different MapleSim accuracies\n' )
compareData(hM10, wM10, hM12, wM12)

fprintf('\nrelative errors between Simulink and MapleSim values (low acc.)\n')
compareData(hS10, wS10, hM10, wM10)

fprintf('\nrelative errors between Simulink and MapleSim values (high acc.)\n')
compareData(hS12, wS12, hM12, wM12)


function [h, w] = readData(file)
data = readtable(file);
h = data.Var2;
w = data.Var3;

function compareData(h1, w1, h2, w2)
eh = max(abs(h1 - h2)./h2);
ew = max(abs(w1 - w2)./w2);
fprintf('eh = %10.4e,  ew = %10.4e\n', eh, ew)
