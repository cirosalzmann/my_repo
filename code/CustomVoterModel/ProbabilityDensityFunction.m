function projection = ProbabilityDensityFunction()
%% %%%%%%%%%%%%%%%%%%%%%% Description %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Returns one random value between 0 and 1 with probability density function 'prob'
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% Create PDF and cumulative sum
    a = 6;
    x = 0:0.01:1;
    prob = exp(-a.*x.*x);  %Probability density function (PDF)     exp(-a.*x.*x + a.*x - a*0.25) , exp(-a.*x.*x)
    pdf = prob/sum(prob);  %normalise -> Area ('Integral') = 1
    cdf = cumsum(pdf);  %Cumulative Sum -> For projection
    
    %% Remove repeated values for projection
    [cdf, mask] = unique(cdf);
    x = x(mask);

    %% Project random value (with constant pdf) on cdf
    RandVals = rand;
    projection = interp1(cdf, x, RandVals); 
    
    %% Set NaN values to 0
    if isnan(projection)
        projection = 0; 
    end 
end