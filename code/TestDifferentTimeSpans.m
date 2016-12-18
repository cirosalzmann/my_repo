% Test different numbers of iterations in the simulation

tmax = 100000;
while tmax < 1000000
    GetResult(24, 200, 200, 4, tmax, false, true, false, true, false);
    tmax = tmax * 2;
end
[avgNeighbours, clusterCoeff] = GetResult(24, 200, 200, maxRange, 400000, false, true, true, true, false);