function contactphase()
% Argesim C21, task 2_2_3
% plots of first and second contact phase and of second flight phase
ws = warning();
warning('off','all')

model = 'BBcca2';
sim(model);
t = x.Time;
x = x.Data;
y = y.Data;
w = w.Data;
v = v.Data;
fc = fc.Data;
trf = rf.Time;
rf = rf.Data;

% st has much less time values
% adapt it with brute force
st = interp1(st.Time, st.Data, t, 'previous');
fc = fc.*st;

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
set(fig1, 'Position', [10 10 630 450]);

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
set(fig2, 'Position', [10 10 630 450]);

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
set(fig3, 'Position', [10 10 630 450]);

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

%% maximal/minimal heights
hitTimes = trf(rf == 1);
hMax = interp1(t, x, hitTimes);
wMax = 1000*interp1(t, w, hitTimes);

% separate up and down events
%n = 1:ceil(length(hMax)/2);
hMax = hMax(1:2:end);
wMax = wMax(2:2:end);
N = find(hMax<0, 1, 'first') - 1;   % last bounce above ground


Out = [1:N; hMax(1:N)'; wMax(1:N)'];
fileID1 = fopen('maxTables.txt', 'w');
fprintf(fileID1,' n       hMax [m]        wMax [mm]\n');
fprintf(fileID1,'%2.0f   %15.11f   %12.8f\n', Out);
fclose(fileID1);

warning(ws);   % restore state

