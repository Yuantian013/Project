function go=G(i,ex,alpha,n,o,ThetaL,ThetaR,lambda)
if i>1.5 && i<=5.5
        rbf=RBF(i,n,o);
        [j,step]=STEP(ex,Q(ThetaL,n,rbf),Q(ThetaR,n,rbf));
        if i+step<=1.5
           R=1;
        elseif i+step>5.5
           R=5;
        else 
           R=0;
        end
        go=lambda*(R+alpha*G(i+step,ex,alpha,n,o,ThetaL,ThetaR,lambda));
else 
        go=0;
end
end