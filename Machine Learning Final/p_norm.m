function p_norm_data=p_norm(p,r,data)
%%% p-norm noise generator 
%%% 'p' is the real number p ti difine the p-norm
%%% 'r' is the real number r to difine the p-norm-ball's radius
%%% 'data' is the input data
%%% 'p_norm_data' is the output data with additional p-norm noise
[m,n]=size(data);
p_norm_data=data;
for i=1:m
    list=randperm(n);
    range=r;
    for t=1:n
        noise =-range + 2*range*rand;
        p_norm_data(m,list(t))=p_norm_data(m,list(t))+noise;
        range=(range^p-abs(noise^p))^(1/p);
    end
end
end