function compensation()                                         
% plot x(t) for cases with and without air resistance

model = 'BBevaf';
sim(model);
time = x.Time;
NoAirResists = x.Data;
AirResists = xb.Data;

% Figure erstellen
f1 = figure('Name','Compensation of linear deviation');
set(f1, 'Position', [680 258 560 210]);
ax1 = subplot(1,1,1);
plot(ax1, time, AirResists, 'r', time, NoAirResists, 'b')
set(ax1, 'FontSize', 15);
legend(ax1, {'air resistance', 'no air resistance'})
xlabel(ax1, 't [s]')
ylabel(ax1, 's [m]')
ylim([0, 12])

% Exportieren des Plots
print(f1,'-dpdf', '-r0', 'compensation.pdf');