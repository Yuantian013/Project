clear all;
clc;
close all;
%% Generate data
A=gendatb(1000);
Label=double((A.LABELS=='1'));
figure(1)
scatter(A.DATA(1:sum(Label),1),A.DATA(1:sum(Label),2));
hold on 
scatter(A.DATA(sum(Label)+1:1000,1),A.DATA(sum(Label)+1:1000,2));
legend('Class 1','Class 2')
%% Adaboost
times=4;
[AdaLabel]=adaboost_para(A.DATA,Label,times);
num=find(AdaLabel==Label);
Accuracy_Ada=size(num,1)/1000
%% Normal
[bestFeature,threshold,type,Accuracy_Normal]=Set_DS(A.DATA,Label);
Accuracy_Normal
