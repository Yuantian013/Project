clear all;
clc;
close all;
%% Importdata
data=importdata('optdigitsubset.txt');
train_label=ones(100,1);
train_label(51:100,1)=-1;
test_label=ones(1025,1);
test_label(505:1025,1)=-1;
train_data=zeros(100,64);
test_data=zeros(1025,64);
%% Training data
for i=1:100
a=1:554;
K=randperm(length(a));
N=50;
tr1=a(K(1:N))';
train_data(1:50,:)=data(tr1,:);
a=555:1125;
K=randperm(length(a));
N=50;
tr2=a(K(1:N))';
train_data(51:100,:)=data(tr2,:);
%% Test data
all1=1:554;
te1 = setdiff(all1,tr1');
all2=555:1125;
te2 = setdiff(all2,tr2');
test_data(1:504,:)=data(te1',:);
test_data(505:1025,:)=data(te2',:);
%% Train
[bestFeature(i),threshold(i),sign(i),accuracy(i)]=Set_DS(train_data,train_label);
%% Test
testLabel=Decision_stump(test_data,bestFeature(i),threshold(i),sign(i));
num=find(testLabel==test_label);
Test_accuracy(i)=size(num,1)/1025;
end
%% Result
error=1-Test_accuracy;
mean=mean(error);
min=min(error);
max=max(error);
std=std(error,1)