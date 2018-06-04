function [data]=plotinfo(data)
data_1=data.DATA(1:size(find(data.LABELS==1)),:);
data_2=data.DATA(size(find(data.LABELS==1))+1:size(data.DATA,1),:);
scatter3(data_1(:,1),data_1(:,2),data_1(:,3))
hold on
scatter3(data_2(:,1),data_2(:,2),data_2(:,3))
xlabel('R')
ylabel('G')
zlabel('B')
legend('Apple','Banana')
end 