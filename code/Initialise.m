function [Opinion, Strength, Map] = Initialise(SizeX, SizeY, maxRange)

    Strength = zeros(SizeX, SizeY);
    Map = round(mat2gray(rgb2gray(imresize(imread('Map.jpg'),[SizeX SizeY]))));
    Opinion = mat2gray(rgb2gray(imresize(imread('OpMap.jpg'),[SizeX SizeY])))*2-1;

    
    for i = 1:SizeX
        for j = 1:SizeY
            
            if Map(i,j) == 1
                Strength(i,j) = ProbabilityDensityFunction()*maxRange;
            end
        
        end
    end
end