%% 0.1 Clear Screen
close all
clc
clear all
%% 0.2 Load data
data_info=csvread('train.csv');
data=data_info(:,2:205);
label=data_info(:,1);
semi_data=csvread('test.csv');
data=prdataset(data,label);
semi_label=csvread('label.csv');
%% 0.4 KMEANS 13.5% 标准化无效 已测试
[m,n]=size(semi_data);  
for i=1:n  
    A(1,i)=norm(semi_data(:,i));  
end  
A=repmat(A,m,1);  
semi_data=semi_data./A; 
X =semi_data;
opts = statset('Display','final','MaxIter',500);
[~, ctrs] = kmeans(X, 2,'Replicates',2000, 'Options',opts);
%% 1.1 Classify
norm_data=norm_ml(data);
Y =getdata(norm_data);
c_label=zeros(200,1);
for i=1:200
    dis1=norm(Y(i,:)-ctrs(1,:));
    dis2=norm(Y(i,:)-ctrs(2,:));
    if dis1>dis2
        c_label(i)=1;
    else 
        c_label(i)=2;
    end
end
sum(c_label~=label)/200
%% 1.2 Distance SINGLE
for i=1:20000
    distance_1=norm(semi_data(i,:)-Result(2).Center(1,:));
    distance_2=norm(semi_data(i,:)-Result(2).Center(2,:));
    if distance_1<distance_2
        DIS(i)=distance_1;
    else 
        DIS(i)=distance_2;
    end
end
[~,out1]=sort(DIS);
num1=out1(1:18000);
%% 1.3 Distance double
for i=1:20000
    distance_1=norm(semi_data(i,:)-Result(2).Center(1,:));
    distance_2=norm(semi_data(i,:)-Result(2).Center(2,:));
    DIS(i)=abs(distance_1-distance_2);
end
[~,out2]=sort(DIS);
num2=out2(2000:20000);
num=intersect(num1,num2);
%%
c_label=zeros(size(num,2),1);
train_data=semi_data(num,:);
for i=1:size(num,2)
    dis1=norm(train_data(i,:)-Result(17).Center(1,:));
    dis2=norm(train_data(i,:)-Result(17).Center(2,:));
    if dis1>dis2
        c_label(i)=2;
    else 
        c_label(i)=1;
    end
end
% train_data=prdataset([train_data;getdata(data(1:10,:));getdata(data(191:200,:))],[c_label;label(1:10);label(191:200)]);

train_data=prdataset(train_data,c_label);
%%
w=liknonc(train_data);
% show1=getdata(data*w);
%%
test_label=data*w*labeld;
sum(test_label~=label)/200
%%
w=liknonc(data);
show=getdata(data*w);