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
[train_error,test_error]=adaboost_H(train_data,train_label,times,test_data,test_label);
%% Plot
figure(2)
plot(1:times,test_error(1:times))
hold on 
plot(1:times,train_error(1:times))
xlabel('Iteration times')
ylabel('Error rate')
legend("Test Error","Train Error")
