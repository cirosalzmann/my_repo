# MATLAB Fall 2014 – Research Plan (Template)

> * Group Name: Turbinos
> * Group participants names: Thomas Leu, Théophile Messin-Roizard, Ciro Salzmann
> * Project Title: Modeling and simulating different strategies for winning an election

(Alternative Titelvorschläge: Strategies to get the most votes; Investigation (of factors influencing opinion formation) of dynamic opinion and how to effectively bring the average opinion distribution of a society/community to your advantage. )

## General Introduction

How can you persuade a large group of people to agree with you? The answer to this question might be interesting for almost anybody, but particularly marketing agents and politicians. We would like to find a possible answer to it in the context of the U.S. presidential elections, which are a very current but also recurring event.

In order to do so, we define different, (hopefully) realistic strategies for getting votes and see how effective each strategy is compared to the others.

## The Model

Our model will be a mix of the models described in “Influentials, Networks, and Public Opinion Formation” (Watts and Dodds 2007) and “Interplay between media and social influence in the collective behavior of opinion dynamics” (Colaiori and Castellano 2015), which in turn are both based on the voter model (Holley and Liggett 1975).

We examine a binary model (candidate A vs candidate B) which makes the model a lot simpler. In reality, there are more than two presidential candidates, but we can treat votes for other candidates the same as when someone doesn’t vote at all.

The influence of the media and the constant communication between nearby individuals are two key factors in the opinion formation, which are modeled in (Colairoi and Castellano 2015).

Not each neighbour will have the same influence on someone. For instance, family members might tend to have similar political views. What’s more, even two neighbours, that are in the same community may have a different level of influence. Both aspects are modeled in (Watts and Dodds 2007).

The above mentioned works different network topologies 


(The different individuals, in our case nodes, will not be directly linked. This means that one specific node would not be influenced only by other nodes directly linked to him, but by all existing nodes. The probability or how strong its influence will be is dependent to the distance with each node (it may or may not vary linearly))  

dependences of the model:
-the number of agents (mindsetters) for/ against
-their strength of persuasion
-their disposition (will two agents reach more people together, in a same area, or dispatched)
-the density of population
-the links between the members of this test-population 
-correlation between political opinions and communities
-the scale (the world/ a country/ a town/ a suburb) 
-the input of the general evolution of vote statistics over time, actualising our model in a specific way.

One problem is that the model would not include all ways of reaching individuals, since they would be mostly influenced by nearby neighbours. Other ways such as Internet, TV and social media, which play an important role nowadays, are indirectly implemented, e.g. using parameters.

## Fundamental Questions

Which strategies for gaining last minute support and getting out the vote are more effective than others?
How to best reach people in order to, for example, win a presidential Election?
How to reach a maximum of people? (with the fewest actors)
Who should be the target individuals? Common voters or more influential people?
how fast will a community react on an foreign opinion?
Which strategy is better, reaching the maximum amount of people or focus on people with higher influence?


## Expected Results

(What are the answers to the above questions that you expect to find before starting your research?)

Being more than one actor influencing a specific population area might work out better but being too many of those won’t probably help any longer. (the efficiency of each actor will drop quite quickly.)
It is expected that there will be a convergence in the opinion as time goes to infinity. (Since in reality there is no infinite time scale, the simulation will run for a specific time depending on what is being investigated)


## References 

Influentials, Networks, and Public Opinion Formation - DUNCAN J. WATTS and PETER SHERIDAN DODDS, 2007
Interplay between media and social influence in the collective behavior of opinion dynamics - FRANCESCA COLAIORI and CLAUDIO CASTELLANO, 2015
Ergodic theorems for weakly interacting infinite systems and the voter model - RICHARD A. HOLLEY and THOMAS M. LIGGETT, 1975. 

## Research Methods

Voter model, cellular automata


## Other

>* Curve of the evolution of the Hilary/ Trump vote prognostics over time


