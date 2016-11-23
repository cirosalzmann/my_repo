function projection = ProbabilityDensityFunction()
    a = 5;
    x = 0:0.01:1;  %range der "Staerke"
    prob = exp(-a.*x.*x);  %Probability density function
    pdf = prob/sum(prob);  %normiert -> Flaeche (Integral) = 1
    cdf = cumsum(pdf);  %Cumulative Sum -> Fuer Projektion

    [cdf, mask] = unique(cdf);
    x = x(mask);

    % RandVals = rand(1,90000);
    RandVals = rand;
    projection = interp1(cdf, x, RandVals); 

    if isnan(projection)
        projection = 0; 
    end 
end