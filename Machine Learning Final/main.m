%% 0.1 Clear Screen
close all
clc
clear all
%% 0.2 Load data
semi_data=csvread('test.csv');
semi_label=csvread('label.csv');
semi=prdataset(semi_data,semi_label);
test_data=prdataset(semi_data,semi_label);
%% 0.3 KMEANS Initialized
X =semi_data;
opts = statset('Display','final','MaxIter',500);
[~, ctrs] = kmeans(X, 2,'Replicates',2000, 'Options',opts);
%% 0.4 Improve 
Result=improve_c(semi_data,data,ctrs,10);
%% 1.1 Add noise
data_info=csvread('train.csv');
data=data_info(:,2:205);
label=data_info(:,1);
data=prdataset(data,label);
noise_data=getdata(data);
for i=1:200
    noise_data(i,:)=noise_data(i,:)+normrnd(0,1,1,204);
end
noise_data=prdataset(noise_data,label);
%% 1.2 test
new_data=data;
%%
w=liknonc(new_data,0.1);
svm_label=[];
svm_label=getdata(test_data*w);
x_new1=find(svm_label(:,1)>0.8);
x_new2=find(svm_label(:,2)>0.8);
old_data=getdata(new_data);
old_label=getlab(new_data);
old_data(end+1:end+size(x_new1,1),:)=test_data(x_new1,:);
old_label(end+1:end+size(x_new1,1),:)=1;
old_data(end+1:end+size(x_new2,1),:)=test_data(x_new2,:);
old_label(end+1:end+size(x_new2,1),:)=2;
new_data=prdataset(old_data,old_label);
test_data([x_new1;x_new2],:)=[];
%% Self-Benchmark
w=fitcsvm(getdata(data),getlab(data));
w1=liknonc(data);
svml1_label=semi_data*w1*labeld;
[svml2_label,score]=predict(w,semi_data);
km_label=dis_test(semi,Result(2).Center);
a=intersect(find(svml2_label==km_label),find(svml1_label==km_label));
% sum(svm_label1~=svm_label2)
%%