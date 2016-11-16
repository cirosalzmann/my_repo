clear
clc

%%%%%%% Create Opinion Distribution %%%%%%
Grid = zeros(100, 100);
[m,n] = size(Grid);

for i = 1:m
    for j = 1:n
        Grid(i,j) = ProbabilityDensityFunction()*2-1;
    end
end

Grid0 = Grid;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for t = 0:9999999 %7*9
    
    PosX = round(rand*(m-3) + 2);
    PosY = round(rand*(n-3) + 2);
    NX = round(rand*2 - 1);
    NY = round(rand*2 - 1);
    
    if NX == 0  && NY == 0
        continue
    end
    Grid(PosX, PosY) = Grid(PosX + NX, PosY + NY);
    
end

figure('Name', 'Histogram of Initial State', 'NumberTitle','off')
histogram(Grid0)
figure('Name', 'Initial State', 'NumberTitle','off')
imshow(mat2gray(Grid0, [-1 1]), 'InitialMagnification', 'fit')
figure('Name', 'Final State', 'NumberTitle','off')
imshow(mat2gray(Grid, [-1 1]), 'InitialMagnification', 'fit')
figure('Name', 'Final Absolute State', 'NumberTitle','off')
imshow(mat2gray(round(Grid), [-1 1]), 'InitialMagnification', 'fit')
