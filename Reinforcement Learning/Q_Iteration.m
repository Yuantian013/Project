%% clear
clear all;
clc;
close all;
%% initialize 
alpha=0.5;
Q1=zeros(6,2);
Qs=zeros(6,2);
R=[0,0;1,0;0,0;0,0;0,5;0,0];
L_R=[-1 1];
Q=[0,0;1,0.625;0.5,1.25;0.625,2.5;1.25,5;0,0];
%% Q-Iteration
for k=1:5
for i=2:5
    for j=1:2
          Q1(i,j)=R(i,j)+alpha*max(Qs(i+L_R(j),:));
    end
end
Qs=Q1;
Qs
end
%% PI
for i=1:6
    PI(i)=max(Q1(i,:));
end