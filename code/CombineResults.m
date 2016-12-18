function [ CombinedResults ] = CombineResults( runs, filenameSuffix )
    % reads the created tmp csv files and combines them into 1 matrix,
    % where the first column are the points of the x-axis and the other 
    %`runs` columns are the corresponding data points (y) for each run
    
    CombinedResults = zeros(101, runs + 1);
    % create matrix of min and max x values for each run
    MinMax = zeros(2, runs);
    for run = 1:runs
         % load data from one run from tmp csv
        singleResult = csvread(strcat('tmp_', int2str(run), filenameSuffix));
        MinMax(:, run) = [singleResult(1, 1); singleResult(end, 1)];
    end
    % take the x values that all runs have in common
    minValue = max(MinMax(1, :));
    maxValue = min(MinMax(2, :));
    % create 101 interpolation points (e. g. from 0 to 100)
    interpolationPoints = linspace(minValue, maxValue, 101);
    % save the interpolation points as the first column of the result
    CombinedResults(:, 1) = interpolationPoints;
    for run = 1:runs
        % load data from one run from tmp csv
        singleResult = csvread(strcat('tmp_', int2str(run), filenameSuffix));
        % delete tmp csv
        delete(strcat('tmp_', int2str(run), filenameSuffix));
        % interpolate the data at the interpolation points
        sp = spline(singleResult(:, 1), singleResult(:, 2), interpolationPoints');
        % save the interpolated data
        CombinedResults(:, run + 1) = sp;
    end
end

