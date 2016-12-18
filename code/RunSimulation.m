function [finCandAFrac] = RunSimulation(Opinion, Map, NeighbourMap, Bought, tmax, outputLevel)
    % runs a simulation on the predefined network configuration
    % Opinion is the matrix with the opinion of the voter in each cell
    % Map is the matrix that defines if a voter exists in each cell
        % (1 if there is one, 0 if not)
    % Bought is the matrix that defines the stubbornness of the voters in
    	% each cell (1 if they are stubborn, 0 if not)
    % tmax is the number of iterations for the simulation
    % if outputLevel is set to 1, a plot with the total fractions of opions
        % is displayed,if it is 2, the video with the updates is shown

    [SizeY, SizeX] = size(Opinion);
    
    %Create plot of percentage of B
    votersTotal = sum(sum(Map));
    if outputLevel > 0
        opinionHistory = zeros(tmax + 2, 1);
        opinionHistory(1) = (((votersTotal + sum(sum(Opinion))) / 2) / votersTotal);
    end

    %Run Simulation
    for t = 0:tmax
        %Pick random position in the grid
        RandX = round(rand*(SizeX-1)+1);
        RandY = round(rand*(SizeY-1)+1);
        %List = []; %Arrray that includes neighbours from which current agent will randomly take one's opinion
        if Map(RandY, RandX) == 0 || Bought(RandY, RandX) == 1
            %Don't update this agent because it either doesn't exist or is
            %bought and won't change its opinion
           continue 
        end
        
        neighboursCount = NeighbourMap(RandY, RandX, 1, 1);

        if neighboursCount == 0
           continue 
        end
        randNeighbour = floor(rand * neighboursCount) + 2;  % select random neighbour from list
        Opinion(RandY, RandX) = Opinion(NeighbourMap(RandY, RandX, randNeighbour, 1), NeighbourMap(RandY, RandX, randNeighbour, 2));
        %Update opinion history
        if outputLevel > 0
            opinionHistory(t + 2) = (((votersTotal + sum(sum(Opinion))) / 2) / votersTotal);
            if outputLevel > 1 && mod(t, 1000) == 0
                DispRGB(Opinion, Map);
                pause(0.00000000000001);
            end
        end
    end
    if outputLevel > 0
        plot(opinionHistory);
    end
    finCandAFrac = (((votersTotal + sum(sum(Opinion))) / 2) / votersTotal);
end

