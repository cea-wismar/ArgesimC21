function vOffset()
% computes changes of t_b,Inf for v0 ~= 0
g = 9.81;
x0 = 10;
mu = 0.9;

a = 2*x0/g;
q = (1 + mu)/(1 - mu);
tBInf = @(v0) q*sqrt(a + v0.^2/g^2)+ v0/g;

v0 = -5:0.01:5;
tB = tBInf(v0);

plot(v0, tB)
xlabel('v_0 [m/s]')
ylabel('t_{B,\infty} [s]')

% minimum
v0min = -g*sqrt(a/(q^2 - 1))
tBMin = sqrt(a*(q^2 - 1))

tBmin = 2/(1-mu)*sqrt(2*x0*mu/g)
