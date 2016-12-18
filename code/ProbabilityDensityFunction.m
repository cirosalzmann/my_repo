function projection = ProbabilityDensityFunction(useNormalDistribution)
%     Returns one random value between 0 and 1 with probability density function 'prob'

    a = 5;
    x = 0:0.01:1;
    prob = exp(-a.*x.*x);  %Probability density function
    if (useNormalDistribution)
        prob = exp(-a.*(x-0.5).^2); % normal distribution pdf
    end
    pdf = prob/sum(prob);  %normalise -> Area ('Integral') = 1
    cdf = cumsum(pdf);  %Cumulative Sum -> For projection
    
    %Remove repeated values for projection
    [cdf, mask] = unique(cdf);
    x = x(mask);

    %Project random value on cdf
    RandVals = rand;
    projection = interp1(cdf, x, RandVals); 

    if isnan(projection)
        projection = 0; 
    end 
end