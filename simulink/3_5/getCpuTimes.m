function getCpuTimes()
% compare cpu times for running both models
tu = getTimings("DIshu1");
ti = getTimings("DIshi1");

fprintf('dishu: %6.4f  dishi: %6.4f\n', tu, ti)
fprintf('ti/tu =  %6.4f\n', ti/tu)

%---------------------------------------------------------------------
function time = getTimings(model)
% runs model 7x and returns mean of the last 5 running times
t = zeros(7,1);
for I=1:7
  tic;sim(model);t(I) = toc;
end
time = mean(t(3:end));
