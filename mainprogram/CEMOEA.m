function [RCluster,pop,objValfinal,Dens_merged,Entr_merged]= CEMOEA(probName,edgefile,fileattributes,T,varDim,objDim,maxGens)
[M1] = edgesToadj(edgefile);
M=sparse(M1);
numberOfVariables = size(M,1);
M2=zeros(T,numberOfVariables);
M3=featToMAtrix(M2,fileattributes);  %For single-attribute network
%M3=featToMAtrixformultiattr(M2,fileattributes);  %For multi-attribute network
popSize = 100;
F=0.7;
CR=0.5;
prob=testnetworks(probName,varDim,objDim);%set the problem
[pop,objVals]=Initialization(prob,popSize);% Generate initial population
bounds=prob.domain;
pm=0.02;                                % Mutation probability
parents=zeros(3,varDim);
FrontValue = NonDominateSort(objVals,0);
CrowdDistance = CrowdDistances(objVals,FrontValue);
for  gen=1:maxGens
    disp(sprintf('%d',gen));
    MatingPool = Mating(pop,FrontValue,CrowdDistance);
    for  indi = 1:size(MatingPool, 1)
        parents(3,1:varDim)=MatingPool(indi,:);
        idx=randsample(size(MatingPool, 1),2);
        parents(1:2,1:varDim)=MatingPool(idx,1:varDim);
        trialSol(indi,:) = DECrossover(parents,bounds,F,CR);
        Offspring(indi,:)=PolynomialMutation(trialSol(indi,:),bounds,pm); %PM
    end
    pop = [pop;Offspring];
    objVals=SolutionEvaluation(prob,pop);
    [FrontValue,MaxFront] = NonDominateSort(objVals,1);
    CrowdDistance = CrowdDistances(objVals,FrontValue);
    Next = zeros(1,popSize);
    NoN = numel(FrontValue,FrontValue<MaxFront);
    Next(1:NoN) = find(FrontValue<MaxFront);
    Last = find(FrontValue==MaxFront);
    [~,Rank] = sort(CrowdDistance(Last),'descend');
    Next(NoN+1:popSize) = Last(Rank(1:popSize-NoN));
    pop = pop(Next,:);
    FrontValue = FrontValue(Next);
    CrowdDistance = CrowdDistance(Next);   
end
 objValfinal=SolutionEvaluation(prob,pop);
 pop(:,numberOfVariables+1:varDim)=[];
%%decode 
for ii = 1:popSize
    sigma = pop(ii,:);
    for j = 1: numberOfVariables
        Mr(j,:)= sigma.*M1(j,:);
        hrchange(j,:) = sigmoid(Mr(j,:));
        rProb(j,:)=softmax(hrchange(j,:));
        rmaxp=max(Mr(j,:));%
        rvcindex=find(Mr(j,:)==rmaxp);
        if length(rvcindex) == 1
            rvc(j,1)=j;
            rvc(j,2)=rvcindex;
        else
            rvc(j,1) = j;
            rvc(j,2) = rvcindex(1);
        end     
    end
    CCresult={};
    clu_assignment = decode(rvc(:,2)');
    numComm = max(clu_assignment);
    for nC = 1:numComm
        nodeindex = find(clu_assignment(1,:)==nC);
        CCresult{nC} = nodeindex;
    end
    RCluster{ii,1} = CCresult;  
    Density_merged=computeDensity(RCluster{ii,1},M1);
    Entropy_merged=computeEntropy(RCluster{ii,1},M1,M3);
    result(ii,1)=Density_merged;
    result(ii,2)=Entropy_merged;
end
[Dens_merged]=max(result(:,1));
[Entr_merged]=min(result(:,2));
end