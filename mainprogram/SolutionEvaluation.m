%% Solution evaluation
function objvs=SolutionEvaluation(prob,pop)
[popSize,varDim]=size(pop);
objDim=prob.od;
objvs=zeros(popSize,objDim);
for i=1:popSize
    v=prob.func(pop(i,1:varDim));
    objvs(i,1:objDim)=v;
end
end