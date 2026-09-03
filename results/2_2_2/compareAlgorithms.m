function compareAlgorithms()
% compare results of BBcca3 for different algorithms
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames') % no warning

% compare reference values
[t, x, v]   = getData('BBcca3_RKF45ref');
[~, x0, v0]   = getData('BBcca3_ROSref');
s0max = max(abs(x0-x));
v0max = max(abs(v0-v));
fprintf('Difference between reference solutions: \n')
fprintf('ds = %e  ', s0max)
fprintf('dv = %e\n\n', v0max)

% get data with standard accuracy
[~, x1, v1] = getData('BBcca3_RKF45');
[~, x2, v2] = getData('BBcca3_CK45');
[~, x3, v3] = getData('BBcca3_ROS');

% errors
fig1 = plotErrors(t, x1 - x, v1 - v, 'RKF45');
%figure
fig2 = plotErrors(t, x2 - x, v2 - v, 'CK45');
%figure
fig3 = plotErrors(t, x3 - x, v3 - v, 'ROS');

print(fig3,'-dpdf', '-r0', 'solvererrorROS.pdf');

% maximal errors
s1max = 1000*max(abs(x1-x));
s2max = 1000*max(abs(x2-x));
s3max = 1000*max(abs(x3-x));
v1max = max(abs(v1-v));
v2max = max(abs(v2-v));
v3max = max(abs(v3-v));
fprintf('absolute errors (compared to reference solution)\n')
fprintf('                 RKF45     CK45      ROS    \n')
fprintf('s [1e-3 m]     %8.4f  %8.4f  %8.4f\n', s1max, s2max, s3max)
fprintf('v [m/s]        %8.4f  %8.4f  %8.4f\n', v1max, v2max, v3max)

% compare solver parameters
[~, x4, v4] = getData('BBcca3_ROS_EvIt');  % Event Iterations = 1000
s4max = 1000*max(abs(x4-x));
v4max = max(abs(v4-v));
[~, x5, v5] = getData('BBcca3_ROS_MinEv');  % Minimize Evnts = On
s5max = 1000*max(abs(x5-x));
v5max = max(abs(v5-v));
fprintf('\nabsolute errors (compared to reference solution)\n')
fprintf('                 ROS       EvIt      MinEv    \n')
fprintf('s [1e-3 m]     %8.4f  %8.4f  %8.4f\n', s3max, s4max, s5max)
fprintf('v [m/s]        %8.4f  %8.4f  %8.4f\n', v3max, v4max, v5max)

% show problematic area in v
fig4 = figure('Name','Detail of v results');
set(fig4, 'Position', [680 258 560 210]);
plot(t, v0, t, v3)
xlim([4.215, 4.24])
ylim([-0.6, 0.3])
xlabel('t [s]')
ylabel('v [m/s]')
legend('Ref', 'ROS', 'Location', 'Best')

print(fig4,'-dpdf', '-r0', 'vDetail.pdf');

%------------------------------------------------------------------------
function [t, x, v] = getData(name)
% reads data from file
data = readtable([name, '.csv']);
t = data{:,1};
x = data{:,2};
v = data{:,3};

%------------------------------------------------------------------------
function fig = plotErrors(t, xErr, vErr, name)
% plot errors in s and v
subplot(2,1,1)
plot(t, xErr)
title([name, ': error in s\_rel'])
xlabel('t [s]')
ylabel('{\Delta}s [m]')
xlim([0,5])

subplot(2,1,2)
plot(t, vErr)
title([name, ': error in v\_rel'])
xlabel('t [s]')
ylabel('{\Delta}v [m/s]')
xlim([0,5])
fig = gcf();
