function bouncetime()
% Argesim C21, task 2_1_3
% Comparison of theoretical and simulated bounce times
% for the first 100 jumps without air resistance
nMax = 100;                % number of bounces

% theoretical bounce times
mu = 0.9;
g = 9.81;
x0 = 10;
comptime = sqrt((2*x0)/g)*(-1 + 2*cumsum(mu.^(0:nMax-1)))'; 

% bounce times by simulation
model = 'BBevf2';
sim(model);
t = x.Time;
x = x.Data;
tb_sim = t(x == 0);
modeltime = tb_sim(1:nMax,:);
   
timedif = comptime - modeltime;

% plot
f1 = figure('Name','Testing accuracy of event handling');
set(f1, 'Position', [680 258 560 210]);
ax1 = subplot(1,1,1);
plot(1:nMax, timedif, 'b.')
set(ax1, 'FontSize', 15);
xlabel('no. bounce')
ylabel('{\Delta}t [s]')
ylim([-1e-11, 1.2e-10])

% export plot
print(f1,'-dpdf', '-r0', 'testingaccuracy.pdf');