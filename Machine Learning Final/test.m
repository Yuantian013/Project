%% 0.1 Clear Screen
close all
clc
clear all
%% 0.2 Load data
data_info=csvread('train.csv');
data=data_info(:,2:205);
label=data_info(:,1);
semi_data=csvread('test.csv');
data=prdataset(data,label);
semi_label=csvread('label.csv');
%% get distance
for i=1:20000
    distance_1=norm(semi_data(i,:)-ctrs(1,:));
    distance_2=norm(semi_data(i,:)-ctrs(2,:));
        DIS(i)=abs(distance_1-distance_2);
end
[~,max_index]=sort(DIS);
%% get weights
[coeff,score,latent,tsquared,explained,mu] = pca(semi_data(max_index(3000:20000),:));
%% 
Y =getdata(data);
c_label=zeros(200,1);
for i=1:20000
    distance_1=0;
    distance_2=0;   
    for j=1:204
        distance_1=distance_1+(latent(j)/sum(latent))*abs((semi_data(i,j)-ctrs(1,j)))^2;
        distance_2=distance_2+(latent(j)/sum(latent))*abs((semi_data(i,j)-ctrs(2,j)))^2;
    end
% distance_1=norm(Y(i,:)-ctrs(1,:));
% distance_2=norm(Y(i,:)-ctrs(2,:));
    if distance_1>distance_2
        c_label(i)=2;
    else 
        c_label(i)=1;
    end
end
w=liknonc(data);
svm_label=semi_data*w*labeld
error=sum(c_label~=svm_label)/20000
%%
Y =getdata(data);
c_label=zeros(200,4);
for i=1:20000
    distance_1=0;
    distance_2=0;   
    for j=1:204
        distance_1=distance_1+(latent(j)/sum(latent))*abs((semi_data(i,j)-ctrs(1,j)))^2;
        distance_2=distance_2+(latent(j)/sum(latent))*abs((semi_data(i,j)-ctrs(2,j)))^2;
    end
        c_dis(i,1)=distance_2;
        c_dis(i,2)=distance_1;
        c_dis(i,3)=distance_1-distance_2;
end
%%
ddd=1:0.01:1.2;
for j=1:length(ddd)
c_label=zeros(20000,1);
for i=1:20000
    if c_dis(i,3)>=ddd(j)
       c_label(i)=2;
    elseif  c_dis(i,3)<-ddd(j)
           c_label(i)=1;
    end
end
semisemi=prdataset(semi_data(c_label~=0,:),c_label(c_label~=0,:));
w=liknonc(semisemi);
test_label=data*w*labeld;
error(j)=sum(test_label~=label)/200;
end
%% 
plot(ddd,error)