function [ y ] = cossim(distM, clu_assignment)
sim2 = 0;
p_sim = 0;
y_sum =0;
ycos = 0;
clu_num = max(clu_assignment);
 for i =1:clu_num
    s_index = find(clu_assignment == i);
    s_cardinality = length(s_index);   
    for j= 1: s_cardinality-1
        n1 = s_index(1,j);
        index = j+1;
        while(index <=s_cardinality)
            n2 = s_index(1,index);
            dist = distM(n1,n2);
            p_sim = p_sim+dist;
            index = index+1;
        end
        sim2=sim2+p_sim;
        y_sum = y_sum+s_cardinality;
    end
    ycos = sim2+ycos;
    y_sum=y_sum+s_cardinality*(s_cardinality-1);
end
y=ycos/y_sum;
end
