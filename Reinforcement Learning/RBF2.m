function rbf=RBF2(s,o)  
    rbf=zeros(1,2)';
    rbf(1)=exp((-(s-1.5)^2)/(2*o^2));
    rbf(2)=exp((-(s-5.5)^2)/(2*o^2));
    
    N=sum(rbf);
    rbf=rbf/N;
end 