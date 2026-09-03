function compareAlgorithms()
% compare results of RPfrhyb1 for different algorithms
model = "RPfrhyb1";
load_system(model);
epsrel = 1e-6;     % standard values
epsabs = 1e-6;
epsrel0 = 1e-12;   % reference values
epsabs0 = 1e-12;
solver = ["ode45","ode23","ode113","ode15s","ode23s","ode23t","ode23tb"];
ns = length(solver);

%% compare reference values
[t, xR, yR, psiR] = runModel(epsrel0, epsabs0, solver(1), model);
[~, x0, y0, psi0] = runModel(epsrel0, epsabs0, solver(5), model);

x0max = max(abs(x0 - xR));
y0max = max(abs(y0 - yR));
dpsi = abs(psi0 - psiR);
dpsi(dpsi > 3) = 0;      % erase jump error
psi0max = max(dpsi);
fprintf("Difference between reference solutions: \n")
fprintf("dx = %e  ", x0max)
fprintf("dy = %e  ", y0max)
fprintf("dpsi = %e\n\n", psi0max)

%% get data with standard accuracy
fprintf("Maximal errors in 1e-6:\n")
fprintf("               x         y          psi\n")
for I=1:ns
  [~, x{I}, y{I}, psi{I}] = runModel(epsrel, epsabs, solver(I), model);
  % errors
  epsx{I} = abs(x{I} - xR);
  epsy{I} = abs(y{I} - yR);
  epspsi{I} = abs(psi{I} - psiR);
  % print maximal errors
  fprintf("%8s  %9.4f %9.4f  %9.4f\n", solver(I), ...
         1e6*max(epsx{I}), 1e6*max(epsy{I}), 1e6*max(epspsi{I}))
  % plot errors
  figure
  plotErrors(t, x{I} - xR, y{I} - yR, psi{I} - psiR, solver(I));
end

% special plot for paper
fig4 = figure("Name","error comparison");
set(fig4, "Position", [680 258 560 500]);
idx = [3,4,6];
for I=1:3
  subplot(3,1,I)
  plot(t, x{idx(I)} - xR)
  title("x error for " + solver(idx(I)))
  xlabel("t [s]")
  ylabel("{\Delta}x [m]")
end

print(fig4, "-dpdf", "solvererrorsRP.pdf");

%% compare solver parameters
fig5 = figure("Name","error comparison with shape preservation");
set(fig5, "Position", [680 258 560 500]);
fprintf("\nabsolute errors (compared to reference solution)\n")
fprintf("                ShapeCtl   MinZc\n")
for I=1:3
  fprintf("%8s\n", solver(idx(I)))
  [~, xA, yA, psiA] = runModelVar(model, solver(idx(I)), "EnableAll", "off");
  xAmax = 1e6*max(abs(xA-xR));
  yAmax = 1e6*max(abs(yA-yR));
  dpsi = abs(psiA - psiR);
  dpsi(dpsi > 3) = 0;      % erase jump error
  psiAmax = 1e6*max(dpsi);
  [~, xB, yB, psiB] = runModelVar(model, solver(idx(I)), "DisableAll", "on");
  xBmax = 1e6*max(abs(xB-xR));
  yBmax = 1e6*max(abs(yB-yR));
  dpsi = abs(psiB - psiR);
  dpsi(dpsi > 3) = 0;      % erase jump error
  psiBmax = 1e6*max(dpsi);
  fprintf("x              %8.4f  %8.4f\n", xAmax, xBmax)
  fprintf("y              %8.4f  %8.4f\n", yAmax, yBmax)
  fprintf("psi            %8.4f  %8.4f\n", psiAmax, psiBmax)
  
  % plot x errors for ShapeCtl on
  subplot(3,1,I)
  plot(t, xA - xR)
  title("x error for " + solver(idx(I)))
  xlabel("t [s]")
  ylabel("{\Delta}x [m]")
end

print(fig5, "-dpdf", "solvererrorsShape.pdf");

close_system(model,0)

%------------------------------------------------------------------------
function [t, x, y, psi] = runModel(reltol, abstol, solver, model)
set_param(model, "Solver", solver, "RelTol", string(reltol), ...
                 "AbsTol", string(abstol));
out = sim(model);
t = out.x.Time;
x = out.x.Data;
y = out.y.Data;
psi = out.psi.Data;

%------------------------------------------------------------------------
function [t, x, y, psi] = runModelVar(model, solver, val1, val2)
set_param(model, "Solver", solver, "RelTol", "1e-6", "AbsTol", "1e-6",...
          "ShapePreserveControl", val1, "MinimalZcImpactIntegration", val2);
out = sim(model);
t = out.x.Time;
x = out.x.Data;
y = out.y.Data;
psi = out.psi.Data;

%------------------------------------------------------------------------
function fig = plotErrors(t, xErr, yErr, psiErr, name)
% plot errors in s and v
subplot(2,1,1)
plot(t, xErr, t, yErr)
title(name + ": error in x,y")
xlabel("t [s]")
ylabel("{\Delta}s [m]")
legend("x", "y", "Location", "Best")

subplot(2,1,2)
plot(t, psiErr)
title(name + ": error in psi")
xlabel("t [s]")
ylabel("\Delta\psi")
fig = gcf();

