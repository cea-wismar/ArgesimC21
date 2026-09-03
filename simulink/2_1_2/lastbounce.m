function lastbounce()
% Argesim C21, task 2_1_2

% computation of final bounce time
x0 = 10;
g = 9.81;
my = 0.9;
beta = 0.002;
tBinf = sqrt(2*x0/g)*(1 + my)/(1 - my);
fprintf('               tInf = %11.8f\n', tBinf)

ws = warning();
warning('off','all')
model = 'BBeva2';
load_system(model);

% beta = 0
tEnd = runModel(model, 0.0);
fprintf('beta = %6.4f: tEnd = %11.8f\n', 0.0, tEnd)

% beta ~= 0
tEnd = runModel(model, beta);
fprintf('beta = %6.4f: tEnd = %11.8f\n', beta, tEnd)

warning(ws);   % restore state

function tEnd = runModel(model, beta)
simIn = Simulink.SimulationInput(model);
simIn = simIn.setVariable('beta', beta);
out = sim(simIn);
t = out.x.Time;
x = out.x.Data;

% find beginning of the final zeros
idxEnd = find(x ~= 0, 1, 'last') + 1;
tEnd = t(idxEnd);
