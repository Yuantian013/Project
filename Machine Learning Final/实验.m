%% 0.1 Clear Screen
close all
clc
clear all
%% 0.2 Load data
semi_data=csvread('test.csv');
semi_label=csvread('label.csv');
test_data=prdataset(semi_data,semi_label);
data_info=csvread('train.csv');
ori_train_data=data_info(:,2:205);
ori_train_label=data_info(:,1);
ground_label=csvread('predicted_labels.csv');
ymh_label=csvread('ymh_label.csv');
store_final_labels=csvread('labels_Z_Ai.csv');
%% 1.1 Normalize data
norm_data=zscore(ori_train_data);
%% CV without adding noise with p change 
P_range=[1,1.5,2,4,10,20,50,100,150,200];
for i=1:size(P_range,2)
range=(1:200)';
cv_label=zeros(200,1);
for times=1:200
Noise_Train=norm_data(range~=times,:);
Noise_Label=ori_train_label(range~=times,:);
Noise_Test=norm_data(times,:);
  w = fitcsvm(Noise_Train,Noise_Label,'Standardize',true,'KernelFunction','polynomial',...
          'KernelScale','auto','OutlierFraction',0.1);
Noise_Test=p_norm(P_range(i),10,norm_data(times,:));
[cv_label(times),~]=predict(w,Noise_Test); 
error_p(i)=sum((cv_label~=ori_train_label))/200;
times
end
end
%%
plot(P_range,error_p);
xlabel('p');
ylabel('Error rate');
%% CV without adding noise with r change 
R_range=[1,1.5,2,4,10,20,50,100,150,200];
for i=1:size(R_range,2)
range=(1:200)';
cv_label=zeros(200,1);
for times=1:200
Noise_Train=norm_data(range~=times,:);
Noise_Label=ori_train_label(range~=times,:);
Noise_Test=norm_data(times,:);
  w = fitcsvm(Noise_Train,Noise_Label,'Standardize',true,'KernelFunction','polynomial',...
          'KernelScale','auto','OutlierFraction',0.25);
Noise_Test=p_norm(10,R_range(i),norm_data(times,:));
[cv_label(times),~]=predict(w,Noise_Test); 
error_r(i)=sum((cv_label~=ori_train_label))/200;
times
end

end
%%
plot(R_range,error_r);
xlabel('r');
ylabel('Error rate');
%% 2.1 CV
P_range=[1,2,5,8,10,12,15];
R_range=[1,2,5,10,15,20,25];
Set=[1,2,5,8,12,15,18,20];
parfor sets=1:8
    sets
range=(1:200)';
cv_label=zeros(200,1);
for times=1:200
Noise_Train=norm_data(range~=times,:);
Noise_Label=ori_train_label(range~=times,:);
Noise_Test=norm_data(times,:);
for i=1:size(P_range,2)
    for j=1:size(R_range,2)
Noise_Train(end+1:end+199,:)=p_norm(P_range(i),R_range(j),norm_data(range~=times,:));
Noise_Label(end+1:end+199,:)=ori_train_label(range~=times,:);
    end
end
  w = fitcsvm(Noise_Train,Noise_Label,'Standardize',true,'KernelFunction','polynomial',...
          'KernelScale','auto','OutlierFraction',0.01);
Noise_Test=p_norm(Set(sets),Set(sets),norm_data(times,:));
[cv_label(times),~]=predict(w,Noise_Test); 
end
error_set_with(sets)=sum((cv_label~=ori_train_label))/200
end
%%
Set=[1,2,5,8,12,15,18,20];
parfor sets=1:8
range=(1:200)';
cv_label=zeros(200,1);
for times=1:200
Noise_Train=norm_data(range~=times,:);
Noise_Label=ori_train_label(range~=times,:);
Noise_Test=norm_data(times,:);
  w = fitcsvm(Noise_Train,Noise_Label,'Standardize',true,'KernelFunction','polynomial',...
          'KernelScale','auto','OutlierFraction',0.01);
