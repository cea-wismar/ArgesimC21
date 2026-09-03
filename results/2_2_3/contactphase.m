function contactphase()
% plots of first and second contact phase and of second flight phase
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames') % no warning

data = readtable('contactphase.csv');
t = data{:,1};
countH = data{:,2};
countW = data{:,3};
fc = data{:,4};
hMax = data{:,5};
w = data{:,6};
wMax = data{:,7};
y = data{:,8};
x = data{:,9};
v = data{:,10};

% get times from simulation
tc1 = 1.4326;
tf1 = 1.4358;
tc2 = 2.8621;
tf2 = 2.8654;
epsC1 = (tf1 - tc1)/10;
epsF2 = (tc2 - tf1)/10;
epsC2 = (tf2 - tc2)/10;

%% first contact phase
fig1 = figure('Name','Contact Phase 1');
set(fig1, 'Position', [10 10 700 500]);

ax = subplot(2,2,1);
plot(t, x, 'b-',  t, y, 'r-.')
set(ax, 'FontSize', 15);
xlim([tc1 - epsC1, tf1 + epsC1])
xlabel('t [s]')
ylabel('x/y [m]')
legend('x', 'y', 'Location', 'Best')

ax = subplot(2,2,2);
plot(t, v, 'b-')
set(ax, 'FontSize', 15);
xlim([tc1 - epsC1, tf1 + epsC1])
xlabel('t [s]')
ylabel('v [m/s]')

ax = subplot(2,2,3);
plot(t, w, 'b-')
set(ax, 'FontSize', 15);
xlim([tc1 - epsC1, tf1 + epsC1])
xlabel('t [s]')
ylabel('w [m]')

ax = subplot(2,2,4);
plot(t, fc, 'b-')
set(ax, 'FontSize', 15);
xlim([tc1 - epsC1, tf1 + epsC1])
xlabel('t [s]')
ylabel('f_{c} [N]')

print(fig1,'-dpdf', 'contactphase1.pdf');

%% second contact phase
fig2 = figure('Name','Contact Phase 2');
set(fig2, 'Position', [10 10 700 500]);

ax = subplot(2,2,1);
plot(t, x, 'b-',  t, y, 'r-.')
set(ax, 'FontSize', 15);
xlim([tc2 - epsC2, tf2 + epsC2])
xlabel('t [s]')
ylabel('x/y [m]')
legend('x', 'y', 'Location', 'Best')

ax = subplot(2,2,2);
plot(t, v, 'b-')
set(ax, 'FontSize', 15);
xlim([tc2-epsC2, tf2+epsC2])
xlabel('t [s]')
ylabel('v [m/s]')

ax = subplot(2,2,3);
plot(t, w, 'b-')
set(ax, 'FontSize', 15);
xlim([tc2-epsC2, tf2+epsC2])
xlabel('t [s]')
ylabel('w [m]')

ax = subplot(2,2,4);
plot(t, fc, 'b-')
set(ax, 'FontSize', 15);
xlim([tc2-epsC2, tf2+epsC2])
xlabel('t [s]')
ylabel('f_{c} [N]')

print(fig2,'-dpdf', 'contactphase2.pdf');

%% second flight phase
fig3 = figure('Name','Flight Phase 2');
set(fig3, 'Position', [10 10 700 500]);

ax = subplot(2,2,1);
plot(t, x, 'b-',  t, y, 'r-.')
set(ax, 'FontSize', 15);
xlim([tf1 - epsF2, tc2 + epsF2])
xlabel('t [s]')
ylabel('x/y [m]')
legend('x', 'y', 'Location', 'Best')

ax = subplot(2,2,2);
plot(t, v, 'b-')
set(ax, 'FontSize', 15);
xlim([tf1 - epsF2, tc2 + epsF2])
xlabel('t [s]')
ylabel('v [m/s]')

ax = subplot(2,2,3);
plot(t, w, 'b-')
set(ax, 'FontSize', 15);
xlim([tf1 - epsF2, tc2 + epsF2])
xlabel('t [s]')
ylabel('w [m]')

ax = subplot(2,2,4);
plot(t, fc, 'b-')
set(ax, 'FontSize', 15);
xlim([tf1 - epsF2, tc2 + epsF2])
xlabel('t [s]')
ylabel('f_{c} [N]')

print(fig3,'-dpdf', 'flightphase2.pdf');

%%
idx = find(diff(countH) == 1) + 1;    % wo ändert sich hMax?
hMaxReduced = hMax(idx(1:end));
idy = find(diff(countW) == 1) + 1;    % wo ändert sich wMax?
wReduced = wMax(idy(1:end));

n = (1:length(hMaxReduced));
A = [n; hMaxReduced'; 1000*wReduced'];
fileID1 = fopen('maxTables.txt', 'w');
fprintf(fileID1,' n       hMax [m]     wMax [mm]\n');
fprintf(fileID1,'%2.0f   %15.11f   %12.8f\n',A);
fclose(fileID1);
