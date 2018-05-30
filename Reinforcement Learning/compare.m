%% clear
clear all;
clc;
close all;
%% initialize 
alpha=0.5;
Lrate=0.5;
ex=0.5;
L_R=[-1 1];
QQ=[0,0;1,0.625;0.5,1.25;0.625,2.5;1.25,5;0,0];
o=0.1;
num=100;
stt=1;
OP=[0;1;2;2;2;0];
%normrnd(0,0.01)
%% Q-Iteration 4
n=4;
    ThetaL=zeros(1,n)';
    ThetaR=zeros(1,n)';
    
    Q3=zeros(6,2);
    Policy=zeros(6,1);
for k=1:num
%     i=4*rand+1.5;
    i=randi([2,5],1,1);
    while ( i>1.5 && i<=5.5)   
        rbf=RBF4(i,o);
        [j,step]=STEP(ex,Q(ThetaL,n,rbf),Q(ThetaR,n,rbf));
        if i+step<=1.5
           R=1;
        elseif i+step>5.5
           R=5;
        else 
           R=0;
        end
        rbfn=RBF4(i+step,o);
%         norm=exp(-((i-1)^2)/(2*o))+exp(-((i-2)^2)/(2*o))+exp(-((i-3)^2)/(2*o))+exp(-((i-4)^2)/(2*o))+exp(-((i-5)^2)/(2*o))+exp(-((i-6)^2)/(2*o));
%         RBF=[exp(-((i-1)^2)/(2*o))/norm,exp(-((i-2)^2)/(2*o))/norm,exp(-((i-3)^2)/(2*o))/norm,exp(-((i-4)^2)/(2*o))/norm,exp(-((i-5)^2)/(2*o))/norm,exp(-((i-6)^2)/(2*o))/norm]';
        if j==1
        ThetaL=ThetaL+Lrate*(R+alpha*max(Q(ThetaL,n,rbfn),Q(ThetaR,n,rbfn))-Q(ThetaL,n,rbf))*rbf;
        elseif j==2
        ThetaR=ThetaR+Lrate*(R+alpha*max(Q(ThetaL,n,rbfn),Q(ThetaR,n,rbfn))-Q(ThetaR,n,rbf))*rbf;
        end 
        i=i+step;
    end
    for j=2:5
    Q3(j,1)=Q(ThetaL,n,RBF4(j,o));
    Q3(j,2)=Q(ThetaR,n,RBF4(j,o));
    end
    for j=2:5
        if Q3(j,1)>Q3(j,2)
           Policy(j)=1;
        else 
           Policy(j)=2; 
        end 
    end 
    diff(1,k)=norm(Policy-OP)%º∆À„difference
end
Policy
%% Q-Iteration 6
n=6;
    ThetaL=zeros(1,n)';
    ThetaR=zeros(1,n)';
        Q3=zeros(6,2);
         Policy=zeros(6,1);
for k=1:num
%     i=4*rand+1.5;
    i=randi([2,5],1,1);
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
%         norm=exp(-((i-1)^2)/(2*o))+exp(-((i-2)^2)/(2*o))+exp(-((i-3)^2)/(2*o))+exp(-((i-4)^2)/(2*o))+exp(-((i-5)^2)/(2*o))+exp(-((i-6)^2)/(2*o));
%         RBF=[exp(-((i-1)^2)/(2*o))/norm,exp(-((i-2)^2)/(2*o))/norm,exp(-((i-3)^2)/(2*o))/norm,exp(-((i-4)^2)/(2*o))/norm,exp(-((i-5)^2)/(2*o))/norm,exp(-((i-6)^2)/(2*o))/norm]';
        if j==1
        ThetaL=ThetaL+Lrate*(R+alpha*max(Q(ThetaL,n,rbfn),Q(ThetaR,n,rbfn))-Q(ThetaL,n,rbf))*rbf;
        elseif j==2
        ThetaR=ThetaR+Lrate*(R+alpha*max(Q(ThetaL,n,rbfn),Q(ThetaR,n,rbfn))-Q(ThetaR,n,rbf))*rbf;
        end 
        i=i+step;
    end
        for j=2:5
    Q3(j,1)=Q(ThetaL,n,RBF(j,n,o));
    Q3(j,2)=Q(ThetaR,n,RBF(j,n,o));
        end
        
        for j=2:5
        if Q3(j,1)>Q3(j,2)
           Policy(j)=1;
        else 
           Policy(j)=2; 
        end 
    end 
    diff(2,k)=norm(Policy-OP);%º∆À„difference
end 
%% Plot
figure(1);
for n=1:2
plot(1:100,diff(n,1:100));
hold on
end
legend('4 neurons','6 neurons')
xlabel('Times of iteration');
ylabel('Difference');