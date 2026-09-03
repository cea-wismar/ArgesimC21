function pendulum()
% plot pendulum results
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
[t, x, y, psi, h1, h2] = getData('pendulum');

fig = figure('Name', 'Pendulum');
set(fig, 'Position', [10 10 550 700]);

subplot(4,1,1)
plot(t, psi*180/pi)
xlabel('t [s]')
ylabel('\psi [°]')
title('Angle \psi')

subplot(4,1,2)
plot(t, x, t, y)
xlabel('t [s]')
ylabel('x,y [m]')
legend('x', 'y', 'Location', 'Best')
title('Position (x,y)')

subplot(4,1,3)
plot(t, h1)
xlabel('t [s]')
ylabel('h_F [N]')
title('Rope force h_F')

subplot(4,1,4)
plot(t, h2)
xlabel('t [s]')
ylabel('h_S [m^2]')
title('Rope slack h_S')

print(fig, '-dpdf', 'pendulum.pdf');

%------------------------------------------------------------------------
function [t, x, y, psi, h1, h2] = getData(name)
% reads data from file
data = readtable([name, '.csv']);
t = data{:,1};
x = data{:,2};
y = data{:,3};
psi = data{:,4};
h1 = data{:,5};
h2 = data{:,6};
