function compareAlgorithms()
% compare results of RPfrhyb1 for different algorithms
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')

%% compare reference values
[t, x, y, psi]   = getData('pendulum_RKF45ref');
[~, x0, y0, psi0]   = getData('pendulum_ROSref');
x0max = max(abs(x0 - x));
y0max = max(abs(y0 - y));
psi0max = max(abs(psi0 - psi));
fprintf('Difference between reference solutions: \n')
fprintf('dx = %e  ', x0max)
fprintf('dy = %e  ', y0max)
fprintf('dpsi = %e\n\n', psi0max)

% get data with standard accuracy
[~, x1, y1, psi1] = getData('pendulum_RKF45');
[~, x2, y2, psi2] = getData('pendulum_CK45');
[~, x3, y3, psi3] = getData('pendulum_ROS');

% errors
fig1 = plotErrors(t, x1 - x, y1 - y, psi1 - psi, 'RKF45');
figure
fig2 = plotErrors(t, x2 - x, y2 - y, psi2 - psi, 'CK45');
figure
fig3 = plotErrors(t, x3 - x, y3 - y, psi3 - psi, 'ROS');

% special plot for paper
fig4 = figure('Name','error comparison');
set(fig4, 'Position', [680 258 560 500]);
subplot(2,1,1)
plot(t, x2 - x)
title('x error for CK45')
xlabel('t [s]')
ylabel('{\Delta}x [m]')

subplot(2,1,2)
plot(t, x3 - x)
title('x error for ROS')
xlabel('t [s]')
ylabel('{\Delta}x [m]')

print(fig4, '-dpdf', 'solvererrorsRP.pdf');

%% maximal errors
x1max = 1e6*max(abs(x1 - x));
x2max = 1e6*max(abs(x2 - x));
x3max = 1e6*max(abs(x3 - x));
y1max = 1e6*max(abs(y1 - y));
y2max = 1e6*max(abs(y2 - y));
y3max = 1e6*max(abs(y3 - y));
psi1max = 1e6*max(abs(psi1 - psi));
psi2max = 1e6*max(abs(psi2 - psi));
psi3max = 1e6*max(abs(psi3 - psi));
fprintf('absolute errors (compared to reference solution)\n')
fprintf('                 RKF45     CK45      ROS    \n')
fprintf('x [m]          %8.4f  %8.4f  %8.4f\n', x1max, x2max, x3max)
fprintf('y [m]          %8.4f  %8.4f  %8.4f\n', y1max, y2max, y3max)
fprintf('psi            %8.4f  %8.4f  %8.4f\n', psi1max, psi2max, psi3max)

%% compare solver parameters
[~, x4, y4, psi4] = getData('pendulum_ROS_EvIt');  % Event Iterations = 1000
x4max = 1e6*max(abs(x4-x));
y4max = 1e6*max(abs(y4-y));
psi4max = 1e6*max(abs(psi4-psi));
[~, x5, y5, psi5] = getData('pendulum_ROS_MinEv');  % Minimize Evnts = On
x5max = 1e6*max(abs(x5-x));
y5max = 1e6*max(abs(y5-y));
psi5max = 1e6*max(abs(psi5-psi));
fprintf('\nabsolute errors (compared to reference solution)\n')
fprintf('                 ROS       EvIt      MinEv    \n')
fprintf('x              %8.4f  %8.4f  %8.4f\n', x3max, x4max, x5max)
fprintf('y              %8.4f  %8.4f  %8.4f\n', y3max, y4max, y5max)
fprintf('psi            %8.4f  %8.4f  %8.4f\n', psi3max, psi4max, psi5max)

%------------------------------------------------------------------------
function [t, x, y, psi] = getData(name)
% reads data from file
data = readtable([name, '.csv']);
t = data{:,1};
x = data{:,2};
y = data{:,3};
psi = data{:,4};

%------------------------------------------------------------------------
function fig = plotErrors(t, xErr, yErr, psiErr, name)
% plot errors in s and v
subplot(2,1,1)
plot(t, xErr, t, yErr)
title([name, ': error in x,y'])
xlabel('t [s]')
ylabel('{\Delta}s [m]')
legend('x', 'y', 'Location', 'Best')

subplot(2,1,2)
plot(t, psiErr)
title([name, ': error in psi'])
xlabel('t [s]')
ylabel('\Delta\psi')
fig = gcf();

