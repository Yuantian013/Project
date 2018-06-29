%% 0.1 Clear Screen
close all
clc
clear all
%% 1.0 Load image
[im1,num1]=loadimage_MIL('sival_apple_banana/banana');
[im2,num2]=loadimage_MIL('sival_apple_banana/apple');
% [im1,num1]=loadimage_MIL('sival_medal_tea/greenteabox');
% [im2,num2]=loadimage_MIL('sival_medal_tea/goldmedal');
baglabel=ones(120,1);
baglabel(61:120)=2;
%% ------------------------------------------------------------------------
%% 5.0 NEW Algorithm
%% 5.1 Test
Bags1=feature_0(part1,im1);
Bags2=feature_0(part2,im2);
data_8=Bags1;
data_8(61:120,:)=Bags2;
data_8=prdataset(data_8,baglabel);
%% CV
prcrossval(data_8,fisherc);
%% 5.2 Standard 
r_init=[[255,0,0],[255,255,0]] ;%<---this is guessed value
% optimize
    gs=GlobalSearch;
    lb=0*ones(1,6);
    ub=255*ones(1,6);
    options = optimoptions('fmincon'); 
    Aeq=[];
    beq=[]; %there is no constraints
    problem=createOptimProblem('fmincon','Aeq',Aeq,'beq',beq,'lb',lb,'objective',@optarget,...
    'options',options,'ub',ub,'x0',r_init);
    [x,~,~,~] = run(gs,problem);
    % optimization end
    target=x;