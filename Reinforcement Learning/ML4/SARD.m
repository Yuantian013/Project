%% clear
clear all;
clc;
close all;
%% initialize 
alpha=0.5;
Lrate=0.1;
ex=0.5;
L_R=[-1 1];
Q1=zeros(6,2);
QQ=[0,0;1,0.625;0.5,1.25;0.625,2.5;1.25,5;0,0];
R=[0,0;1,0;0,0;0,0;0,5;0,0];
num=10000;
%normrnd(0,0.01)
%% Q-Learning
for k=1:num
    i=randi([2 5],1,1);%选一个初始state
    while ( i~=1 && i~=6)%当到达1或6终端时跳出一次循环
        if ex<rand(1)
        [ma,mb]=max(Q1(i,:));
        j=mb;
        else 
        j=randi([1 2],1,1);
        end                %以上是选择action
        Q1(i,j)=(Q1(i,j)+Lrate*(R(i,j)+0.5*max(Q1(i+L_R(j),:))-Q1(i,j)));%Q-learning 公式
        i=i+L_R(j);%新的state=上一个state加上action
    end     
        diff(1,k)=norm(Q1-QQ);%计算difference
end  
%% Sarsa
Q1=zeros(6,2);
for k=1:num
    i=randi([2 5],1,1);%选一个初始state
    while ( i~=1 && i~=6)%当到达1或6终端时跳出一次循环
        if ex<rand(1)
        [ma,mb]=max(Q1(i,:));
        j=mb;
        else 
        j=randi([1 2],1,1);
        end                %以上是选择action
        if ex<rand(1)
        [ma,mb]=max(Q1(i+L_R(j),:));
        jn=mb;
        else 
        jn=randi([1 2],1,1);
        end    
        Q1(i,j)=(Q1(i,j)+Lrate*(R(i,j)+0.5*Q1(i+L_R(j),jn)-Q1(i,j)));%Q-learning 公式
        i=i+L_R(j);%新的state=上一个state加上action
    end     
        diff(2,k)=norm(Q1-QQ);%计算difference
end  
%% Plot
figure(1);
for t=1:2
    plot(1:num,diff(t,1:num))
    hold on 
end 
legend('Q-learning','SARSA','TD(lamda)')
xlabel('Iteration times')
ylabel('Difference')