function projection = ProbabilityDensityFunction()
a = 5;
x = 0:0.01:1;  %range der "Staerke"
prob = exp(-a.*x.*x);  %Probability density function
pdf = prob/sum(prob);  %normiert -> Flaeche (Integral) = 1
cdf = cumsum(pdf);  %Cumulative Sum -> Fuer Projektion

% remove non-unique elements -> Fuer Projektion braucht man eine injektive
% Funktion (im unseren Fall ist es eigentlich nicht noetig
[cdf, mask] = unique(cdf);
x = x(mask);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% plot(x, prob)

%RandVals = rand(1,90000);
RandVals = rand;
projection = interp1(cdf, x, RandVals);  %Staerke von prob abhaengig

% figure
% histogram(projection, 100)
end