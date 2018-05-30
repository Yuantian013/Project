clear all;
clc;
close all;
%% Generate data
class1=ones(100,2);
class1(:,1)=1:100;
class2=3*ones(100,2);
class2(:,1)=1:100;
class2(100,2)=-5;
class2(99,2)=-10;
weight1=ones(100,1);
weight2=ones(100,1);
weight2(100,1)=10000;
weight2(99,1)=10000;
%% Visulized data
figure(1);
scatter(class1(:,1),class1(:,2));
hold on
scatter(class2(:,1),class2(:,2));
%% Data build
data=zeros(200,2);
data(1:100,:)=class1;
data(101:200,:)=class2;
label=ones(200,1);
label(101:200,1)=0;
weight=zeros(200,1);
weight(1:100,1)=weight1;
weight(101:200,1)=weight2;
%% Train
[bestFeature,threshold,type]=Set_DSw(data,label,weight)
%%
y=ones(101,2);
y(:,1)=0:100;
y(:,2)=threshold;
plot(y(:,1),y(:,2),'-k');
legend('class1','class2','decision boundary')
%% Train
figure(2);
scatter(class1(:,1),class1(:,2));
hold on
scatter(class2(:,1),class2(:,2));
%% Train2
[bestFeature,threshold,type,accuracy]=Set_DS(data,label)
%%
y=ones(101,2);
y(:,1)=0:100;
y(:,2)=threshold;
plot(y(:,1),y(:,2),'--k');
legend('class1','class2','decision boundary')