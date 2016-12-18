function [opinions] = SetOpinions(map, candidateAFraction, pathName)
%setOpinions distributes opinions more or less randomly on the map
%   TODO
    [sizeX, sizeY] = size(map);
    opinions = zeros(sizeX, sizeY);
    votersTotal = sum(sum(map));
    candARemain = round(candidateAFraction * votersTotal);
    candBRemain = votersTotal - candARemain;
    for y = 1:sizeY
        for x = 1:sizeX
            if map(x, y) == 1
                r = rand;
                if r < candARemain / (candARemain + candBRemain)
                    opinions(x, y) = -1;
                    candARemain = candARemain - 1;
                else
                    opinions(x, y) = 1;
                    candBRemain = candBRemain - 1;
                end
            end
        end
    end
    fileName = fullfile(pathName, 'Opinions.txt');
    dlmwrite(fileName, opinions, 'delimiter', '\t');    
end

