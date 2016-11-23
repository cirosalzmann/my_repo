clear
clc

%Define Constants
PathName = 'Inputs&Outputs';
SizeX = 200;
SizeY = 200;

%Import Data
Map = round(mat2gray(rgb2gray(imresize(imread(fullfile(PathName,'Map.jpg')),[SizeX SizeY]))));
InitOpinion = mat2gray(rgb2gray(imresize(imread(fullfile(PathName,'InitOpinion.jpg')),[SizeX SizeY])))*2-1;
OutputOpinion = mat2gray(rgb2gray(imresize(imread(fullfile(PathName,'OutputOpinion.jpg')),[SizeX SizeY])))*2-1;
Strength = dlmread(fullfile(PathName,'Strength.txt'));

%Show Results
DispRGB(InitOpinion, Map);
DispRGB(OutputOpinion, Map);

%Histograms
% figure('Name', 'Histogram Strength', 'NumberTitle','off')
% histogram(Strength)
% figure('Name', 'Histogram Initial State', 'NumberTitle','off')
% histogram(InitOpinion)
% figure('Name', 'Histogram Final State', 'NumberTitle','off')
% histogram(Opinion)

%Grayscale Maps
% figure('Name', 'Strength', 'NumberTitle','off')
% imshow(mat2gray(Strength), 'InitialMagnification', 'fit')
% figure('Name', 'Map', 'NumberTitle','off')
% imshow(Map, 'InitialMagnification', 'fit')
% figure('Name', 'Initial State', 'NumberTitle','off')
% imshow(mat2gray(InitOpinion), 'InitialMagnification', 'fit')
% figure('Name', 'Final State', 'NumberTitle','off')
% imshow(mat2gray(Opinion), 'InitialMagnification', 'fit')