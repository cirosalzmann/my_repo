function [Opinion, Strength, Map] = Initialise(SizeX, SizeY, maxRange, PathName)
%% %%%%%%%%%%%%%% Description %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Returns the Opinion, Strength and Map matrices with dimensions
%     (SizeX,SizeY) needed to run the simulation. Opinion and Map are
%     imported from grayscale .jpg images and Strength from .txt file
%     located in the PathName folder. Opinion has values equal to 0 or 1 and
%     Map/Strength from 0 to 1 (Map is absolute, 0 are empty coordinates). If Strength.txt is not
%     found it is created randomly and exported to PathName folder. Note: If
%     dimensions and maxRange are changed, delete Strength.txt and OutputOpinion before
%     running simulation!!!
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% Import Map if Map.jpg exists, otherwise create empty map
    if exist(fullfile(PathName, 'Map.png')) == 2
        Map = round(mat2gray(rgb2gray(imresize(imread(fullfile(PathName,'Map.png')),[SizeX SizeY]))));
    else
        disp('Map.png not found! Creating fully populated map.')
        Map = ones(SizeX, SizeY);
    end
    
    
    %% Import Opinion if .txt already exists, otherewise import from image
    if exist(fullfile(PathName,'OutputOpinion.txt')) == 2
        Opinion = dlmread(fullfile(PathName,'OutputOpinion.txt'));
    else
        disp('OutputOpinion.txt not found! Importing from image.')
        Opinion = round(mat2gray(rgb2gray(imresize(imread(fullfile(PathName,'InitOpinion.png')),[SizeX SizeY]))));
    end
    
    %% Import Strength if .txt already exists, otherwise create and export
    if exist(fullfile(PathName,'Strength.txt')) == 2
        Strength = dlmread(fullfile(PathName,'Strength.txt'));
    else
        disp('Strength.txt not found! Creating random strength matrix.')
        Strength = zeros(SizeX, SizeY);
        for i = 1:SizeX
            for j = 1:SizeY
                if Map(i,j) == 1
                    Strength(i,j) = ProbabilityDensityFunction()*maxRange+1;
                end
            end
        end
        %Export strength .txt file
        dlmwrite(fullfile(PathName,'Strength.txt'), Strength, 'delimiter','\t');    
    end
    
end