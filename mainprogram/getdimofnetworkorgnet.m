function dim  = getdimofnetworkorgnet(edgefile)       
        E=load(edgefile);
        dim=max(max(E));
end