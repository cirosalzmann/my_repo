function [Opinion, Strength, Map] = Initialise(SizeX, SizeY, maxRange, PathName)

    %Import Map and Opinion from images
    Map = round(mat2gray(rgb2gray(imresize(imread(fullfile(PathName,'Map.jpg')),[SizeX SizeY]))));
    Opinion = mat2gray(rgb2gray(imresize(imread(fullfile(PathName,'OutputOpinion.jpg')),[SizeX SizeY])))*2-1;
    
    %Import or create Strength (delete if dimension and maxRange change!!)
    if exist(fullfile(PathName,'Strength.txt')) == 2
        Strength = dlmread(fullfile(PathName,'Strength.txt'));
    else
        disp('Strength.txt not found')
        Strength = zeros(SizeX, SizeY);
        for i = 1:SizeX
            for j = 1:SizeY

                if Map(i,j) == 1
                    Strength(i,j) = ProbabilityDensityFunction()*maxRange;
                end

            end
        end
        %Export strength .txt file
        dlmwrite(fullfile(PathName,'Strength.txt'), Strength, 'delimiter','\t');    
    end
end