function approxShockley()
% compare Shockley and approximated Shockley
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
[t, iL, uC, iD, uD] = getData('dishu');
[~, iL3, uC3, iD3, uD3] = getData('dias3');
[~, iL5, uC5, iD5, uD5] = getData('dias5');
[~, iL10, uC10, iD10, uD10] = getData('dias10');

% relative errors
iLD3 = (iL3 - iL)./abs(iL);
iLD5 = (iL5 - iL)./abs(iL);
iLD10 = (iL10 - iL)./abs(iL);
uCD3 = (uC3 - uC)./abs(uC);
uCD5 = (uC5 - uC)./abs(uC);
uCD10 = (uC10 - uC)./abs(uC);
iDD3 = (iD3 - iD)./abs(iD);
iDD5 = (iD5 - iD)./abs(iD);
iDD10= (iD10 - iD)./abs(iD);
uDD3 = (uD3 - uD)./abs(uD);
uDD5 = (uD5 - uD)./abs(uD);
uDD10 = (uD10 - uD)./abs(uD);

f = 0.15e6;
dt = 2/f;
t0 = 3e-4;
t1 = t0 + dt;

%% plots of standard variables
fig = figure;
set(fig, 'Position', [10 10 700 700]);

% plot variables
subplot(2,2,1)
plot(t, iL, t, iL3, t, iL5, t, iL10)
xlabel('t [s]')
ylabel('i_L [A]')
xlim([t0, t1])
legend('ex.', 'N=3', 'N=5', 'N=10', 'Location', 'Best')

subplot(2,2,2)
plot(t, uC, t, uC3, t, uC5, t, uC10)
xlabel('t [s]')
ylabel('u_C [V]')
xlim([t0, t1])
legend('ex.', 'N=3', 'N=5', 'N=10', 'Location', 'Best')

subplot(2,2,3)
plot(t, iD, t, iD3, t, iD5, t, iD10)
xlabel('t [s]')
ylabel('i_D [A]')
xlim([t0, t1])
legend('ex.', 'N=3', 'N=5', 'N=10', 'Location', 'Best')

subplot(2,2,4)
plot(t, uD, t, uD3, t, uD5, t, uD10)
xlabel('t [s]')
ylabel('u_D [V]')
xlim([t0, t1])
legend('ex.', 'N=3', 'N=5', 'N=10', 'Location', 'Best')

%% plots of deviations
fig = figure;
set(fig, 'Position', [10 10 700 700]);

% plot variables
subplot(2,2,1)
plot(t, iLD3, t, iLD5, t, iLD10)
xlabel('t [s]')
ylabel('\epsilon_{iL}')
xlim([t0, t1])
legend('N=3', 'N=5', 'N=10', 'Location', 'Best')

subplot(2,2,2)
plot(t, uCD3, t, uCD5, t, uCD10)
xlabel('t [s]')
ylabel('\epsilon_{uC}')
xlim([t0, t1])
legend('N=3', 'N=5', 'N=10', 'Location', 'Best')

subplot(2,2,3)
plot(t, iDD3, t, iDD5, t, iDD10)
xlabel('t [s]')
ylabel('\epsilon_{iD}')
xlim([t0, t1])
legend('N=3', 'N=5', 'N=10', 'Location', 'Best')

subplot(2,2,4)
plot(t, uDD3, t, uDD5, t, uDD10)
xlabel('t [s]')
ylabel('\epsilon_{uD}')
xlim([t0, t1])
legend('N=3', 'N=5', 'N=10', 'Location', 'Best')

%% detail plot
fig = figure;
set(fig, 'Position', [10 10 600 600]);

% plot variables
subplot(3,1,1)
plot(t, iD, t, iD3, t, iD5, t, iD10)
xlabel('t [s]')
ylabel('i_D [A]')
title('iD')
xlim([t0, t1])
legend('ex.', 'N=3', 'N=5', 'N=10', 'Location', 'Best')

subplot(3,1,2)
plot(t, iD3 - iD, t, iD5 - iD, t, iD10 - iD)
xlabel('t [s]')
ylabel('\Delta_{iD} [A]')
title('abs. errors of iD')
xlim([t0, t1])
legend('N=3', 'N=5', 'N=10', 'Location', 'Best')

subplot(3,1,3)
plot(t, uCD3, t, uCD5, t, uCD10)
xlabel('t [s]')
ylabel('\epsilon_{uC}')
title('rel. errors of uC')
xlim([t0, t1])
legend('N=3', 'N=5', 'N=10', 'Location', 'Best')

print(fig, '-dpdf', 'shapprox.pdf');

%------------------------------------------------------------------------
function [t, iL, uC, iD, uD] = getData(name)
% reads data from file
data = readtable([name, '.csv']);
t = data{:,1};
uC = data{:,2};
iD = data{:,3};
uD = data{:,4};
iL = data{:,5};
