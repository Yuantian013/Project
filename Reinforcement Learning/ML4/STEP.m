function [j,step]=STEP(ex,Q1,Q2)
        if ex<rand(1)
        if Q1>Q2
           j=1;
        elseif Q1<Q2
           j=2;
        elseif Q1==Q2
        j=randi([1 2],1,1);
        end
        else 
        j=randi([1 2],1,1);
        end
        if j==1
           step=-1+normrnd(0,0.01);
        elseif j==2
           step=1+normrnd(0,0.01);
        end
end