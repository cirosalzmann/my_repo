% Test different max ranges and also get network properties
networkProperties = zeros(3, 5);
for maxRange = 1:5
    [avgNeighbours, clusterCoeff] = GetResult(24, 200, 200, maxRange, 400000, false, true, true, true, false);
    disp(avgNeighbours);
    disp(clusterCoeff);
    networkProperties(:, maxRange) = [maxRange, avgNeighbours, clusterCoeff];
end
csvwrite(fullfile('Outputs', 'networkPropertiesTable.csv'), networkProperties);
disp(networkProperties);