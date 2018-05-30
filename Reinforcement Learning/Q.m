function y=Q(Theta,n,RBF)
         y=0;
         for i=1:n
         y=y+Theta(i)*RBF(i);
         end        
end