function rbf=RBF4(s,o)  
rbf=zeros(1,4)';
for i=1:4
    rbf(i)=exp((-(s-1-i)^2)/(2*o^2));
end
    N=sum(rbf);
    rbf=rbf/N;
end 