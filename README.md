# CEMOEA
This code is part of the program that produces the results in the following paper:
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Jianyong Sun, Wei Zheng, Qingfu Zhang, Zongben Xu, "Graph neural network encoding for community detection in attribute networks", IEEE Transactions on Cybernetics, Early Access, 2021, doi:10.1109/TCYB.2021.3051021.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
There are two example networks in this project: Polbooks[1] and Ego 3437[2].

When you run the main.m, you need to do the following two steps:
1. Be sure that your Matlab has installed the Parallel Computing Toolbox, otherwise, you need to modify the code. 
2. Change the code (line 6 or line 7) in the PBNetNSGAII.m function according to the kind of attribute network.

If you want to test other attribute networks,  you need to do the following three steps:
1. Input the information of the attribute networks in the main.m. 
2. Add the new function of your own networks, such as polbooks.m in the folder named as 'problems'. 
3. Add the new test networks in the testnetworks.m function.
 
[1] V. Krebs, "Books about US politics," unpublished, http://www.orgnet.com, 2004.
[2] J. Leskovec and J. J. Mcauley, "Learning to discover social circles in ego networks," in Advances in neural information processing systems, 2012, pp. 539-547.

Contact me: zhengshu56@126.com
