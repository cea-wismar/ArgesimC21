function compareAlgorithms()
% Argesim C21, task 2_2_2
% compare results of BBcca1 for different solvers
epsrel = 1e-6;     % standard values
epsabs = 1e-6;
epsrel0 = 1e-12;   % reference values
epsabs0 = 1e-12;
solver = ["ode45","ode23","ode113","ode15s","ode23s","ode23t","ode23tb"];
ns = length(solver);

% compare reference values
[t, x, v]   = runModel(epsrel0, epsabs0, solver(1));
[~, x0, v0]   = runModel(epsrel0, epsabs0, solver(2));
s0max = max(abs(x0-x));
v0max = max(abs(v0-v));
fprintf("Difference between reference solutions: \n")
fprintf("ds = %e  ", s0max)
fprintf("dv = %e\n\n", v0max)

% get data with standard accuracy
fprintf("            s [mm]   v [m/s]\n")
for I=1:ns
  [~, xs{I}, vs{I}]   = runModel(epsrel, epsabs, solver(I));
  % maximal errors
  smax(I) = 1000*max(abs(xs{I}-x));
  vmax(I) = max(abs(vs{I}-v));
  fprintf("%8s  %8.4f %8.4f\n", solver(I), smax(I), vmax(I))
end

% plot errors
fig1 = plotErrors(t, xs{1} - x, vs{1} - v, solver(1));
print(fig1,"-dpdf", "-r0", "solvererrors45.pdf");

% compare special solver parameters
model = "BBcca1";
set_param(model, "ShapePreserveControl", "EnableAll");
[~, x4, v4]   = runModel(epsrel, epsabs, solver(1));
set_param(model, "ShapePreserveControl", "DisableAll");
smaxA = 1000*max(abs(x4-x));
vmaxA = max(abs(v4-v));

set_param(model, "MinimalZcImpactIntegration", "on");
[~, x5, v5]   = runModel(epsrel, epsabs, solver(1));
set_param(model, "MinimalZcImpactIntegration", "off");
smaxB = 1000*max(abs(x5-x));
vmaxB = max(abs(v5-v));

fprintf('\nabsolute errors (compared to reference solution)\n')
fprintf('           ode45     Shape     MinZc\n')
fprintf('s [mm]   %8.4f  %8.4f  %8.4f\n', smax(1), smaxA, smaxB)
fprintf('v [m/s]  %8.4f  %8.4f  %8.4f\n', vmax(1), vmaxA, vmaxB)


%------------------------------------------------------------------------
function [t, x, v] = runModel(reltol, abstol, solver)
model = "BBcca1";
set_param(model, "Solver", solver, "RelTol", string(reltol), ...
                 "AbsTol", string(abstol));
sim(model);
t = x.Time;
x = x.Data;
v = v.Data;
%------------------------------------------------------------------------
function fig = plotErrors(t, xErr, vErr, name)
% plot errors in x and v
tEnd = 5;
subplot(2,1,1)
plot(t, xErr)
title(name + ": error in x")
xlabel("t [s]")
ylabel("{\Delta}x [m]")
xlim([0,tEnd])

subplot(2,1,2)
plot(t, vErr)
title(name + ": error in v")
xlabel("t [s]")
ylabel("{\Delta}v [m/s]")
xlim([0,tEnd])
fig = gcf();
