%% 0.1 Clear Screen
close all
clc
clear all
%% 0.2 Load data
semi_data=csvread('test.csv');
semi_label=csvread('label.csv');
train_data=prdataset(semi_data,semi_label);
data_info=csvread('train.csv');
data=data_info(:,2:205);
label=data_info(:,1);
data=prdataset(data,label);
%% add noise
noise_data=getdata(data);
for i=1:200
    noise_data(i,:)=noise_data(i,:)+normrnd(0,5,1,204);
end
noise_data=prdataset(noise_data,label);
%%
test_label=zeros(200,1);
idx=[1:200]';
for i=1:200
w=liknonc(data(find(idx~=i),:),2);
test_label(i)=data(i,:)*w*labeld;
test_label(i)
end
Error=sum(test_label~=label)/200;
%%
train_data=distm(data);
[LABELS, ~] = emclust(data,,2);
sum(LABELS~=label)/200