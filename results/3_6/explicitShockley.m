function explicitShockley()
% compare explicit Shockley and friends
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
plotStandardVars('disc')
plotStandardVars('dishu')
plotStandardVars('diesu1')

% compare explicit Shockleys
plotESComparison()

% compare interesting values
plotComparison()

%------------------------------------------------------------------------
function plotComparison()
[t, ~, ~, iDU1, ~] = getData('diesu1Fix');
[~, ~, ~, iDI1, ~] = getData('diesi1Fix');
[~, ~, ~, iDSH, ~] = getData('dishuFix');

fig = figure('Name', 'Comparison');
set(fig, 'Position', [10 10 600 700]);

subplot(2,1,1)
plot(t, iDSH, '-', t, iDU1, '-',  t, iDI1, '-')
xlabel('t [s]')
ylabel('i_D [A]')
legend('Shockley', 'DIesu1', 'DIesi1', 'Location', 'Best')

subplot(2,1,2)
plot(t, iDSH, '-', t, iDU1, '-.',  t, iDI1, '--')
xlabel('t [s]')
ylabel('i_D [A]')
xlim([300e-6, 310e-6])
legend('Shockley', 'DIesu1', 'DIesi1', 'Location', 'Best')

print(fig, '-dpdf', 'explicitShockley.pdf');

%------------------------------------------------------------------------
function plotESComparison()
[t, ~, ~, iDU1, ~] = getData('diesu1Fix');
[~, ~, ~, iDU2, ~] = getData('diesu2Fix');
[~, ~, ~, iDI1, ~] = getData('diesi1Fix');
[~, ~, ~, iDI2, ~] = getData('diesi2Fix');

fig = figure('Name', 'Compare explicit Shockleys');
set(fig, 'Position', [10 10 400 700]);

subplot(3,1,1)
plot(t, iDU1, t, iDU2)
xlabel('t [s]')
ylabel('i_D [A]')
legend('u1', 'u2', 'Location', 'Best')

subplot(3,1,2)
plot(t, iDI1, t, iDI2)
xlabel('t [s]')
ylabel('i_D [A]')
legend('i1', 'i2', 'Location', 'Best')

subplot(3,1,3)
plot(t, iDU1, t, iDI1)
xlabel('t [s]')
ylabel('i_D [A]')
legend('u1', 'i1', 'Location', 'Best')

%------------------------------------------------------------------------
function plotStandardVars(name)
% plots of standard variables for data set name
[t, iL, uC, iD, uD] = getData(name);
[~, iLF, uCF, iDF, uDF] = getData([name, 'Fix']);

t0 = 0;
t1 = 500e-6;

fig = figure('Name', name);
set(fig, 'Position', [10 10 700 700]);

% plot variables
subplot(2,2,1)
plot(t, iL, t, iLF)
xlabel('t [s]')
ylabel('i_L [A]')
xlim([t0, t1])
legend('variable', 'fixed', 'Location', 'Best')

subplot(2,2,2)
plot(t, uC, t, uCF)
xlabel('t [s]')
ylabel('u_C [V]')
xlim([t0, t1])
legend('variable', 'fixed', 'Location', 'Best')

subplot(2,2,3)
plot(t, iD, t, iDF)
xlabel('t [s]')
ylabel('i_D [A]')
xlim([t0, t1])
legend('variable', 'fixed', 'Location', 'Best')

subplot(2,2,4)
plot(t, uD, t, uDF)
xlabel('t [s]')
ylabel('u_D [V]')
xlim([t0, t1])
legend('variable', 'fixed', 'Location', 'Best')

%------------------------------------------------------------------------
function [t, iL, uC, iD, uD] = getData(name)
% reads data from file
data = readtable([name, '.csv']);
t = data{:,1};
uC = data{:,2};
iD = data{:,3};
uD = data{:,4};
iL = data{:,5};
