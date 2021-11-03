function density= computeDensity(CC,M)
numEdges=sum(sum(M(:,:)))/2;
density=0;
for k=1:size(CC,2) %  
    %ls is the number of edges joining nodes of the community
    listnodes=CC{k};
    ls=(sum(sum(M(listnodes,listnodes))))/2;
    density=density + ls./numEdges;
end
end
