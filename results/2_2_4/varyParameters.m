function varyParameters()
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames') % no warning

[tRef, xRef]       = getData('par_k_e6_d_500.csv');
[tksmall, xksmall] = getData('par_k_e4_d_500.csv');
[tklarge, xklarge] = getData('par_k_e8_d_500.csv');
[tdsmall, xdsmall] = getData('par_k_e6_d_50.csv');
[tdlarge, xdlarge] = getData('par_k_e6_d_5000.csv');

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

%---------------------------------------------------------------------
function [t, x] = getData(name)
data = readtable(name);
t = data{:,1};
x = data{:,2};
