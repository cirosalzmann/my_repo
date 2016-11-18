function [] = OutputResults(InitOpinion, Opinion, Strength, Map)

[SizeX, SizeY,p] = size(Opinion);
RGBImage = zeros(SizeX, SizeY, 3);

%Create RGB Image
for i = 1:SizeX
    for j = 1:SizeY
        if Map(i,j) == 0
            RGBImage(i,j,:) = 1;
            continue
        end
        
        if Opinion(i,j) >= 0
            RGBImage(i,j,1) = Opinion(i,j);
        else
            RGBImage(i,j,3) = -Opinion(i,j);
        end
    end
end

figure
subplot(1,2,1)
image(RGBImage)
subplot(1,2,2)
image(round(RGBImage))

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
figure('Name', 'Initial State', 'NumberTitle','off')
imshow(mat2gray(InitOpinion), 'InitialMagnification', 'fit')
% figure('Name', 'Final State', 'NumberTitle','off')
% imshow(mat2gray(Opinion), 'InitialMagnification', 'fit')

end