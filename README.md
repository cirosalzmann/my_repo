# MATLAB 2016 – Research Plan

> * Group Name: Turbinos
> * Group participants names: Thomas Leu, Théophile Messin-Roizard, Ciro Salzmann
> * Project Title: Modeling and simulating different strategies for winning an election


## General Introduction

How can you persuade a large group of people to agree with you? The answer to this question might be interesting for almost anybody, but particularly marketing agents and politicians. We would like to find a possible answer to it in the context of the U.S. presidential elections, which are a very current but also recurring event.

In order to do so, we define different, (hopefully) realistic strategies for getting votes and see how effective each strategy is compared to the others.


## The Model

Our model will be a mix of the models described in “Influentials, Networks, and Public Opinion Formation” (Watts and Dodds 2007) and “Interplay between media and social influence in the collective behavior of opinion dynamics” (Colaiori and Castellano 2015), which in turn are both based on the voter model (Holley and Liggett 1975).

We examine a binary model (candidate A vs candidate B) which makes the model a lot simpler. In reality, there are more than two presidential candidates, but we can treat votes for other candidates the same as when someone doesn’t vote at all.

The influence of the media and the constant communication between nearby individuals are two key factors in the opinion formation, which are modeled in (Colairoi and Castellano 2015).

Not each neighbour will have the same influence on someone. For instance, family members might tend to have similar political views. What’s more, even two neighbours, that are in the same community may have a different level of influence. Both aspects are modeled in (Watts and Dodds 2007).

The above mentioned works investigate different network topologies. Our approach will be a little different: We will try to find a specific, realistic network topology for the spreading of the opinions about the presidential candidates inside the U.S. population. This includes e. g. the density of agents, the correlation between communities and political opinions and the disposition of the influence between neighbours.

Then we define different strategies to influence the opinions, like trying to get the media bias to your favor, get the most influential people to vote for you, get a large group of people in different communities to vote for you, get many of the undecided people to vote for you etc.

For each of the defined strategies and for different initial configurations (e.g. 40% candidate A, 40% candidate B, 20% undecided or 50% candidate A, 40% candidate B, 10% undecided) we simulate the configuration after a limited period of time. We would like at least one of this configurations to reflect a state of the opinions in the U.S. elections 2016. Note that because we are starting with agents already holding different opinions, we need to make an assumption on their disposition (the disposition should be in line with the previously stated correlation between communities and political opinions).


## Fundamental Questions

Which strategies for gaining last minute support and getting out the vote are more effective than others?
Is it more effective to address people by media or by word-to-mouth advertisement?
Which strategy is better, trying to reach a maximum amount of people or focus on people with higher influence?


## Expected Results

Generally, we expect it to be better to reach more people, even if they have fewer influence.
If we assume a higher correlation between the communities and the opinions, it will be harder to change the average opinion of a single community and might need more than one agent as initiator to trigger a cascade of changes that leads to the opposite average opinion in that community.
We expect the influence of the media to be smaller than that of the social network.
It will be hard to identify what a feasible strategy is in terms of concrete numbers, e.g. the numbers of agents that we can get to adapt our opinion at some time. 


## References 

>* 1. Influentials, Networks, and Public Opinion Formation - DUNCAN J. WATTS and PETER SHERIDAN DODDS, 2007
>* 2. Interplay between media and social influence in the collective behavior of opinion dynamics - FRANCESCA COLAIORI and CLAUDIO CASTELLANO, 2015
>* 3. Ergodic theorems for weakly interacting infinite systems and the voter model - RICHARD A. HOLLEY and THOMAS M. LIGGETT, 1975. 

## Research Methods

>* Voter model
>* Cellular automata


## Other

>* Curve of the evolution of the Hilary/Trump vote prognostics over time


