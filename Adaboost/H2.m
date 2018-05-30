clear all;
clc;
close all;
%% Importdata
data=importdata('optdigitsubset.txt');
label=ones(1125,1);
label(555:1125,1)=0;
%% Training data
train_data=zeros(100,64);
train_data(1:50,:)=data(1:50,:);
train_data(51:100,:)=data(555:604,:);
train_label=ones(100,1);
train_label(51:100,1)=0;
%% Test data
test_data=zeros(1025,64);
test_data(1:504,:)=data(51:554,:);
test_data(505:1025,:)=data(605:1125,:);
test_label=ones(1025,1);
test_label(505:1025,1)=0;
%% Adaboost
times=100;
[Para,Beta]=adaboost_para(train_data,train_label,times);
AdaLabel=zeros(size(test_label,1),1);
Thre=0;
test_error=zeros(times,1);
for i=1:times
    Label=Decision_stump(test_data,Para(i).bestFeature,...
    Para(i).threshold,Para(i).type);
    AdaLabel=AdaLabel+log(1/Beta(i))*Label;
    Thre=Thre+0.5*log(1/Beta(i));
    Label(AdaLabel>=Thre)=1;
    Label(AdaLabel<Thre)=0;
    num_test=Label~=test_label;
    test_error(i)=sum(num_test)/size(test_data,1);
end
%% Plot
figure(2)
plot(1:times,test_error(1:times))
