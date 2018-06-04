function [part]=part_imp(part)
num_im=size(part,2);
for i=1:num_im
    SIZE=0;
    J=0;
    num_instance=size(part{i},1);
    for j=1:num_instance
        if size(part{i}{j},2)>SIZE
           SIZE=size(part{i}{j},2);
           J=j;
        end
    end
    part{i}(J)=[];
end
end