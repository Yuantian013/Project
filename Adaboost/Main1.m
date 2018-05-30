clear all;
clc;
close all;
%% Importdata
Tr_data=importdata('traindata.txt');
Te_data=importdata('testdata.txt');
train_data=Tr_data(:,1:9);
train_label=Tr_data(:,10);
test_data=Te_data(:,1:9);
test_label=Te_data(:,10);
num=(train_label==-1);
train_label(num)=0;
num=(test_label==-1);
test_label(num)=0;
%% Regularization
% [m,n]=size(train_data); 
% for i=1:n  
%     A(1,i)=norm(train_data(:,i));  
% end  
% A=repmat(A,m,1);  
% train_data=train_data./A;
% %
% [m1,n1]=size(test_data); 
% for i=1:n1 
%     B(1,i)=norm(test_data(:,i));  
% end  
% B=repmat(B,m1,1);  
% test_data=test_data./B;  
%% Train
[bestStump,threshold,type,Right]=Set_DS(train_data,train_label)
Right
%% Test
testLabel=Decision_stump(test_data,bestStump,threshold,type);
num=find(testLabel==test_label);
Accurancy=size(num,1)/1000