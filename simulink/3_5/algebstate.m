function algebstate()
% compare DIshu1 and DIshi1
warning('OFF', 'Simulink:Engine:SortDiscontinuityInAlgLoop') % doesn't work
[t, iL, uC, iD, uD] = runModel("DIshu1");
[~, iL1, uC1, iD1, uD1] = runModel("DIshi1");

% compute maximal deviations
diLMax = max(abs(iL - iL1))
duCMax = max(abs(uC - uC1))
diDMax = max(abs(iD - iD1))
duDMax = max(abs(uD - uD1))

t0 = 0;
t1 = 500e-6;

%% plots of standard variables
fig = figure;
set(fig, 'Position', [10 10 700 700]);

% plot variables
subplot(2,2,1)
plot(t, iL, t, iL1)
xlabel('t [s]')
ylabel('i_L [A]')
xlim([t0, t1])
legend('dishu', 'dishi', 'Location', 'Best')

subplot(2,2,2)
plot(t, uC, t, uC1)
xlabel('t [s]')
ylabel('u_C [V]')
xlim([t0, t1])
legend('dishu', 'dishi', 'Location', 'Best')

subplot(2,2,3)
plot(t, iD, t, iD1)
xlabel('t [s]')
ylabel('i_D [A]')
xlim([t0, t1])
legend('dishu', 'dishi', 'Location', 'Best')

subplot(2,2,4)
plot(t, uD, t, uD1)
xlabel('t [s]')
ylabel('u_D [V]')
xlim([t0, t1])
legend('dishu', 'dishi', 'Location', 'Best')

%--------------------------------------------------------------------
function [t, iL, uC, iD, uD] = runModel(name)
out = sim(name);
t = out.iL.Time;
iL = out.iL.Data;
uC = out.uC.Data;
iD = out.iD.Data;
uD = out.uD.Data;
