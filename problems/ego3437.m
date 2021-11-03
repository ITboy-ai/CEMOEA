function p = ego3437(p,dim)
p.name = 'ego3437';
p.pd = dim;
p.od =2;
p.domain = [zeros(1, dim); ones(1, dim)];
p.func   = @evaluate;

    function f = evaluate(w)
        edgefile = 'Fb3437_network.txt'; attributefile='Fb3437_attributes.txt';
        E=load(edgefile);      
        T = 262;%number of attribute
        M=size(E,1);
        N=max(max(E));
        M2=zeros(T,N);
        M3=featToMAtrixformultiattr(M2,attributefile);
        F=double(sparse(M3));
        distM=squareform(pdist(F','cosine'));
        adjM=zeros(N,N);
        for m=1:M
            u=E(m,1);
            v=E(m,2);
            adjM(u,v)=1;
            adjM(v,u)=1;
        end
        [A,A]=size(adjM);
        for i= 1: A
            M1(i,:)= w.*adjM(i,:);
            hchange(i,:) = sigmoid(M1(i,:));
            Prob(i,:)=softmax(hchange(i,:));
            maxp=max(Prob(i,:));
            vcindex=find(Prob(i,:)==maxp);
            if length(vcindex) == 1
                vc(i,1)=i;
                vc(i,2)=vcindex;
            else
                vc(i,1) = i;
                vc(i,2) = vcindex(1);
            end
        end
        clu_assignment = decode(vc(:,2)');
        f(1,:) = modularity(adjM,clu_assignment);
        f(2,:) = cossim(distM,clu_assignment);
        f = f';       
    end
end


