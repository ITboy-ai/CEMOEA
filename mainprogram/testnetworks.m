function p=testnetworks(problemName,pd,od)
% Define a structure 'p'
p = struct('name',[],'od',[],'pd',[],'domain',[],'func',[]);
%pd: dimension of the decision variable
switch lower(problemName)
    case 'polbooks'
        p=polbooks(p,pd);
    case 'ego3437'
        p= ego3437(p,pd);
    otherwise
        error('Undefined test problem name');
end
end