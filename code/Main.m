clear
clc

%Define Constants
tmax = 99999;
SizeX = 200;
SizeY = 200;
maxRange = 4;
NumOutputs = 1;

%Initialise
[Opinion, Strength, Map] = Initialise(SizeX,SizeY,maxRange);
InitOpinion = Opinion;

%Run Simulation
for t = 0:tmax
    
    RandX = round(rand*(SizeX-1)+1);
    RandY = round(rand*(SizeY-1)+1);
    MeanNumerator = 0;
    MeanDenominator = 0;
    List = [];
    
    for i = -maxRange:maxRange
        for j = -maxRange:maxRange
            
            if RandX + i < 1 || RandX + i > SizeX || RandY + j < 1 || RandY + j > SizeY || Map(RandX, RandY) == 0
                continue
            end   
                
            DistToNode = sqrt(i*i + j*j);
            CurrStrength = Strength(RandX + i, RandY + j);
            CurrOpinion = Opinion(RandX + i, RandY + j);
            CurrMap = Map(RandX + i, RandY + j);
            
            if CurrStrength >= DistToNode && CurrMap == 1
%                 MeanNumerator = MeanNumerator + CurrStrength*CurrOpinion;
%                 MeanDenominator = MeanDenominator + CurrStrength;
                List = [List, CurrOpinion];
            end
            
        end
    end
    
    if isempty(List)
        continue
    end
    
    Opinion(RandX, RandY) = List(round(rand*(length(List)-1)+1));
%     Grid(RandX, RandY) = MeanNumerator/MeanDenominator;

    %Output Results
    if t >= round(tmax/NumOutputs) && rem(t/round((tmax/NumOutputs)),1) == 0
        OutputResults(InitOpinion, Opinion, Strength, Map);
    end
end

%Export Results to .jpg
imwrite(cat(3,mat2gray(Opinion),mat2gray(Opinion),mat2gray(Opinion)),'Test.jpg');