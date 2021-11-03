function F=featToMAtrix(M2,fileinput2)
couple=load(fileinput2);
F=M2;
for i=1:size(couple,1)
    node_ID=couple(i,1);
    att_1=couple(i,2);
    F(1,node_ID)=att_1;
end
end