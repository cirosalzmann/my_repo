function [] = DispRGB(Opinion, Map)
%% %%%%%%%%%%%%%%%%%%%%%%% Description %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creates an RGB image from the Opinion and Map matrices and displays it
% RGBAbsolute is the absolute state of each node (no intermediary, either blue or red)
% Coordinates without agents (where Map = 0) are displayed white
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialise Matrices
[SizeX, SizeY] = size(Opinion);
RGBImage = zeros(SizeX, SizeY, 3);

%% Create RGB Images
for i = 1:SizeX
    for j = 1:SizeY
        if Map(i,j) == 0
            RGBImage(i,j,:) = 1;
            continue
        end       
        if Opinion(i,j) >= 0.5
            RGBImage(i,j,1) = 0.7;
        else
            RGBImage(i,j,3) = 0.7;
        end
    end
end

%% Display RGB Images
% figure
image(RGBImage)

end