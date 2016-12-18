% Test with the probability densitiy function being a Normal distribution and also get the network properties of such a network 

[avgNeighbours, clusterCoeff] = GetResult(24, 200, 200, 4, 400000, false, true, false, true, true);
disp([avgNeighbours, clusterCoeff]);