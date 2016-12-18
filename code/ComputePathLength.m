function [ pathlength ] = ComputePathLength( NeighbourMap )
    %computes the average path length in the network, i. e. the average of
    %the path lengths between each pair of nodes, using the dijkstra
    %algorithm
    [sizeY sizeX d3 d4] = size(NeighbourMap);
    pathlengths = zeros(sizeY, sizeX);
    for i = 1:sizeY
        for j = 1:sizeX
            distances = zeros(sizeY, sizeX);
            distances(:) = sizeX * sizeY;
            distances(i, j) = 0;
            completed = zeros(sizeY, sizeX);
            nodeList = [i; j];
            disp([i, j]);
            while size(nodeList, 2) > 0
                minNode = 0;
                minDistance = sizeX * sizeY;
                for k = 1:size(nodeList, 2)
                    if (distances(nodeList(k)) < minDistance)
                        minNode = k;
                        minDistance = distances(nodeList(k));
                    end
                end
                nodeY = nodeList(1, k);
                nodeX = nodeList(2, k);
                nodeList(:,k) = [];
                neighbourCount = NeighbourMap(nodeY, nodeX, 1, 1);
                for k = 1:neighbourCount
                    neighbourY = NeighbourMap(nodeY, nodeX, k + 1, 1);
                    neighbourX = NeighbourMap(nodeY, nodeX, k + 1, 2);
                    if (completed(neighbourY, neighbourX) == 0 && distances(nodeY, nodeX) + 1 < distances(neighbourY, neighbourX))
                        distances(neighbourY, neighbourX) = distances(nodeY, nodeX) + 1;
                        nodeList = [nodeList, [neighbourY; neighbourX]];
                    end
                end
                completed(nodeY, nodeX) = 1;
            end
            distancesWithoutSelf = distances(distances~=0);
            pathlengths(i, j) = mean(distancesWithoutSelf(distancesWithoutSelf~=(sizeX * sizeY)));
        end
    end
    pathlength = nanmean(nanmean(pathlengths));
end

