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
 i=randi([2 5],1,1);%ѡһ����ʼstate
    while ( i~=1 && i~=6)%������1��6�ն�ʱ����һ��ѭ��
        if ex<rand(1)
        [ma,mb]=max(Q1(i,:));
        j=mb;
        else 
        j=randi([1 2],1,1);
        end                %������ѡ��action
        if ex<rand(1)
        [ma,mb]=max(Q1(i+L_R(j),:));
        jn=mb;
        else 
        jn=randi([1 2],1,1);
        end    
        Q1(i,j)=(Q1(i,j)+Lrate*(R(i,j)+0.5*Q1(i+L_R(j),jn)-Q1(i,j)));%Q-learning ��ʽ
        i=i+L_R(j);%�µ�state=��һ��state����action
    end     
    diff(n,k)=norm(Q1-Q);%����difference
end  
end
%% plot the difference
figure(1);
for n=1:5
plot(1:10000,diff(n,1:10000));
hold on
end
legend('Exploration �� = 0.01','Exploration �� = 0.03','Exploration �� = 0.05','Exploration �� = 0.1','Exploration �� = 0.5')
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
i=randi([2 5],1,1);%ѡһ����ʼstate
    while ( i~=1 && i~=6)%������1��6�ն�ʱ����һ��ѭ��
        if ex<rand(1)
        [ma,mb]=max(Q1(i,:));
        j=mb;
        else 
        j=randi([1 2],1,1);
        end                %������ѡ��action
        if ex<rand(1)
        [ma,mb]=max(Q1(i+L_R(j),:));
        jn=mb;
        else 
        jn=randi([1 2],1,1);
        end    
        Q1(i,j)=(Q1(i,j)+Lrate*(R(i,j)+0.5*Q1(i+L_R(j),jn)-Q1(i,j)));%Q-learning ��ʽ
        i=i+L_R(j);%�µ�state=��һ��state����action
    end     
    diff(n,k)=norm(Q1-Q);%����difference
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
title('Implement SARSA with exploration �� = 0.1');