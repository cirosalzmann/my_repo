clear
clc

%%%%%%% Define Opinion Distribution %%%%%%
% Grid = zeros(60, 60);
% for i = 26:36
%     for j = 26:36
%         Grid(i,j) = 1;
%     end
% end

Grid = round(rand(60,60)*2-ones(60,60));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[m,n] = size(Grid);

for t = 0:9999
    
    PosX = round(rand*(m-3) + 2);
    PosY = round(rand*(n-3) + 2);
    NX = round(rand*2 - 1);
    NY = round(rand*2 - 1);
    
    if NX == 0  && NY == 0
        continue
    end
    Grid(PosX, PosY) = Grid(PosX + NX, PosY + NY);
    
    imshow(mat2gray(Grid), 'InitialMagnification', 'fit')
    
    pause(0.000000001)
end


