function computeGamma()
% compute gamma values from initial values and simulation results

% computes gamma values
om0 = -0.833703304;     % reference value

% initial values
g = 9.81;
l = 1;
om2 = sqrt(g/l);
fprintf('omega_2 = %8.6f\n', om2)

% results
oms = [18.334081457723, 8.4621906335016, 11.837062245222, 15.39726758378];

gammas = oms/om0;

fprintf('\n Gammas:\n')
fprintf('%11.6f\n', gammas)
