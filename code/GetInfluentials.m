function [influentials] = GetInfluentials(strengthMap)
%returns the positions of the most influential agents
%   takes the strength map as input, returns a matrix with 3 columns, where
%   first column contains the strength of the agent,
%   second column contains the y position (row) of the agent
%   third column contains the x position (column) of the agent
    [sizeX, sizeY] = size(strengthMap);
    influentials = [(1:(sizeX * sizeY))', strengthMap(:)];
    influentials = flip(sortrows(influentials, 2));
    influentials = [influentials(:,2), (mod((influentials(:,1) - 1), sizeX) + 1), ceil(influentials(:,1) ./ sizeX)];
end

