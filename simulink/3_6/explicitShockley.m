function explicitShockley()
% compare explicit Shockley and friends
fprintf("Differences ode45/ode4:\n")
fprintf("              iL         uC         iD         uD\n")
compareStandardVars("DIsc2")
compareStandardVars("DIesu1")
compareStandardVars("DIas")

% compare explicit Shockleys
compareESvariants()

% compare interesting values
plotComparison()

%------------------------------------------------------------------------
function compareStandardVars(name)
% compares results for ode45 and ode4
load_system(name);
[~, iL, uC, iD, uD] = runModel(name);
[~, iLF, uCF, iDF, uDF] = runModelFix(name);

% show differences
errIL = max(abs(iLF - iL))/max(abs(iL));
errUC = max(abs(uCF - uC))/max(abs(uC));
errID = max(abs(iDF - iD))/max(abs(iD));
errUD = max(abs(uDF - uD))/max(abs(uD));
fprintf("%-10s %9.2e  %9.2e  %9.2e  %9.2e\n", ...
         name, errIL, errUC, errID, errUD)

%------------------------------------------------------------------------
function compareESvariants()
% compares results of DIesu1 and DIesi1
[~, iLu, uCu, iDu, uDu] = runModelFix("DIesu1");
load_system("DIesi1");
[~, iLi, uCi, iDi, uDi] = runModelFix("DIesi1");

% show differences
errIL = max(abs(iLu - iLi))/max(abs(iLu));
errUC = max(abs(uCu - uCi))/max(abs(uCu));
errID = max(abs(iDu - iDi))/max(abs(iDu));
errUD = max(abs(uDu - uDi))/max(abs(uDu));
fprintf("Rel. differences DIesu/DIesi:\n")
fprintf("           %9.2e  %9.2e  %9.2e  %9.2e\n", ...
         errIL, errUC, errID, errUD)

%------------------------------------------------------------------------
function plotComparison()
[t, ~, ~, iDu, ~] = runModelFix("DIesu1");
[~, ~, ~, iDi, ~] = runModelFix("DIesi1");
load_system("DIshu1");
[~, ~, ~, iDs, ~] = runModel("DIshu1");

fig = figure('Name', 'Comparison');
set(fig, 'Position', [10 10 600 1000]);

subplot(3,1,1)
plot(t, iDs, '-', t, iDu, '-.',  t, iDi, '--')
xlabel('t [s]')
ylabel('i_D [A]')
xlim([0, 5e-4])
title("Diode current i_D")
legend('Shockley', 'DIesu1', 'DIesi1', 'Location', 'Best')

subplot(3,1,2)
plot(t, iDs, '-', t, iDu, '-.',  t, iDi, '--')
xlabel('t [s]')
ylabel('i_D [A]')
xlim([300e-6, 310e-6])
title("Diode current i_D")
legend('Shockley', 'DIesu1', 'DIesi1', 'Location', 'Best')

subplot(3,1,3)
plot(t, abs(iDu-iDs)/max(abs(iDs)), '-', t, abs(iDi-iDs)/max(abs(iDs)), '-')
xlabel('t [s]')
ylabel('\epsilon_{rel}')
xlim([300e-6, 310e-6])
title("Relative errors of DIesu1 and DIesi1")
legend('DIesu1', 'DIesi1', 'Location', 'Best')

print(fig, '-dpdf', 'explicitShockley.pdf');

%------------------------------------------------------------------------
function [t, iL, uC, iD, uD] = runModel(name)
set_param(name, "Solver", "ode45", "RelTol", "1e-6", "AbsTol", "1e-6");
if name == "DIas"
  set_param(name, "AlgebraicLoopSolver","TrustRegion");
end
out = sim(name);
t = out.iL.Time;
iL = out.iL.Data;
uC = out.uC.Data;
iD = out.iD.Data;
uD = out.uD.Data;

%------------------------------------------------------------------------
function [t, iL, uC, iD, uD] = runModelFix(name)
set_param(name, "Solver", "ode4", "FixedStep", "1e-8");
if name == "DIas" || name == "DIshu1" 
  set_param(name, "AlgebraicLoopSolver","LineSearch");
end
out = sim(name);
t = out.iL.Time;
iL = out.iL.Data;
uC = out.uC.Data;
iD = out.iD.Data;
uD = out.uD.Data;
