clear all;
clc;
close all;
%%  Generate data 1
n=500;             
mu=[0 0]; 
Sigma=[1,0;0,1]; 
class_1=mvnrnd(mu,Sigma,n); 
%% Generate data 2 
n=500;             
mu=[2 0]; 
Sigma=[1,0;0,1]; 
class_2=mvnrnd(mu,Sigma,n); 
%% Scatterplot
figure(1);
scatter(class_1(:,1),class_1(:,2));
hold on
scatter(class_2(:,1),class_2(:,2));
hold off
legend('mu=[0 0]','mu=[2 0]')
xlabel('Feature 1')
ylabel('Feature 2')
%% Date & Label
data(1:n,:)=class_1;
data(n+1:2*n,:)=class_2;
label=ones(2*n,1);
label(n+1:2*n,1)=0;
%% Train
[bestStump,threshold,type]=Set_DS(data,label);
bestStump
threshold
type
%% Rescaling 
figure(2);
data2=data;
data2(:,1)=10*data2(:,1);
scatter(data2(:,1),data2(:,2));
%% Train
[bestStump,threshold,type]=Set_DS(data2,label);
bestStump
threshold
type
