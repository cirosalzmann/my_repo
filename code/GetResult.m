function [avgNeighbours, clusterCoeff] = GetResult(runs, sizeX, sizeY, maxRange, tmax, showFigures, saveFigures, getNetworkProperties, getResultByPersons, useNormalDistribution)
    % this is the main function used to run different simulations
    % runs is the size of the statistical ensemble
    % sizeX and sizeY give the grid size (= number of agents) in both
    % tmax is the number of iterations in the simulation
    % if showFigures is set to true, the created figures will show up on the screen
    % if saveFigures is set to true, the created figures will be saved in a fig file
    % if getNetworkProperties is set to true, the average outgoing
        % neighbour degree and the clustering coefficient are computed and
        % returned, if it is set to false, the two returned values will be 0
        % it might make sense to not always compute these in order to save
        % computation time

    %set global random stream to make reproducable results
    s = RandStream('mt19937ar', 'Seed', 42);
    RandStream.setGlobalStream(s);
    reset(s);

    %Define Constants
    pathNameI = 'Inputs'; %Path for folder where all input files are stored
    pathNameO = 'Outputs'; %Path for folder where all input files are stored

    avgNeighbours = zeros(1, runs);
    clusterCoeff = zeros(1, runs);
    
    %set normal distribution prefix for file saving
    normalDistPrefix = '';
    if useNormalDistribution
        normalDistPrefix = 'normal_';
    end

    parfor run = 1:runs
        % run simulations in parallel to make use of all cores
        % save results of each run in csv files, which are merged after all
        % runs have finished

        %Initialise (import all 3 Matrices needed to run simulation)
        [Opinion, Strength, Map] = Initialise(sizeX, sizeY, maxRange, pathNameI, useNormalDistribution);
        %Create map of neighbours
        NeighbourMap = zeros(sizeX, sizeY, 4 * ceil(maxRange * maxRange) + 2, 2);
        agentCount = 0;
        neighbourSum = 0;
        for y = 1 : sizeY
            for x = 1 : sizeX
                if Map(y, x) == 0
                   continue
                end
                neighbours = zeros(0);
                agentCount = agentCount + 1;
                listIndex = 2; % create list of neighbours for agent at (y, x), reserve first field for neighbour count
                for i = -ceil(maxRange):ceil(maxRange)
                    for j = -ceil(maxRange):ceil(maxRange)
                        % wrap the borders
                        neighbourY = y + i;
                        if neighbourY < 1
                            neighbourY = sizeY + neighbourY;
                        end
                        if neighbourY > sizeY
                            neighbourY = mod(neighbourY, sizeY);
                        end
                        neighbourX = x + j;
                        if neighbourX < 1
                            neighbourX = sizeX + neighbourX;
                        end
                        if neighbourX > sizeX
                            neighbourX = mod(neighbourX, sizeX);
                        end
                        if neighbourY == y && neighbourX == x
                            continue; %don't add ourselves as neighbours
                        end
                        distToNode = sqrt(i*i + j*j); %Distance from i-th neighbour to current agent
                        if Strength(neighbourY, neighbourX) >= distToNode && Map(neighbourY, neighbourX) == 1
                            neighbours = [neighbours, (neighbourY - 1) * sizeX + neighbourX];
                            NeighbourMap(y, x, listIndex, :) = [neighbourY; neighbourX];
                            listIndex = listIndex + 1;
                            neighbourSum = neighbourSum + 1;
                        end
                    end
                end
                NeighbourMap(y, x, 1, 1) = listIndex - 2; % set count of neighbours in the first field
            end
        end

        if getNetworkProperties
            avgNeighbours(run) = neighbourSum / agentCount;
            clusterCoeff(run) = ComputeClusterCoefficient(NeighbourMap);
        end

        %Get the agents sorted by descending influence
        agentsByInfluence = GetInfluentials(Strength);
        %Shuffle agents randomly
        agentsRandom = sortrows([agentsByInfluence, rand(size(agentsByInfluence, 1), 1)], 4);
        agentsRandom = agentsRandom(:, 1:3);

        %Test up to 10% of all agents
        maxBought = floor((sizeX * sizeY) / 10);
        %Test 100 variations
        boughtStep = floor(maxBought / 100);

        votesByBoughtPersonsTargeted = zeros(0, 2);
        votesByBoughtPersonsUntargeted = zeros(0, 2);
        votesByBoughtStrengthTargeted = zeros(0, 2);
        votesByBoughtStrengthUntargeted = zeros(0, 2);
        for b = 0:boughtStep:maxBought
            %Stragety 1 : Buy most influential agents
            Bought = zeros(sizeX, sizeY);
            boughtNeighbourSum = 0;
            for i = 1:b
               Bought(agentsByInfluence(i, 2), agentsByInfluence(i, 3)) = 1;
               boughtNeighbourSum = boughtNeighbourSum + NeighbourMap(agentsByInfluence(i, 2), agentsByInfluence(i, 3), 1, 1);
            end
            resultTargeted = RunSimulation(Opinion .* ~Bought + Bought, Map, NeighbourMap, Bought, tmax, 0);
            votesByBoughtStrengthTargeted = [votesByBoughtStrengthTargeted; [(boughtNeighbourSum / neighbourSum) resultTargeted]];
            votesByBoughtPersonsTargeted = [votesByBoughtPersonsTargeted; [(b / agentCount), resultTargeted]]; 
            %Strategy 2: Buy random agents
            Bought = zeros(sizeX, sizeY);
            boughtNeighbourSum = 0;
            for i = 1:b
               Bought(agentsRandom(i, 2), agentsRandom(i, 3)) = 1;
               boughtNeighbourSum = boughtNeighbourSum + agentsRandom(i, 1);
            end
            resultUntargeted = RunSimulation(Opinion .* ~Bought + Bought, Map, NeighbourMap, Bought, tmax, 0);
            votesByBoughtStrengthUntargeted = [votesByBoughtStrengthUntargeted; [(boughtNeighbourSum / neighbourSum) resultUntargeted]];
            votesByBoughtPersonsUntargeted = [votesByBoughtPersonsUntargeted; [(b / agentCount), resultUntargeted]]; 
        end
        % write partial results to csv files
        csvwrite(strcat('tmp_', int2str(run), '_targeted.csv'), votesByBoughtStrengthTargeted);
        csvwrite(strcat('tmp_', int2str(run), '_untargeted.csv'), votesByBoughtStrengthUntargeted);
        csvwrite(strcat('tmp_', int2str(run), '_persons_targeted.csv'), votesByBoughtPersonsTargeted);
        csvwrite(strcat('tmp_', int2str(run), '_persons_untargeted.csv'), votesByBoughtPersonsUntargeted);
        close;
        disp(strcat('Run ', int2str(run), '/', int2str(runs), ' finished.'));
    end
    h = figure();
    hold on; 
    % combine partial results
    targetedResults = CombineResults(runs, '_targeted.csv');
    untargetedResults = CombineResults(runs, '_untargeted.csv');
    plot(targetedResults(:, 1), mean(targetedResults(:, 2:end), 2)', 'r', 'Linewidth', 2);
    if runs > 1
        plot(targetedResults(:, 1), mean(targetedResults(:, 2:end), 2)' + std(targetedResults(:, 2:end)'), 'r');
        plot(targetedResults(:, 1), mean(targetedResults(:, 2:end), 2)' - std(targetedResults(:, 2:end)'), 'r');
    end
    plot(untargetedResults(:, 1), mean(untargetedResults(:, 2:end), 2)', 'g', 'Linewidth', 2);
    if runs > 1
        plot(untargetedResults(:, 1), mean(untargetedResults(:, 2:end), 2)' + std(untargetedResults(:, 2:end)'), 'g');
        plot(untargetedResults(:, 1), mean(untargetedResults(:, 2:end), 2)' - std(untargetedResults(:, 2:end)'), 'g');
    end
    xlabel('fraction of bought agents degrees ');
    ylabel('fraction of agents holding opinion B after simulation');
    xlim([0, 0.05]);
    ylim([0, 1]);
    if saveFigures
       savefig(h, fullfile(pathNameO, char(strcat(string(normalDistPrefix), string(maxRange), '_', string(tmax), '.fig'))));
    end
    if ~showFigures
        close(h);
    end
    if getResultByPersons
        h2 = figure();
        hold on;
    	targetedResults = CombineResults(runs, '_persons_targeted.csv');
    	untargetedResults = CombineResults(runs, '_persons_untargeted.csv');
        plot(targetedResults(:, 1), mean(targetedResults(:, 2:end), 2)', 'r', 'Linewidth', 2);
        if runs > 1
            plot(targetedResults(:, 1), mean(targetedResults(:, 2:end), 2)' + std(targetedResults(:, 2:end)'), 'r');
            plot(targetedResults(:, 1), mean(targetedResults(:, 2:end), 2)' - std(targetedResults(:, 2:end)'), 'r');
        end
        plot(untargetedResults(:, 1), mean(untargetedResults(:, 2:end), 2)', 'g', 'Linewidth', 2);
        if runs > 1
            plot(untargetedResults(:, 1), mean(untargetedResults(:, 2:end), 2)' + std(untargetedResults(:, 2:end)'), 'g');
            plot(untargetedResults(:, 1), mean(untargetedResults(:, 2:end), 2)' - std(untargetedResults(:, 2:end)'), 'g');
        end
        xlabel('fraction of bought agents');
        ylabel('fraction of agents holding opinion B after simulation');
        xlim([0, 0.1]);
        ylim([0, 1]);
        if saveFigures
           savefig(h2, fullfile(pathNameO, char(strcat(string(normalDistPrefix), string(maxRange), '_', string(tmax), '_persons.fig'))));
        end
        if ~showFigures
            close(h2);
        end
    end
    avgNeighbours = mean(avgNeighbours);
    clusterCoeff = mean(clusterCoeff);
end

