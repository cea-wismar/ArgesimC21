function varyParameters()
model = 'BBcca1';
load_system(model);

% 1. run
k = 1e6; d = 500;
[tRef, xRef] = runModel(model, k, d);

% 2. run
k = 1e4; d = 500;
[tksmall, xksmall] = runModel(model, k, d);

% 3. run
k = 1e8; d = 500;
[tklarge, xklarge] = runModel(model, k, d);

% 4. run
k = 1e6; d = 50;
[tdsmall, xdsmall] = runModel(model, k, d);

% 5. run
k = 1e6; d = 5000;
[tdlarge, xdlarge] = runModel(model, k, d);


%% variations in one plot
fig1 = figure('Name','Variations');
set(fig1, 'Position', [10 10 560 450]);

ax1 = subplot(2,1,1);
plot(tRef, xRef, 'r', tksmall, xksmall, 'b--', tklarge, xklarge, 'k-.')
set(ax1, 'FontSize', 15);
legend('ref', 'low k', 'high k', 'Location', 'Best')
xlabel('t [s]')
ylabel('s [m]')

ax1 = subplot(2,1,2);
plot(tRef, xRef, 'r', tdsmall, xdsmall, 'b-.', tdlarge, xdlarge, 'k--')
set(ax1, 'FontSize', 15);
legend('ref', 'low d', 'high d', 'Location', 'Best')
xlabel('t [s]')
ylabel('s [m]')

%set(fig1, 'PaperOrientation', 'landscape')
print(fig1,'-dpdf', 'allvars.pdf');

%% compare k/d variations
fig2 = figure('Name','Compare k/d variations');
set(fig2, 'Position', [10 10 560 450]);

ax1 = subplot(2,1,1);
plot(tksmall, xksmall, 'k', tdlarge, xdlarge, 'b-.')
set(ax1, 'FontSize', 15);
xlabel('t [s]')
ylabel('s [m]')
xlim([0 2])
legend('k_0/100', '10 d_0', 'Location', 'Best')

ax1 = subplot(2,1,2);
plot(tklarge, xklarge, 'k', tdsmall, xdsmall, 'b-.')
set(ax1, 'FontSize', 15);
xlabel('t [s]')
ylabel('s [m]')
xlim([0 35])
legend('100 k_0', 'd_0/10', 'Location', 'Best')

print(fig2,'-dpdf', 'comparekd.pdf');

%------------------------------------------------------------------------
function [t, x] = runModel(model, k, d)
simIn = Simulink.SimulationInput(model);
simIn = simIn.setVariable('k', k);
simIn = simIn.setVariable('d', d);
out = sim(simIn);
t = out.x.Time;
x = out.x.Data;
