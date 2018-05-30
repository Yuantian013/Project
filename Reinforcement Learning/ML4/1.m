%% clear
clear all;
clc;
close all;
%% initialize 
alpha=0.5;
Q1=zeros(6,2);
Qs=zeros(6,2);
Qold=zeros(6,2);
index=0;
Q=[0,0;1,0.625;0.5,1.25;0.625,2.5;1.25,5;0,0];
R=[0,0;1,0;0,0;0,0;0,5;0,0];
L_R=[-1 1];
ex0=[0.01,0.03,0.05,0.1,0.5];
Lrate0=[0.01,0.03,0.05,0.1,0.5];
%% Q-Iteration with different ex
Lrate=0.1;
for n=1:5
    Q1=Qold;
    ex=ex0(n);
for k=1:10000
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
    diff(n,k)=norm(Q1-Q);%计算difference
end  
end
%% plot the difference
figure(1);
for n=1:5
plot(1:10000,diff(n,1:10000));
hold on
end
legend('Exploration ε = 0.01','Exploration ε = 0.03','Exploration ε = 0.05','Exploration ε = 0.1','Exploration ε = 0.5')
xlabel('Times of iteration');
ylabel('Difference');
title('Implement SARSA with learning rate = 0.1');
%% Q-Iteration with different Learing rate
ex=0.1;
for n=1:5
    Q1=Qold;
    Lrate=Lrate0(n);
    m=1;
for k=1:10000
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
    diff(n,k)=norm(Q1-Q);%计算difference
end 
end 
%% plot the difference
figure(2);
for n=1:5
plot(1:10000,diff(n,1:10000));
hold on
end
legend('Learning rate = 0.01','Learning rate = 0.03','Learning rate = 0.05','Learning rate = 0.1','Learning rate = 0.5')
xlabel('Times of iteration');
ylabel('Difference');
title('Implement SARSA with exploration ε = 0.1');