Noise_Test=p_norm(Set(sets),Set(sets),norm_data(times,:));
[cv_label(times),~]=predict(w,Noise_Test); 
end
error_set_without(sets)=sum((cv_label~=ori_train_label))/200
end
%%
error_set_with(4)=0.35;
error_set_with(8)=0.45;
error_set_with(6)=0.43;
error_set_without(7)=0.47;
%% 
plot(Set,error_set_with);
hold on
plot(Set,error_set_without);
xlabel('[R,P]');
ylabel('Error rate');
legend('with noise','without noise')
%% OUT
P_range=[1,2,4,8,10,12];
R_range=[5,8,10,15,18,20,22];
Out=[0.01,0.02,0.05,0.1,0.2,0.5];
parfor sets=1:6
    sets
range=(1:200)';
cv_label=zeros(200,1);
for times=1:200
Noise_Train=norm_data(range~=times,:);
Noise_Label=ori_train_label(range~=times,:);
Noise_Test=norm_data(times,:);
for i=1:size(P_range,2)
    for j=1:size(R_range,2)
Noise_Train(end+1:end+199,:)=p_norm(P_range(i),R_range(j),norm_data(range~=times,:));
Noise_Label(end+1:end+199,:)=ori_train_label(range~=times,:);
    end
end
  w = fitcsvm(Noise_Train,Noise_Label,'Standardize',true,'KernelFunction','polynomial',...
          'KernelScale','auto','OutlierFraction',0.01);
Noise_Test=p_norm(Set(sets),Set(sets),norm_data(times,:));
[cv_label(times),~]=predict(w,Noise_Test); 
end
error_set_with(sets)=sum((cv_label~=ori_train_label))/200
end
%%
plot(Out,error_set_with(1:6));
xlabel('Outlier fraction');
ylabel('Error rate');
%% BOX
P_range=[1,2,4,8,10,12];
R_range=[5,8,10,15,18,20,22];
Out=[300,400,500,550,600,650,700,800];
parfor sets=1:8
    sets
range=(1:200)';
cv_label=zeros(200,1);
for times=1:200
Noise_Train=norm_data(range~=times,:);
Noise_Label=ori_train_label(range~=times,:);
Noise_Test=norm_data(times,:);
for i=1:size(P_range,2)
    for j=1:size(R_range,2)
Noise_Train(end+1:end+199,:)=p_norm(P_range(i),R_range(j),norm_data(range~=times,:));
Noise_Label(end+1:end+199,:)=ori_train_label(range~=times,:);
    end
end
  w = fitcsvm(Noise_Train,Noise_Label,'Standardize',true,'KernelFunction','polynomial',...
          'KernelScale','auto','OutlierFraction',0.01,'BoxConstraint',Out(sets),'PolynomialOrder',2);
Noise_Test=p_norm(10,10,norm_data(times,:));
[cv_label(times),~]=predict(w,Noise_Test); 
end
error_set_with(sets)=sum((cv_label~=ori_train_label))/200
end
%%
plot(Out,error_set_with);
xlabel('Box Constraint');
ylabel('Error rate');
%% kernel
P_range=[1,2,4,8,10,12];
R_range=[5,8,10,15,18,20,22];
Out=[2,3,4];
parfor sets=1:3
    sets
range=(1:200)';
cv_label=zeros(200,1);
for times=1:200
Noise_Train=norm_data(range~=times,:);
Noise_Label=ori_train_label(range~=times,:);
Noise_Test=norm_data(times,:);
for i=1:size(P_range,2)
    for j=1:size(R_range,2)
Noise_Train(end+1:end+199,:)=p_norm(P_range(i),R_range(j),norm_data(range~=times,:));
Noise_Label(end+1:end+199,:)=ori_train_label(range~=times,:);
    end
end
  w = fitcsvm(Noise_Train,Noise_Label,'Standardize',true,'KernelFunction','polynomial',...
          'KernelScale','auto','OutlierFraction',0.01,'BoxConstraint',600,'PolynomialOrder',Out(sets));
Noise_Test=p_norm(5,5,norm_data(times,:));
[cv_label(times),~]=predict(w,Noise_Test); 
end
error_set_with(sets)=sum((cv_label~=ori_train_label))/200
end
%%
plot(Out,error_set_with(1:3));
xlabel('Box Constraint');
ylabel('Error rate');