function [Opinion, Strength, Map] = Initialise(SizeX, SizeY, maxRange, PathName, useNormalDistribution)
%     Returns the Opinion, Strength and Map matrices with dimensions (SizeX,SizeY) needed to run the simulation. 
%     Opinion and Map are imported from grayscale .jpg images and Strength from .txt file located in the PathName folder
%     Opinion has values from -1 to 1 and Map/Strength from 0 to 1 (Map is absolute)
%     If Strength.txt is not found it is created randomly and exported to PathName folder
%     Note: If dimensions and maxRange are changed, delete Strength.txt before running simulation
    
    %Import Map and Opinion from images
    %Map = round(mat2gray(rgb2gray(imresize(imread(fullfile(PathName,'Map.jpg')),[SizeX SizeY]))));
    Map = ones(SizeX, SizeY);
    %Opinion = SetOpinions(Map, 0.6, PathName);
    Opinion = mat2gray(rgb2gray(imresize(imread(fullfile(PathName,'Opinions.png')),[SizeX SizeY])))*2-1;
    

    Strength = zeros(SizeX, SizeY);
    for i = 1:SizeX
        for j = 1:SizeY
            if Map(i,j) == 1
                Strength(i,j) = ProbabilityDensityFunction(useNormalDistribution) * (maxRange - 1) + 1;
            end
        end
    end

end