%% clear
clear all;
clc;
close all;
%% initialize 
alpha=0.5;
Lrate=0.9;
ex=0.1;
L_R=[-1 1];
QQ=[0,0;1,0.625;0.5,1.25;0.625,2.5;1.25,5;0,0];
o=1;
num=10000;
n=2;
%normrnd(0,0.01)
%% Q-Iteration 2
    ThetaL=zeros(1,n)';
    ThetaR=zeros(1,n)';
for k=1:num
%     i=4*rand+1.5;
    i=randi([2,5],1,1);
    while ( i>1.5 && i<=5.5)   
        rbf=RBF2(i,o);
        [j,step]=STEP(ex,Q(ThetaL,n,rbf),Q(ThetaR,n,rbf));
        if i+step<=1.5
           R=1;
        elseif i+step>5.5
           R=5;
        else 
           R=0;
        end
        rbfn=RBF2(i+step,o);
%         norm=exp(-((i-1)^2)/(2*o))+exp(-((i-2)^2)/(2*o))+exp(-((i-3)^2)/(2*o))+exp(-((i-4)^2)/(2*o))+exp(-((i-5)^2)/(2*o))+exp(-((i-6)^2)/(2*o));
%         RBF=[exp(-((i-1)^2)/(2*o))/norm,exp(-((i-2)^2)/(2*o))/norm,exp(-((i-3)^2)/(2*o))/norm,exp(-((i-4)^2)/(2*o))/norm,exp(-((i-5)^2)/(2*o))/norm,exp(-((i-6)^2)/(2*o))/norm]';
        if j==1
        ThetaL=ThetaL+Lrate*(R+alpha*max(Q(ThetaL,n,rbfn),Q(ThetaR,n,rbfn))-Q(ThetaL,n,rbf))*rbf;
        elseif j==2
        ThetaR=ThetaR+Lrate*(R+alpha*max(Q(ThetaL,n,rbfn),Q(ThetaR,n,rbfn))-Q(ThetaR,n,rbf))*rbf;
        end 
        i=i+step;
    end
end
for j=1:6
Q3(j,1)=Q(ThetaL,n,RBF2(j,o));
Q3(j,2)=Q(ThetaR,n,RBF2(j,o));
end
Q3
%% Plot
figure(1);
    for st=1:401
    Q1(st)=Q(ThetaL,n,RBF2(1.5+0.01*(st-1),o));
    Q2(st)=Q(ThetaR,n,RBF2(1.5+0.01*(st-1),o));
    end 
    for st=1:401
        steppp(st)=1.5+0.01*(st-1);
    end
    plot(steppp,Q1)
    hold on
    plot(steppp,Q2)
    legend('Q-left','Q-right')
    xlabel('state')
    ylabel('Q-value')