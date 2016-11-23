function [] = DispRGB(Opinion, Map)

[SizeX, SizeY] = size(Opinion);
RGBImage = zeros(SizeX, SizeY, 3);
RGBAbsolute = zeros(SizeX, SizeY, 3);

%Create RGB Image
for i = 1:SizeX
    for j = 1:SizeY
        if Map(i,j) == 0
            RGBImage(i,j,:) = 1;
            RGBAbsolute(i,j,:) = 1;
            continue
        end
        
        if Opinion(i,j) >= 0
            RGBImage(i,j,1) = Opinion(i,j);
            RGBAbsolute(i,j,1) = 0.7;
        else
            RGBImage(i,j,3) = -Opinion(i,j);
            RGBAbsolute(i,j,3) = 0.7;
        end
    end
end

%Print RGB Image
figure
image(RGBImage)

% figure('Name','Final State','units','normalized','outerposition',[0 0 1 1])
% subplot(1,2,1)
% image(RGBImage)
% subplot(1,2,2)
% image(RGBAbsolute)

end