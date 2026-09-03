function compareShortcutShockley()
% compare results of DIsc1 and DIshu1

% load data from Simulink DIsc1.slx
sim('DIsc2');
t_sc = iL.Time;
iL_sc = iL.Data;
uC_sc = uC.Data;
iD_sc = iD.Data;
uD_sc = uD.Data;

% load data from Simulink DIshu1.slx
sim('DIshu1')

t_shu = iL.Time;
iL_shu = iL.Data;
uC_shu = uC.Data;
iD_shu = iD.Data;
uD_shu = uD.Data;

% parameters for the visualization
f = 0.15e6;
dt = 2/f;
t0 = 3e-4;
t1 = t0 + dt;

fig = figure;
set(fig, 'Position', [10 10 700 700]);

% plot variables
subplot(2,2,1)
plot(t_sc, iL_sc, t_shu, iL_shu)
xlabel('t [s]')
ylabel('i_L [A]')
xlim([t0, t1])
legend('shortcut', 'schockley', 'Location', 'NorthEast')

subplot(2,2,2)
plot(t_sc, uC_sc, t_shu, uC_shu)
xlabel('t [s]')
ylabel('uC [V]')
xlim([t0, t1])
legend('shortcut','schockley', 'Location', 'NorthEast')

subplot(2,2,3)
plot(t_sc, iD_sc, t_shu, iD_shu)
xlabel('t [s]')
ylabel('i_D [A]')
xlim([t0, t1])
legend('shortcut','schockley', 'Location', 'NorthEast')

subplot(2,2,4)
plot(t_sc, uD_sc, t_shu, uD_shu)
xlabel('t [s]')
ylabel('u_D [V]')
xlim([t0, t1])
legend('shortcut', 'Shockley', 'Location', 'NorthEast')
% 
print(fig, '-dpdf', 'scsh.pdf');
