function getCpuTimes()
model1 = "DIsc2";
model2 = "DIshu1";

solver = ["ode45","ode23","ode113","ode15s","ode23s","ode23t","ode23tb"];
ns = length(solver);
epsrel = 1e-6;     % standard values
epsabs = 1e-6;

fprintf("solver    shortcut   Shockley   Sh/sc\n")
for I=1:ns
  tsc = getTimings(model1, solver(I), epsrel, epsabs);
  tsh = getTimings(model2, solver(I), epsrel, epsabs);
  fprintf("%-8s  %6.4f     %6.4f    %6.2f\n", ...
          solver(I), tsc, tsh, 100*tsh/tsc)
end

% reset to standard values
set_param(model1, "Solver", solver(1), "RelTol", string(epsrel), ...
                  "AbsTol", string(epsabs));
set_param(model2, "Solver", solver(1), "RelTol", string(epsrel), ...
                  "AbsTol", string(epsabs));

%---------------------------------------------------------------------
function time = getTimings(model, solver, reltol, abstol)
% runs model 7x and returns mean of the last 5 running times
set_param(model, "Solver", solver, "RelTol", string(reltol), ...
                 "AbsTol", string(abstol));
t = zeros(7,1);
for I=1:7
  tic;sim(model);t(I) = toc;
end
time = mean(t(3:end));
