function [y] = edsim(distM,CCtemp)
y_sum =0;
yed=0;
nc = max(CCtemp);
for n = 1:nc
    listnodes = find(CCtemp(1,:)==n);
    ns= size(listnodes,2);
    p_sim=0;
    sim2=0;
    for i=1:ns-1
        n1=listnodes(1,i);
        index=i+1;
        while(index<=ns)
            n2=listnodes(1,index);
            dist=distM(n1,n2);
            p_sim=p_sim+dist;
            index=index+1;
        end
        sim2=sim2+2*p_sim;
        y_sum = y_sum+ns;
    end   
    yed=sim2+yed;
    y_sum=y_sum+(ns-1)*(ns-1);
end
y=yed/y_sum;
end