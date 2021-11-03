function F=featToMAtrixformultiattr(M2,fileinput2)
couple=load(fileinput2);
F=M2;
couple(:,1) = [];
F = couple';
end