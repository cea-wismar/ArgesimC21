function pendulum()
% plot pendulum results
load_system("RPfrhyb1");
[t, x, y, psi, hF, hS]  = runModel("RPfrhyb1");
fprintf("Stop time (1e-6):   %9.7f\n", t(end))

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
plot(t, hF)
xlabel('t [s]')
ylabel('h_F [N]')
title('Rope force h_F')

subplot(4,1,4)
plot(t, hS)
xlabel('t [s]')
ylabel('h_S [m^2]')
title('Rope slack h_S')

print(fig, '-dpdf', 'pendulum.pdf');

% Endzeit bei anderen Solver-Parametern
set_param("RPfrhyb1", "Solver", "ode45");
set_param("RPfrhyb1", "RelTol", "1e-12", "AbsTol", "1e-12");
[t, ~, ~, ~, ~, ~]  = runModel("RPfrhyb1");
fprintf("Stop time (1e-12):  %9.7f\n", t(end))

set_param("RPfrhyb1", "ShapePreserveControl", "EnableAll");
[t, ~, ~, ~, ~, ~]  = runModel("RPfrhyb1");
fprintf("Stop time (shape):  %9.7f\n", t(end))

set_param("RPfrhyb1", "Solver", "ode113");
[t, ~, ~, ~, ~, ~]  = runModel("RPfrhyb1");
fprintf("Stop time (ode113): %9.7f\n", t(end))

set_param("RPfrhyb1", "Solver", "ode15s");
[t, ~, ~, ~, ~, ~]  = runModel("RPfrhyb1");
fprintf("Stop time (ode15s): %9.7f\n", t(end))

set_param("RPfrhyb1", "Solver", "ode23s");
[t, ~, ~, ~, ~, ~]  = runModel("RPfrhyb1");
fprintf("Stop time (ode23s): %9.7f\n", t(end))

set_param("RPfrhyb1", "Solver", "ode23t");
[t, ~, ~, ~, ~, ~]  = runModel("RPfrhyb1");
fprintf("Stop time (ode23t): %9.7f\n", t(end))

set_param("RPfrhyb1", "Solver", "ode23tb");
[t, ~, ~, ~, ~, ~]  = runModel("RPfrhyb1");
fprintf("Stop time (ode23tb):%9.7f\n", t(end))


%----------------------------------------------------------------
function [t, x, y, psi, hF, hS]  = runModel(name)
out = sim(name);
t = out.x.Time;
x = out.x.Data;
y = out.y.Data;
psi = out.psi.Data;
hF = out.hF.Data;
hS = out.hS.Data;
