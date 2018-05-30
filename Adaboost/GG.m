clear all;
clc;
close all;
%% Generate data
A=gendatb(500);
Label=double((A.LABELS=='1'));
figure(1)
scatter(A.DATA(1:sum(Label),1),A.DATA(1:sum(Label),2));
hold on 
scatter(A.DATA(sum(Label)+1:500,1),A.DATA(sum(Label)+1:500,2));
legend('Class 1','Class 2')
%% Adaboost
times=100;
[AdaLabel]=adaboostplot(A.DATA,Label,times);
num=find(AdaLabel==Label);
Accuracy_Ada=size(num,1)/500
%% Normal
[bestFeature,threshold,type]=Set_DS(A.DATA,Label);
