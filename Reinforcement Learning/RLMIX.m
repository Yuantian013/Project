%% clear
clear all;
clc;
close all;
%% initialize 
alpha=0.5;
Lrate=0.5;
ex=0.05;
L_R=[-1 1];
Q1=zeros(6,2);
n=101;
o=0.0002;
QQ=[0,0;1,0.625;0.5,1.25;0.625,2.5;1.25,5;0,0];
num=10000;
lambda=0.1;
%normrnd(0,0.01)
%% Q-Learning
    ThetaL=zeros(1,n)';
    ThetaR=zeros(1,n)';
for k=1:num
%     i=randi([2,5],1,1);
    i=4*rand+1.5;
    while ( i>1.5 && i<=5.5)   
        rbf=RBF(i,n,o);
        [j,step]=STEP(ex,Q(ThetaL,n,rbf),Q(ThetaR,n,rbf));
        if i+step<=1.5
           R=1;
        elseif i+step>5.5
           R=5;
        else 
           R=0;
        end
        rbfn=RBF(i+step,n,o);
        if j==1
        ThetaL=ThetaL+Lrate*(R+alpha*max(Q(ThetaL,n,rbfn),Q(ThetaR,n,rbfn))-Q(ThetaL,n,rbf))*rbf;
        elseif j==2
        ThetaR=ThetaR+Lrate*(R+alpha*max(Q(ThetaL,n,rbfn),Q(ThetaR,n,rbfn))-Q(ThetaR,n,rbf))*rbf;
        end 
        i=i+step;
    end
    for j=1:6
    Q1(j,1)=Q(ThetaL,n,RBF(j,n,o));
    Q1(j,2)=Q(ThetaR,n,RBF(j,n,o));
    end 
    distance(1,k)=norm(Q1-QQ);
end 
Q1
%% Sarsa
    ThetaL=zeros(1,n)';
    ThetaR=zeros(1,n)';
for k=1:num
%     i=randi([2,5],1,1);
    i=4*rand+1.5;
    while ( i>1.5 && i<=5.5)   
        rbf=RBF(i,n,o);
        [j,step]=STEP(ex,Q(ThetaL,n,rbf),Q(ThetaR,n,rbf));
        if i+step<=1.5
           R=1;
        elseif i+step>5.5
           R=5;
        else 
           R=0;
        end
        rbfn=RBF(i+step,n,o);
        [jn,stepn]=STEP(ex,Q(ThetaL,n,rbfn),Q(ThetaR,n,rbfn));
        if (j==1 && jn==1)
        ThetaL=ThetaL+Lrate*(R+alpha*Q(ThetaL,n,rbfn)-Q(ThetaL,n,rbf))*rbf;
        elseif (j==1 && jn==2)
        ThetaL=ThetaL+Lrate*(R+alpha*Q(ThetaR,n,rbfn)-Q(ThetaL,n,rbf))*rbf; 
        elseif (j==2 && jn==1)
        ThetaR=ThetaR+Lrate*(R+alpha*Q(ThetaL,n,rbfn)-Q(ThetaR,n,rbf))*rbf;
        elseif (j==2 && jn==2)
        ThetaR=ThetaR+Lrate*(R+alpha*Q(ThetaR,n,rbfn)-Q(ThetaR,n,rbf))*rbf; 
        end 
        i=i+step;
    end
    for jj=1:6
    Q1(jj,1)=Q(ThetaL,n,RBF(jj,n,o));
    Q1(jj,2)=Q(ThetaR,n,RBF(jj,n,o));
    end 
    distance(2,k)=norm(Q1-QQ);
end 
%% Plot
figure(2);
    for st=1:501
    Q3(st)=Q(ThetaL,n,RBF(1+0.01*(st-1),n,o));
    Q4(st)=Q(ThetaR,n,RBF(1+0.01*(st-1),n,o));
    end 
    for st=1:501
        steppp(st)=1+0.01*(st-1);
    end
    plot(steppp,Q3)
    hold on
    plot(steppp,Q4)
    legend('Q-left','Q-right')
    xlabel('state')
    ylabel('Q-value')

%% Plot
figure(1);
for t=1:2
    plot(1:num,distance(t,1:num))
    hold on 
end 
legend('Q-learning','SARSA')
xlabel('Iteration times')
ylabel('Difference')