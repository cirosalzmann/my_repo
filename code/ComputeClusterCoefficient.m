function [ coefficient ] = ComputeClusterCoefficient( NeighbourMap )
    % computes the clustering coefficient of the neighbour map
    % (mean local clustering coefficient defined by Watts & Strogatz)
    % the algorithm computes the local coefficient for each cell and then
    % takes the overall average
    [sizeY sizeX d3 d4] = size(NeighbourMap);
    localCoefficients = zeros(sizeY, sizeX);
    for i = 1:sizeY
        for j = 1:sizeX
            neighbourCount = NeighbourMap(i, j, 1, 1);
            connectedCount = 0;
            % create a list of neighbours, where each neighbour has a
            % unique (onedimensional number) by enumerating the neighbours
            % row by row
            neighbours = squeeze(NeighbourMap(i, j, 2:(neighbourCount + 1), 1) - 1)  * sizeX  + squeeze(NeighbourMap(i, j, 2:(neighbourCount + 1), 2));
            for k = 1:neighbourCount
                neighbourY = NeighbourMap(i, j, k + 1, 1);
                neighbourX = NeighbourMap(i, j, k + 1, 2);
                otherNeighbourCount = NeighbourMap(neighbourY, neighbourX, 1, 1);
                % find mutual neighbours by intersecting the neighbour
                % list of the neighbour with the neighbour list of the
                % current examined node
                connectedCount = connectedCount + length(intersect(neighbours, squeeze(NeighbourMap(neighbourY, neighbourX, 2:(otherNeighbourCount + 1), 1) - 1)  * sizeX  + squeeze(NeighbourMap(neighbourY, neighbourX, 2:(otherNeighbourCount + 1), 2))));
            end
            % set the local coefficient for that cell
            localCoefficients(i, j) = connectedCount / max(neighbourCount * (neighbourCount - 1), 1);
        end
    end
    coefficient = mean(mean(localCoefficients));
end

