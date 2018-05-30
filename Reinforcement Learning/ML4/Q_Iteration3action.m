%exercise 5
%agent has some probability to stay
clear all
clc
close all
%% perform Q-iteration
gamma=0.5;
S=1:6;      % states
pi=zeros(1,6); % policy
A=[-1,1];   % actions
r=[1 0 0 0 0 5];    % rewards
Q=zeros(2,6);       % state-action value function
Q1=zeros(2,6); 
P1=0.3;
P2=1-P1;
for iter=1:10000      % iteration times
    for i=2:5  % loop for all states
        for j=1:size(A,2) % loop for all actions
           s_t=S(i);        % current state
           s_tp1=s_t+A(j);  % next state
           r_tp1=r(s_tp1);  % reward for the action
           r_t=r(s_t);
           %---------update value function as a weigted average---------------
           Q(j,i)=P2*(r_tp1+gamma*max(Q(:,s_tp1)))+P1*(gamma*max(Q(:,s_t))); 
        end
    end
    if Q-Q1==0
        iter
        break;
    else
    Q1=Q;
    end
        
end
Q
