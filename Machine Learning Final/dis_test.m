function [c_label,error]=dis_test(data,ctrs)
Y =getdata(data);
c_label=zeros(size(Y,1),1);
label=getlab(data);
for i=1:size(Y,1)
    dis1=norm(Y(i,:)-ctrs(1,:));
    dis2=norm(Y(i,:)-ctrs(2,:));
    if dis1>dis2
        c_label(i)=2;
    else 
        c_label(i)=1;
    end
end
error=sum(c_label~=label)/size(Y,1);
end