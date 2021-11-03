% Author:     Wei Zheng
% School of Mathematics and Statistics, Xi'an Jiaotong University.
% EMAIL:      zhengshu56@126.com
% DATE:       March 2021
% ------------------------------------------------------------------------
% This code is part of the program that produces the results in the following paper:
% Jianyong Sun, Wei Zheng, Qingfu Zhang, Zongben Xu, Graph neural network encoding for community detection in attribute networks, IEEE Transactions on Cybernetics, Early Access, 10.1109/TCYB.2021.3051021.
% You are free to use it for non-commercial purposes. However, we do not offer any forms of guanrantee or warranty associated with the code. We would appreciate your acknowledgement.
% ------------------------------------------------------------------------
function main
objDim = [2];
nObj=length(objDim);
maxGens= [100];
Maxg =length(maxGens);
probName = {'polbooks'};
probNum =size(probName, 2);
edgefile = {'polbooks_network.txt'};
fileattributes = {'polbooks_gt.txt'};
[varDim] = getdimofnetworkorgnet('polbooks_network.txt');
T=[3];
% probName = {'ego3437'};
% probNum =size(probName, 2);
% edgefile = {'Fb3437_network.txt'};
% fileattributes = {'Fb3437_attributes.txt'};
% [varDim] = getdimofnetworkorgnet('Fb3437_network.txt');
% T=[262];

for gen=1:Maxg
    for obj=1:nObj
        for i=1:probNum
            Calculation(probName{i},edgefile{i},fileattributes{i},T(i),varDim(i),objDim(obj),maxGens(gen));
        end
    end
end
end
function prob=Calculation(probName,edgefile,fileattributes,T,varDim,objDim,maxGens)
runTimes = 3;
moea = 'NSGA-II';
workerNum = 4; % The number of labs
spmd
    prob=testnetworks(probName,varDim,objDim);%set the problem
    for j= 1:runTimes
        addpath('D:\CEMOEA public\mainprogram');
        [CC,pop,objValfinal,Dens_merged,Entr_merged] = CEMOEA(probName,edgefile,fileattributes,T,varDim,objDim,maxGens);
        rmpath('D:\CEMOEA public\mainprogram');
        prob.PBNet.Clu(j,1) = {CC};
        prob.PBNet.pop(j,1) = {pop};
        prob.PBNet.fobj(j,1) = {objValfinal};
        prob.PBNet.D(j,1) = {Dens_merged};
        prob.PBNet.E(j,1) = {Entr_merged};
    end   
end
fun = prob{1};
for i = 2:workerNum
    temFun = prob{i};
    fun.PBNet.Clu = [fun.PBNet.Clu; temFun.PBNet.Clu];
    fun.PBNet.pop = [fun.PBNet.pop; temFun.PBNet.pop];
    fun.PBNet.fobj = [fun.PBNet.fobj; temFun.PBNet.fobj];
    fun.PBNet.D = [fun.PBNet.D; temFun.PBNet.D];
    fun.PBNet.E = [fun.PBNet.E; temFun.PBNet.E];
end
prob = fun;
runT=num2str(runTimes*workerNum);
save(['D:\phd work\mywork2 attribute community detection one paper\CEMOEA public\results\', ['CEMOEA',probName,'_run',runT,'_',moea,'.mat']],'prob');

end