close all
clear
clc
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Description %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The simulation takes at each iteration one random agent on the grid
% (Opinion matrix)
% and assigns a new value based on probabilistic rules. For each randomly picked agent,
% it iterates through each possible neighbour and checks if it can influence the agent based on 
% its distance to the agent and its srength (which is also randomly assigned based on the probability
% density function defined by the user). After iterating through each neighbour, the new value of its
% opinion is randomly selected from the list containing all opinions of influencing neighbours.
% Note: If SizeX and SizeY are changed, delete OutputOpinion.txt and Strength.txt in PathName!!

% To start a new simulation only InitOpinion.png is needed! The path of the folder for the new simulation
% is defined by PathName
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Define Constants
tmax = 10000000; %Number of iterations (simulation time)
SizeX = 200; %X dimension of grid
SizeY = 200; %Y dimension of grid
maxRange = 3; %Maximum range that agents can reach others (Strength ranges from 1 to maxRange)
NumOutputs = 80; %Number of times the results are displayed and saved during simulation (evenly distributed along simulation time)
PathName = 'Inputs&Outputs\3_200_a6_SmallCircle'; %Path for folder where all input and output files are saved

%% Initialise (import all 3 Matrices needed to run simulation)
[Opinion, Strength, Map] = Initialise(SizeX,SizeY,maxRange-1, PathName); %maxRange-1
InitOpinion = Opinion; %Store initial opinion in InitOpinion
DispRGB(InitOpinion, Map); %Display initial opinion distribution
pause(0.0000000000000001); %Comment if results should be displayed only after end of simulation

%% Run Simulation
for t = 0:tmax
    
    %Pick random position in the grid
    RandX = round(rand*(SizeX-1)+1);
    RandY = round(rand*(SizeY-1)+1);
    List = []; %Arrray that includes neighbours from which current agent will randomly take one's opinion
    
    if Map(RandX, RandY) == 0
        %Empty coordinate
        continue
    end
    
    %Iterate through each possible neighbour of agent
    for i = -maxRange:maxRange
        for j = -maxRange:maxRange
            
            if RandX + i < 1 || RandX + i > SizeX || RandY + j < 1 || RandY + j > SizeY
                %Outside grid or empty coordinate
                continue
            end   
            
            DistToNode = sqrt(i*i + j*j); %Distance from n-th neighbour to current agent
            CurrStrength = Strength(RandX + i, RandY + j); %Strength of n-th neigbour
            CurrOpinion = Opinion(RandX + i, RandY + j); %Opinion of n-th neighbour
            CurrMap = Map(RandX + i, RandY + j); %If n-th neighbour is empty or not
            
            %Insert neighbours inside agent's range in calculation/List
            if CurrStrength >= DistToNode && CurrMap == 1
                List = [List, CurrOpinion];
            end
            
        end
    end
    
    if isempty(List)
        %If list is empty no value is assigned to current agent's opinion
        continue
    end
    
    %Assign new opinion for current agent picking a random neighbour in List
    Opinion(RandX, RandY) = List(round(rand*(length(List)-1)+1));

    %Display and export results in specific time intervals
    if t >= floor(tmax/NumOutputs) && rem(t/floor((tmax/NumOutputs)),1) == 0
        DispRGB(Opinion, Map);
        FileName = strcat(datestr(datetime('now'),30),'.png');
        imwrite(cat(3,mat2gray(Opinion),mat2gray(Opinion),mat2gray(Opinion)),fullfile(PathName,FileName));
        dlmwrite(fullfile(PathName,'OutputOpinion.txt'), Opinion);
        pause(0.00000000000001) %Comment if results should be displayed only after end of simulation
    end
end

%% Display and export ultimate opinion distribution
dlmwrite(fullfile(PathName,'OutputOpinion.txt'), Opinion);
DispRGB(Opinion, Map);
disp('Simulation Done!')