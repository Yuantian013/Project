function Result=improve_c(semi_data,test_data,ctrs,times)
%% Define
Result=struct('Center',cell(times,1),'Error_rate',cell(times,1));
DIS=zeros(20000,1);
label=getlab(test_data);
%% Remove the most far away point
for time=1:times
for i=1:20000
    distance_1=norm(semi_data(i,:)-ctrs(1,:));
    distance_2=norm(semi_data(i,:)-ctrs(2,:));
    if distance_1<distance_2
        DIS(i)=distance_1;
    else
        DIS(i)=distance_2;
    end
end
[~,out1]=sort(DIS);
num1=out1(1:18000);
%% Remove the points hard to classify
for i=1:20000
    distance_1=norm(semi_data(i,:)-ctrs(1,:));
    distance_2=norm(semi_data(i,:)-ctrs(2,:));
    DIS(i)=abs(distance_1-distance_2);
end
[~,out2]=sort(DIS);
num2=out2(2000:20000);
c=intersect(num1,num2);
%% Re-Kmeans
X =semi_data(c,:);
opts = statset('Display','final','MaxIter',500);
[~, ctrs] = kmeans(X, 2,'Replicates',100, 'Options',opts);

if ctrs(1,1)<ctrs(2,1)
    Result(time).Center(1,:)=ctrs(2,:);
    Result(time).Center(2,:)=ctrs(1,:);
else
    Result(time).Center(1,:)=ctrs(1,:);
    Result(time).Center(2,:)=ctrs(2,:);
end
%% Test
Y =getdata(test_data);
c_label=zeros(200,1);
for i=1:200
    dis1=norm(Y(i,:)-Result(time).Center(1,:));
    dis2=norm(Y(i,:)-Result(time).Center(2,:));
    if dis1>dis2
        c_label(i)=2;
    else 
        c_label(i)=1;
    end
end
Result(time).Error_rate=sum(c_label~=label)/200;
end
end