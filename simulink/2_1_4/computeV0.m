function computeV0()
% compute v0 leading to final bounce time of free fall 
x0 = 10;
g = 9.81;
mu = 0.9;

tbf = sqrt(2*x0/g) * (1+mu)/(1-mu);   % value for free fall

f1 = @(v) finalBouncetime(v) - tbf;
v0Guess = 5;
v0 = fzero(f1, v0Guess);
fprintf('v_0 = %12.10f\n', v0)

%-------------------------------------------------------------------------
function t = finalBouncetime(v0)
% compute final bounce time for given v0
% model: bouncing ball with air resistance and event contact
x0 = 10;
g = 9.81;
mu = 0.9;
beta = 0.002;
vg = sqrt(g/beta);

% analytical solution of the ODE for -vg < v, v0 < 0 (falling)
fv1 = @(t, v0) vg*tanh(atanh(v0/vg) - vg*beta*t);
fx1 = @(t, v0, x0) x0 - (1/(2*beta))*log(1 - v0^2/vg^2) ...
       - (1/beta)*log(cosh(atanh(v0/vg) - vg*beta*t));
   
% 1. contact
tGuess= 1/(vg*beta)*acosh(exp(beta*x0));   % time if v0 = 0
t = fzero(@(t) fx1(t, v0, x0), tGuess);
vo = fv1(t, v0);

% further N contacts
N = 1000;
vi = -mu*vo;
for I=2:N
  [vo, dt, ~] = computeThrow(vi, vg, beta);
  t = t + dt;
  vi = -mu*vo;
end

%-------------------------------------------------------------------------
function [v1, dt, xmax] = computeThrow(v0, vg, beta)
% computes parameters of the trajectory from x0 = 0 until next x = 0
% for a vertical throw with air resistance
% Inputs: 
%   v0   initial velocity at x0 = 0
%   vg   sqrt(g/beta)
%   beta air resistance
% Outputs:
%   v1   final velocity
%   dt   time until x = 0
%   xmax maximal height

% analytical solution of the ODE for 0 < v, v0 < vg (rising)
fv2 = @(t, v0) vg*tan(atan(v0/vg) - vg*beta*t);
fx2 = @(t, v0, x0) x0 + (1/(2*beta))*log(1 + v0^2/vg^2) ...
       + (1/beta)*log(cos(atan(v0/vg) - vg*beta*t));

dt1a = 1/(vg*beta)*atan(v0/vg);
xmax = fx2(dt1a, v0, 0);
dt1b = 1/(vg*beta)*acosh(exp(beta*xmax));
v1 = -vg*tanh(vg*beta*dt1b);
dt = dt1a + dt1b;
