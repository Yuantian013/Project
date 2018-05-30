%% clear
clear all;
clc;
close all;
%% initialize 
alpha=0.5;
Q1=zeros(6,2);
Q2=zeros(6,2);
Qs=zeros(6,2);
Qold=zeros(6,2);
Q=[0,0;1,0.625;0.5,1.25;0.625,2.5;1.25,5;0,0];
R=[0,0;1,0;0,0;0,0;0,5;0,0];
L_R=[-1 1];
ex0=[0.1,0.3,0.5,0.7,0.9];
Lrate0=[0.1,0.3,0.5,0.7, 0.9];
%% Q-Iteration with different ex
Lrate=0.5;
ex=0.5;
for k=1:1000
    i=randi([2 5],1,1);%选一个初始state
    while ( i~=1 && i~=6)%当到达1或6终端时跳出一次循环
        rand_stay=rand;
        if ex<rand(1)
        [ma,mb]=max(Q1(i,:));
        j=mb;
        else 
        j=randi([1 2],1,1);
        end                %以上是选择action
        Q1(i,j)=0.5*Q1(i,j)+0.5*0.7*(R(i,j)+0.5*max(Q1(i+L_R(j),:)))+0.3*0.5*0.5*max(Q1(i,:));%Q-learning 公式
        i=i+L_R(j);%新的state=上一个state加上action
    end
diff(1,k)=norm(Q1-Q);%计算difference
end  
Q1
%% normal
for k=1:1000
    i=randi([2 5],1,1);%选一个初始state
    while ( i~=1 && i~=6)%当到达1或6终端时跳出一次循环
        if ex<rand(1)
        [ma,mb]=max(Q2(i,:));
        j=mb;
        else 
        j=randi([1 2],1,1);
        end                %以上是选择action
        Q2(i,j)=(Q2(i,j)+Lrate*(R(i,j)+0.5*max(Q2(i+L_R(j),:))-Q2(i,j)));%Q-learning 公式
        i=i+L_R(j);%新的state=上一个state加上action
    end
diff(2,k)=norm(Q2-Q);%计算difference
end  
%% plot the difference
figure(1);
plot(1:100,diff(1,1:100));
hold on
plot(1:100,diff(2,1:100));
legend('Broken','Normal')
xlabel('Iteration times')
ylabel('Difference')