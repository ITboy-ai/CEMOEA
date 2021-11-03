function [mat] = edgesToadj(fileinput)
couple = load(fileinput);
for i=1:size(couple,1)
    mat(couple(i,1),couple(i,2)) = 1;
    mat(couple(i,2),couple(i,1)) = 1;  
end
numRow=size(mat,1);
for i=1:numRow
    mat(i,i) = 0;
end
end