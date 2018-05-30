clear all;
clc;
close all;
%% Importdata
A=gendatb(1100);
[train,test] = gendat(A,0.2);
train_label=double((train.LABELS=='1'));
test_label=double((test.LABELS=='1'));
%% Adaboost_class
times=100;
Adaboost=adaboost_ini(train.DATA,train_label,test.DATA,test_label,times);
[Label,Accurancy]=Ada_classifier(Adaboost);
%%
[Para,Beta]=adaboost_para(train.DATA,train_label,times);
AdaLabel=zeros(size(test_label,1),1);
Thre=0;
%-------------------Calculate the sum of Label and Threshold--------------%
for i=1:times
    Label=Decision_stump(test.DATA,Para(i).bestFeature,...
    Para(i).threshold,Para(i).type);
    AdaLabel=AdaLabel+log(1/Beta(i))*Label;
    Thre=Thre+0.5*log(1/Beta(i));
end
%--------------------------Output the hypothesis--------------------------%
Label(AdaLabel>=Thre)=1;
Label(AdaLabel<Thre)=0;
Accuracy_Ada=sum(Label==test_label,1)/size(test_label,1);
%% Normal
[bestFeature,threshold,type]=Set_DS(train.DATA,train_label);
Label=Decision_stump(test.DATA,bestFeature,threshold,type);
Accuracy_Nor=sum(Label==test_label,1)/size(test_label,1);