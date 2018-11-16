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
%% 1.1 Normalize data
norm_data=zscore(ori_train_data);
%% 2.1 CV
C_para=[0.1,0.15,0.2,0.25];
for C=1:size(C_para,2)
range=(1:200)';
cv_label=zeros(200,1);
for times=1:200
Noise_Train=norm_data(range~=times,:);
Noise_Label=ori_train_label(range~=times,:);
Noise_Test=norm_data(times,:);
          times
  w = fitcsvm(Noise_Train,Noise_Label,'Standardize',true,'KernelFunction','polynomial',...
          'KernelScale','auto','OutlierFraction',C_para(C));
[cv_label_no(times),~]=predict(w,norm_data(times,:)); 
Noise_Test=p_norm(10,20,norm_data(times,:));
[cv_label_noise(times),~]=predict(w,Noise_Test); 
end
error_noise(C)=sum((cv_label_no'~=ori_train_label))/200
error_no(C)=sum((cv_label_noise'~=ori_train_label))/200
end
%%

%% Plot
plot(C_para,error_noise);
hold on
plot(C_para,error_no);
xlabel('Parameter C');
ylabel('Error rate');
legend('without noise','with noise')
