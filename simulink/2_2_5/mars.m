function mars()
model = 'BBcca1';
load_system(model);

% earth run
g = 9.81; beta = 0.002;
[tE, xE, vE] = runModel(model, g, beta);

% mars run
g = 3.69; beta = 2.3e-4;
[tM, xM, vM] = runModel(model, g, beta);

% time stretching
t4E = 3.768;    % time of 4th max on Earth
t4M = 6.180;    % time of 4th max on Mars
t1M = 2.3290;
t1E = 1.4326;
qt = t1M/t1E;    % time stretching factor

f1 = figure('Name','BB on mars');
set(f1, 'Position', [10 10 560 630]);

ax1 = subplot(3,1,1);
plot(tE, xE, 'r-.', tM, xM, 'b')
set(ax1, 'FontSize', 15);
legend('Earth', 'Mars', 'Location', 'Best')
xlabel('t [s]')
ylabel('s [m]')
ylim(ax1, [0 11])
xlim(ax1, [0 8])

ax2 = subplot(3,1,2);
plot(tE, vE, 'r-.', tM, vM, 'b')
set(ax2, 'FontSize', 15);
legend('Earth', 'Mars', 'Location', 'Best')
xlabel('t [s]')
ylabel('v [m/s]')
xlim(ax2, [0 8])
ylim(ax2, [-15 8])

ax3 = subplot(3,1,3);
plot(qt*tE, xE, 'r-.', tM, xM, 'b')
set(ax3, 'FontSize', 15);
legend('Earth (time stretched)', 'Mars', 'Location', 'Best')
xlabel('t')
ylabel('s [m]')
xlim(ax3, [0 8])
ylim(ax3, [0 10])

set(gcf(), 'PaperOrientation', 'landscape')
print(f1,'-dpdf', 'mars.pdf');

%------------------------------------------------------------------------
function [t, x, v] = runModel(model, g, beta)
simIn = Simulink.SimulationInput(model);
simIn = simIn.setVariable('g', g);
simIn = simIn.setVariable('beta', beta);
out = sim(simIn);
t = out.x.Time;
x = out.x.Data;
v = out.v.Data;
