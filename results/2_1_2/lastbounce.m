% computation of final bounce time
x0 = 10;
g = 9.81;
my = 0.9;

tBinf = sqrt(2*x0/g)*(1 + my)/(1 - my);
fprintf('tInf = %9.6f\n', tBinf)
