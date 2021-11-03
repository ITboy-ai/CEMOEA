function entropy= computeEntropy(CC,M,M_att)
numNodes=size(M,1);
numAttribvalues=max(max(M_att));
entropy=0;
for k=1:size(CC,2) %  
    %ls is the number of edges joining nodes of the community
    listnodes=CC{k};
    numNodes_comm=size(listnodes,2);
    entropy_k=0;
    for a=1:numAttribvalues
        numNodes_att_a=size(find(M_att(:,listnodes)==a),2);
        p_ak=numNodes_att_a/numNodes_comm;
        if(p_ak>0)
            entropy_k=entropy_k-p_ak*log(p_ak);
        end
    end
    entropy=entropy + entropy_k*numNodes_comm/numNodes;
end
end