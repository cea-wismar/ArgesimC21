function compareAlgorithms()
% compare results of DIsc1 and DIshu1 for different algorithms
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
doCompare('disc')
doCompare('dishu')

%------------------------------------------------------------------------
function doCompare(model)
fprintf('\nComparison for model %s\n', model)
fprintf('====================================\n')

%% compare reference values
[t, iL, uC, iD, uD] = getData([model, '_ROSref']);
[~, iL0, uC0, iD0, uD0] = getData([model, '_RKF45ref']);
iLmax = max(abs(iL0 - iL));
uCmax = max(abs(uC0 - uC));
iDmax = max(abs(iD0 - iD));
uDmax = max(abs(uD0 - uD));
fprintf('Difference between reference solutions: \n')
fprintf('diL = %e\n', iLmax)
fprintf('duC = %e\n', uCmax)
fprintf('diD = %e\n', iDmax)
fprintf('duD = %e\n', uDmax)

%% get data with standard accuracy
[~, iL1, uC1, iD1, uD1] = getData([model, '_RKF45']);
[~, iL2, uC2, iD2, uD2] = getData([model, '_CK45']);
[~, iL3, uC3, iD3, uD3] = getData([model, '_ROS']);

% reference values and relative errors
iLRef = max(abs(iL));
uCRef = max(abs(uC));
iDRef = max(abs(iD));
uDRef = max(abs(uD));
epsIL1 = (iL1 - iL)/iLRef;
epsIL2 = (iL2 - iL)/iLRef;
epsIL3 = (iL3 - iL)/iLRef;
epsUC1 = (uC1 - uC)/uCRef;
epsUC2 = (uC2 - uC)/uCRef;
epsUC3 = (uC3 - uC)/uCRef;
epsID1 = (iD1 - iD)/iDRef;
epsID2 = (iD2 - iD)/iDRef;
epsID3 = (iD3 - iD)/iDRef;
epsUD1 = (uD1 - uD)/uDRef;
epsUD2 = (uD2 - uD)/uDRef;
epsUD3 = (uD3 - uD)/uDRef;

% maximal errors
fprintf('\nRelative errors in ppm:\n')
fprintf('        RKF45    CK45     ROS    \n')
fprintf('eps_iL  %6.2f  %6.2f  %6.2f\n', ...
         1e6*max(epsIL1), 1e6*max(epsIL2), 1e6*max(epsIL3))
fprintf('eps_uC  %6.2f  %6.2f  %6.2f\n', ...
         1e6*max(epsUC1), 1e6*max(epsUC2), 1e6*max(epsUC3))
fprintf('eps_iD  %6.2f  %6.2f  %6.2f\n', ...
         1e6*max(epsID1), 1e6*max(epsID2), 1e6*max(epsID3))
fprintf('eps_uD  %6.2f  %6.2f  %6.2f\n', ...
         1e6*max(epsUD1), 1e6*max(epsUD2), 1e6*max(epsUD3))

% plot errors
figure
plotErrors(t, epsIL1, epsUC1, epsID1, epsUD1, 'RKF45');
figure
plotErrors(t, epsIL2, epsUC2, epsID2, epsUD2, 'CK45');
figure
plotErrors(t, epsIL3, epsUC3, epsID3, epsUD3, 'ROS');

% example plot: iD
fig = figure;
set(fig, 'Position', [10 10 560 210]);
plot(t, epsIL1, '--', t, epsIL2, '-.', t, epsIL3, '-')
xlabel('t [s]')
ylabel('\epsilon_{iD}')
xlim([3.2e-4, 3.4e-4])
legend('RKF45', 'CK45', 'ROS', 'Location', 'Best')
print(fig, '-dpdf', [model, 'errorid.pdf']);

%% compare solver parameters
[~, iL4, uC4, iD4, uD4] = getData([model, '_ROS_EvIt']);
[~, iL5, uC5, iD5, uD5] = getData([model, '_ROS_MinEv']);

epsIL4 = (iL4 - iL)/iLRef;
epsIL5 = (iL5 - iL)/iLRef;
epsUC4 = (uC4 - uC)/uCRef;
epsUC5 = (uC5 - uC)/uCRef;
epsID4 = (iD4 - iD)/iDRef;
epsID5 = (iD5 - iD)/iDRef;
epsUD4 = (uD4 - uD)/uDRef;
epsUD5 = (uD5 - uD)/uDRef;

fprintf('\nRelative errors in ppm:\n')
fprintf('        ROS      EvIt     MinEv\n')
fprintf('eps_iL  %6.2f  %6.2f  %6.2f\n', ...
         1e6*max(epsIL3), 1e6*max(epsIL4), 1e6*max(epsIL5))
fprintf('eps_uC  %6.2f  %6.2f  %6.2f\n', ...
         1e6*max(epsUC3), 1e6*max(epsUC4), 1e6*max(epsUC5))
fprintf('eps_iD  %6.2f  %6.2f  %6.2f\n', ...
         1e6*max(epsID3), 1e6*max(epsID4), 1e6*max(epsID5))
fprintf('eps_uD  %6.2f  %6.2f  %6.2f\n', ...
         1e6*max(epsUD3), 1e6*max(epsUD4), 1e6*max(epsUD5))

%------------------------------------------------------------------------
function [t, iL, uC, iD, uD] = getData(name)
% reads data from file
data = readtable([name, '.csv']);
t = data{:,1};
uC = data{:,2};
iD = data{:,3};
uD = data{:,4};
iL = data{:,5};

%---------------------------------------------------------------------
function plotErrors(t, iLErr, uCErr, iDErr, uDErr, name)
% plot errors in iL, uC, iD, uD
subplot(2,2,1)
plot(t, iLErr)
title([name, ': error in i_L'])
xlabel('t [s]')
ylabel('{\epsilon}_i')

subplot(2,2,2)
plot(t, uCErr)
title([name, ': error in u_C'])
xlabel('t [s]')
ylabel('{\epsilon}_u')

subplot(2,2,3)
plot(t, iDErr)
title([name, ': error in i_D'])
xlabel('t [s]')
ylabel('{\epsilon}_i')

subplot(2,2,4)
plot(t, uDErr)
title([name, ': error in u_D'])
xlabel('t [s]')
ylabel('{\epsilon}_u')
