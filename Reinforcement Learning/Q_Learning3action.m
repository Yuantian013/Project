%%exercise 5
%agent has some probability to stay
clear all
clc

%% perform Q-learning method
gamma=0.5; % set gamma's value
ebsilon=1; % set the probability for exploitation(this value would better >0.5)
iter=10000; % <--------number of loops
r=[1 0 0 0 0 5]; % set the rewards 
S=1:6; % set the states
A=[-1 1];
s=2; % <-------initialize state
dist=zeros(iter,3);
P1=0.3;
s=2; % <-------initialize state
Q1=zeros(2,6);  % initialize value function
Q=[0,0;1,0.625;0.5,1.25;0.625,2.5;1.25,5;0,0]';
alphan=[0.01,0.05,0.1,0.3,0.5]; % set learning rate
for ai=1:5
    alpha=alphan(ai);
    Q1=zeros(2,6);
for i=1:iter
    rand_stay=rand; % whether to stay
            if s~=1&&s~=size(S,2)  
             % ------randomly doing exploration------
                rand_num=rand; 
                    if rand_num<ebsilon
                        % choose a random action
                        indx_a=rand;
                        a=A((indx_a>0.5)+1);
                        %-----------------------
                        if a==-1
                            indx=1;
                        else
                            indx=2;
                        end
                        if rand_stay<P1
                            s_next=s;
                        else
                        s_next=s+a;
                        end
                        reward=r(s_next);
                        max_Q_next=max(Q1(:,s_next));
                            Q1(indx,s)=Q1(indx,s)+alpha*(reward+gamma*max_Q_next-Q1(indx,s)); %update value functions
                            s=s_next;% update state
                    
                %-------doing "optimal" action ------
                    else
                        [max_Q,row]=max(Q1(:,s),[],1);
                         a=A(row);
                           if rand_stay<P1
                            s_next=s;
                        else
                        s_next=s+a;
                        end
                         reward=r(s_next);
                         max_Q_next=max(Q1(:,s_next));
                            Q1(row,s)=Q1(row,s)+alpha*(reward+gamma*max_Q_next-Q1(row,s)); %uodate value function
                            s=s_next; % update state
                    end
                %-----return by chance at the terminal--------
            else
                s=randi([2 5],1,1); % random initializing
            end
            diff(ai,i)=norm(Q1-Q);%¼ÆËãdifference
end
end

figure(1);
for n=1:5
plot(1:10000,diff(n,1:10000));
hold on
end
legend('Learning rate = 0.01','Learning rate = 0.05','Learning rate = 0.1','Learning rate = 0.3','Learning rate = 0.5')
xlabel('Times of iteration');
ylabel('Difference');
