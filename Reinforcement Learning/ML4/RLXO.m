%% clear
clear all;
clc;
close all;
%% initialize 
alpha=0.5;
Lrate=0.5;
ex=0.5;
L_R=[-1 1];
Q1=zeros(6,2);
n=101;
ThetaL=zeros(1,n)';
ThetaR=zeros(1,n)';
QQ=[0,0;1,0.625;0.5,1.25;0.625,2.5;1.25,5;0,0];
oe=[0.03,0.05,0.1,0.3,0.5,0.7,1];
num=5000;
ne=[6,11,101,1001];
%normrnd(0,0.01)
%% Q-Learning
for ttt=1:4
    n=ne(ttt);
for t=1:7
    o=oe(t); 
    ThetaL=zeros(1,n)';
    ThetaR=zeros(1,n)';
for k=1:num
    i=4*rand+1.5;
%     i=randi([2,5],1,1);
    while ( i>1.5 && i<=5.5)   
%         if  i<=1.5
%             j=2;
%         elseif i>5.5
%             j=1;
%         else
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
%         norm=exp(-((i-1)^2)/(2*o))+exp(-((i-2)^2)/(2*o))+exp(-((i-3)^2)/(2*o))+exp(-((i-4)^2)/(2*o))+exp(-((i-5)^2)/(2*o))+exp(-((i-6)^2)/(2*o));
%         RBF=[exp(-((i-1)^2)/(2*o))/norm,exp(-((i-2)^2)/(2*o))/norm,exp(-((i-3)^2)/(2*o))/norm,exp(-((i-4)^2)/(2*o))/norm,exp(-((i-5)^2)/(2*o))/norm,exp(-((i-6)^2)/(2*o))/norm]';
        if j==1
        ThetaL=ThetaL+Lrate*(R+alpha*max(Q(ThetaL,n,rbfn),Q(ThetaR,n,rbfn))-Q(ThetaL,n,rbf))*rbf;
        elseif j==2
        ThetaR=ThetaR+Lrate*(R+alpha*max(Q(ThetaL,n,rbfn),Q(ThetaR,n,rbfn))-Q(ThetaR,n,rbf))*rbf;
        end 
        i=i+step;
    end
    for jj=1:6
    Q1(jj,1)=Q(ThetaL,n,RBF(jj,n,o));
    Q1(jj,2)=Q(ThetaR,n,RBF(jj,n,o));
    end 
    distance(t,k)=norm(Q1-QQ);
end 
end
%% Plot
figure(1);
subplot(2,2,ttt)
for t=1:7
    plot(1:num,distance(t,1:num))
    hold on 
end 
title(['number of neurons=',num2str(ne(ttt))])
legend('o=0.03','o=0.05','o=0.1','o=0.3','o=0.5','o=0.7','o=1')
xlabel('Iteration times')
ylabel('Difference')
end