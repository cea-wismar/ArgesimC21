function bouncetime()
% "Testing accuracy of event handling"
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
                                              % schalte blöde Warnung aus

% Einlesen der Daten von BBevf4.msim
T = readtable('BBevf4.csv');
bounce  = T{:,2};
tbounce = T{:,3};

% Berechnen der exakten Bouncezeiten
x0 = 10;
mu = 0.9;
g = 9.81;
nMax = 100;
musum = cumsum(mu.^(0:(nMax-1))');
comptime = sqrt(2*x0/g)*(-1 + 2*musum);

idx = find(diff(bounce) == 1) + 1;    % wo ändert sich bounce?
modeltime = tbounce(idx(1:100));
timedif = comptime - modeltime;


% Figure erstellen
f1 = figure('Name','Testing accuracy of event handling');
set(f1, 'Position', [680 258 560 210]);
ax1 = subplot(1,1,1);
plot(1:100, timedif, 'b.')
set(ax1, 'FontSize', 15);
xlabel('no. bounce')
ylabel('{\Delta}t [s]')
ylim([0, 7e-11])

% Exportieren des Plots
print(f1,'-dpdf', '-r0', 'testingaccuracy.pdf');