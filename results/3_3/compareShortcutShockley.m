function compareShortcutShockley()
% compare results of DIsc1 and DIshu1
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
[t, iL1, uC1, iD1, uD1] = getData('disc');
[~, iL2, uC2, iD2, uD2] = getData('dishu');

f = 0.15e6;
dt = 2/f;
t0 = 3e-4;
t1 = t0 + dt;

fig = figure;
set(fig, 'Position', [10 10 700 700]);

% plot variables
subplot(2,2,1)
plot(t, iL1, t, iL2)
xlabel('t [s]')
ylabel('i_L [A]')
xlim([t0, t1])
legend('shortcut', 'Shockley', 'Location', 'NorthEast')

subplot(2,2,2)
plot(t, uC1, t, uC2)
xlabel('t [s]')
ylabel('uC [V]')
xlim([t0, t1])
legend('shortcut', 'Shockley', 'Location', 'NorthEast')

subplot(2,2,3)
plot(t, iD1, t, iD2)
xlabel('t [s]')
ylabel('i_D [A]')
xlim([t0, t1])
legend('shortcut', 'Shockley', 'Location', 'NorthEast')

subplot(2,2,4)
plot(t, uD1, t, uD2)
xlabel('t [s]')
ylabel('u_D [V]')
xlim([t0, t1])
legend('shortcut', 'Shockley', 'Location', 'NorthEast')

print(fig, '-dpdf', 'scsh.pdf');

%------------------------------------------------------------------------
function [t, iL, uC, iD, uD] = getData(name)
% reads data from file
data = readtable([name, '.csv']);
t = data{:,1};
uC = data{:,2};
iD = data{:,3};
uD = data{:,4};
iL = data{:,5};
