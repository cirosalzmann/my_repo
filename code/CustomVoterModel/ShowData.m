close all
clear
clc
%% %%%%%%%%%%%%%%%%% Description %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Imports all results from simulation in the 'PathName' folder and displays it
% The results can only be displayed if all matrices are present in the
% folder (excluding Map)
% The dimensions can be adjusted independently from what was used for the simulation

% Note: 'PathName' can include either the enire path (ex C:\Users\Ciro\Documents\MATLAB\CustomVoterModel)
% or just the path beginning from the folder where the .m files are (ex Inputs&Outputs)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Define Constants
PathName = 'Inputs&Outputs\5_200_Norm_Square';
SizeX = 200;
SizeY = 200;

%% Import Data
if exist(fullfile(PathName, 'Map.png')) == 2
    Map = round(mat2gray(rgb2gray(imresize(imread(fullfile(PathName,'Map.png')),[SizeX SizeY]))));
else
    disp('Map.png not found! Using empty map.')
    Map = ones(SizeX, SizeY);
end

InitOpinion = mat2gray(rgb2gray(imresize(imread(fullfile(PathName,'InitOpinion.png')),[SizeX SizeY])))*2-1;
OutputOpinion = dlmread(fullfile(PathName,'OutputOpinion.txt'));
Strength = dlmread(fullfile(PathName,'Strength.txt'));

%% RGB Images
% figure('Name', 'Initial Opinion Distribution', 'NumberTitle','off')
% DispRGB(InitOpinion, Map);
% figure('Name', 'Final Opinion Distribution', 'NumberTitle','off')
% DispRGB(OutputOpinion, Map);

%% Histograms
figure('Name', 'Histogram Strength', 'NumberTitle','off')
histogram(Strength)
xlabel('Strength')
ylabel('Number of nodes')
% figure('Name', 'Histogram Initial State', 'NumberTitle','off')
% histogram(InitOpinion)
% figure('Name', 'Histogram Final State', 'NumberTitle','off')
% histogram(Opinion)

%% Grayscale Maps
figure('Name', 'Strength Distribution', 'NumberTitle','off')
imshow(mat2gray(Strength), 'InitialMagnification', 'fit')
% figure('Name', 'Map', 'NumberTitle','off')
% imshow(Map, 'InitialMagnification', 'fit')
% figure('Name', 'Initial State', 'NumberTitle','off')
% imshow(mat2gray(InitOpinion), 'InitialMagnification', 'fit')
% figure('Name', 'Final State', 'NumberTitle','off')
% imshow(mat2gray(OutputOpinion), 'InitialMagnification', 'fit')