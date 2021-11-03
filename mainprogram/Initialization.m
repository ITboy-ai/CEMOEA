%% Initialization population, variable : w
function [pop,objVals]=Initialization(prob,popSize)
lowend =prob.domain(1,:);
span=prob.domain(2,:)-lowend;
pop=rand(popSize,prob.pd).*(span(ones(popSize,1),:))+lowend(ones(popSize,1),:);
objVals=SolutionEvaluation(prob,pop);
end