function rbf=RBF(s,n,o)  
rbf=zeros(1,n)';
for i=1:n
    rbf(i)=exp(-((s-1-5*(i-1)/(n-1))^2)/(2*o^2));
end
    N=sum(rbf);
    rbf=rbf/N;
end 