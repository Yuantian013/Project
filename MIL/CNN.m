%% 0.1 Clear Screen
close all
clc
clear all
%% 1.0 Load image
[im1,num1]=loadimage_MIL('sival_medal_tea/greenteabox');
[im2,num2]=loadimage_MIL('sival_medal_tea/goldmedal');
baglabel=ones(120,1);
baglabel(61:120)=2;
%% 1.1 Extract instances
width1=40;
width2=40;
[bags1,lab1,part1]=extractinstances(im1,width1);
[bags2,lab2,part2]=extractinstances(im2,width2);
%% 2.0 DATA & LABEL
data_cnn=gendatmilsival(bags_cnn1,bags_cnn2);
%% 2.1  Show bag id
bagid = getident(data_cnn,'milbag');
%% 3.1 Train & CV Assessment
[error_rate_bagcv,baglabel_bagcv]=bagcv(data_cnn,baglabel);
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% 4.0 MILES
MILES=bagembed(data_cnn,50);
DATA_MILES=prdataset(MILES,baglabel);
error=prcrossval(DATA_MILES,liknonc);
%% ------------------------------------------------------------------------
%% 5.0 NEW Algorithm
%% 5.1 Test
Bags1=feature_9(part_cnn1,im1);
Bags2=feature_9(part_cnn2,im2);
data_8=Bags1;
data_8(61:120,:)=Bags2;
data_8=prdataset(data_8,baglabel);
%% 5.2 Standard 
r_init=[[1,0,0,0,0,-1,0,0],[0,1,0,0,0,0,0,0]] ;%<---this is guessed value
% optimize
    gs=GlobalSearch;
    lb=-255*ones(1,16);
    ub=255*ones(1,16);
    options = optimoptions('fmincon'); 
    Aeq=[];
    beq=[]; %there is no constraints
    problem=createOptimProblem('fmincon','Aeq',Aeq,'beq',beq,'lb',lb,'objective',@optarget,...
    'options',options,'ub',ub,'x0',r_init);
    [x,~,~,~] = run(gs,problem);
    % optimization end
    target=x;