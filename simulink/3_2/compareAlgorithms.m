function compareAlgorithms()
% Argesim C21, task 3_2
% compare results of DIsc2 and DIshu1 for different solvers
doCompare("DIsc2")
doCompare("DIshu1")

function doCompare(model)
fprintf('\nComparison for model %s\n', model)
fprintf('====================================\n')

epsrel = 1e-6;     % standard values
epsabs = 1e-6;
epsrel0 = 1e-12;   % reference values
epsabs0 = 1e-12;
solver = ["ode45","ode23","ode113","ode15s","ode23s","ode23t","ode23tb"];
ns = length(solver);

%% compare reference values
[t, iLR, uCR, iDR, uDR] = runModel(epsrel0, epsabs0, solver(1), model);
[~, iL0, uC0, iD0, uD0] = runModel(epsrel0, epsabs0, solver(4), model);
% reference values
iLRef = max(abs(iLR));
uCRef = max(abs(uCR));
iDRef = max(abs(iDR));
uDRef = max(abs(uDR));

iLmax = max(abs(iL0 - iLR))/iLRef;
uCmax = max(abs(uC0 - uCR))/uCRef;
iDmax = max(abs(iD0 - iDR))/iDRef;
uDmax = max(abs(uD0 - uDR))/uDRef;
fprintf('Difference between reference solutions: \n')
fprintf('diL = %e\n', iLmax)
fprintf('duC = %e\n', uCmax)
fprintf('diD = %e\n', iDmax)
fprintf('duD = %e\n', uDmax)

%% get data with standard accuracy
fprintf('\nRelative errors in ppm:\n')
fprintf("               iL        uC         iD         uD\n")
for I=1:ns
  [~, iL{I}, uC{I}, iD{I}, uD{I}] ...
                 = runModel(epsrel, epsabs, solver(I), model);
  % relative errors
  epsIL{I} = abs(iL{I} - iLR)/iLRef;
  epsUC{I} = abs(uC{I} - uCR)/uCRef;
  epsID{I} = abs(iD{I} - iDR)/iDRef;
  epsUD{I} = abs(uD{I} - uDR)/uDRef; 
  % print maximal errors
  fprintf("%8s  %9.4f %9.4f  %9.4f  %9.4f\n", solver(I), ...
         1e6*max(epsIL{I}), 1e6*max(epsUC{I}), ...
         1e6*max(epsID{I}), 1e6*max(epsUD{I}))
end

% plot errors
for I=1:ns
  figure
  plotErrors(t, epsIL{I}, epsUC{I}, epsID{I}, epsUD{I}, solver(I));
end

% example plot: iD
fig = figure;
%set(fig, 'Position', [10 10 560 210]);
subplot(3,1,1)
plot(t, epsID{2})
xlabel("t [s]")
ylabel("\epsilon_{iD}")
xlim([3.2e-4, 3.4e-4])
title(solver(2))

subplot(3,1,2)
plot(t, epsID{3})
xlabel("t [s]")
ylabel("\epsilon_{iD}")
xlim([3.2e-4, 3.4e-4])
title(solver(3))

subplot(3,1,3)
plot(t, epsID{4})
xlabel("t [s]")
ylabel("\epsilon_{iD}")
xlim([3.2e-4, 3.4e-4])
title(solver(4))

print(fig, "-dpdf"', model + "errorid.pdf");

%% compare solver parameters
% "DisableAll" | "EnableAll"
% "Nonadaptive" | "Adaptive"
[~, iLa, uCa, iDa, uDa] = runModelVar(model, "EnableAll", "Nonadaptive");
[~, iLb, uCb, iDb, uDb] = runModelVar(model, "DisableAll", "Adaptive");
% reset to normal
set_param(model, "ShapePreserveControl", "DisableAll", ...
     "ZeroCrossAlgorithm", "Nonadaptive");

% relative errors
%epsIL{I} = abs(iL{I} - iLR)/iLRef;
epsILa = abs(iLa - iLR)/iLRef;
epsILb = abs(iLb - iLR)/iLRef;
epsUCa = abs(uCa - uCR)/uCRef;
epsUCb = abs(uCb - uCR)/uCRef;
epsIDa = abs(iDa - iDR)/iDRef;
epsIDb = abs(iDb - iDR)/iDRef;
epsUDa = abs(uDa - uDR)/uDRef;
epsUDb = abs(uDb - uDR)/uDRef;

fprintf('\nRelative errors in ppm:\n')
fprintf('         ode45   Shape   Algo\n')
fprintf('eps_iL  %6.3f  %6.3f  %6.3f\n', ...
         1e6*max(epsIL{1}), 1e6*max(epsILa), 1e6*max(epsILb))
fprintf('eps_uC  %6.3f  %6.3f  %6.3f\n', ...
         1e6*max(epsUC{1}), 1e6*max(epsUCa), 1e6*max(epsUCb))
fprintf('eps_iD  %6.3f  %6.3f  %6.3f\n', ...
         1e6*max(epsID{1}), 1e6*max(epsIDa), 1e6*max(epsIDb))
fprintf('eps_uD  %6.3f  %6.3f  %6.3f\n', ...
         1e6*max(epsUD{1}), 1e6*max(epsUDa), 1e6*max(epsUDb))

%------------------------------------------------------------------------
function [t, iL, uC, iD, uD] = runModel(reltol, abstol, solver, model)
set_param(model, "Solver", solver, "RelTol", string(reltol), ...
                 "AbsTol", string(abstol));
sim(model);
t = iL.Time;
iL = iL.Data;
uC = uC.Data;
iD = iD.Data;
uD = uD.Data;

%------------------------------------------------------------------------
function [t, iL, uC, iD, uD] = runModelVar(model, val1, val2)
set_param(model, "Solver", "ode45", "RelTol", "1e-6", "AbsTol", "1e-6",...
          "ShapePreserveControl", val1, "ZeroCrossAlgorithm", val2);
sim(model);
t = iL.Time;
iL = iL.Data;
uC = uC.Data;
iD = iD.Data;
uD = uD.Data;
%------------------------------------------------------------------------
function plotErrors(t, iLErr, uCErr, iDErr, uDErr, name)
% plot errors in iL, uC, iD, uD
flag = true;    % use xlim to show a small section?

subplot(2,2,1)
plot(t, iLErr)
title(name + ": error in i_L")
xlabel("t [s]")
ylabel("{\epsilon}_i")
if flag, xlim([3.2, 3.4]*1e-4), end

subplot(2,2,2)
plot(t, uCErr)
title(name + ": error in u_C")
xlabel("t [s]")
ylabel("{\epsilon}_u")
if flag, xlim([3.2, 3.4]*1e-4), end

subplot(2,2,3)
plot(t, iDErr)
title(name + ": error in i_D")
xlabel("t [s]")
ylabel("{\epsilon}_i")
if flag, xlim([3.2, 3.4]*1e-4), end

subplot(2,2,4)
plot(t, uDErr)
title(name + ": error in u_D")
xlabel("t [s]")
ylabel("{\epsilon}_u")
if flag, xlim([3.2, 3.4]*1e-4), end
