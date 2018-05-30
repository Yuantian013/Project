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
%% Train
[bestFeature,threshold,sign,accuracy]=Set_DS(train_data,train_label);
bestFeature
threshold
sign
accuracy
%% Test
testLabel=Decision_stump(test_data,bestFeature,threshold,sign);
num=find(testLabel==test_label);
Test_accuracy=size(num,1)/1025