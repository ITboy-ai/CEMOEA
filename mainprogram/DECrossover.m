function offsSol=DECrossover(parents,bounds,F,CR)
%%
varDim=size(parents,2);
% The third individual included in parents is the central solution
offsSol=parents(3,1:varDim);
jrand=randsample(varDim,1);
for i=1:varDim
    rnd=rand;
    if (rnd<CR)||(i==jrand)
        value=parents(3,i)+F*(parents(1,i)-parents(2,i));
        if value<bounds(1,i)
            value=bounds(1,i);
            % value=parents(3,i)-rand*(parents(3,i)-bounds(1,i));
        elseif value>bounds(2,i)
            value=bounds(2,i);
            % value=parents(3,i)+rand*(bounds(2,i)-parents(3,i));
        end
        offsSol(1,i)=value;
    end
end
end