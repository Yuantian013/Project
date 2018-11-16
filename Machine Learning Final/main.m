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
%% 1.2 Data augmentation(generate noise)
P_range=[1,1.5,2,5,10];
R_range=[1,2,5,10,15,20];
Noisy_data=struct('Data',cell(size(P_range,2)*size(R_range,2),1),'p',cell(size(P_range,2)*size(R_range,2),1),'r',cell(size(P_range,2)*size(R_range,2),1));
for i=1:size(P_range,2)
    for j=1:size(R_range,2)
Noisy_data((i-1)*size(R_range,2)+j).Data=p_norm(P_range(i),R_range(j),norm_data);
Noisy_data((i-1)*size(R_range,2)+j).p=P_range(i);
Noisy_data((i-1)*size(R_range,2)+j).r=R_range(j);
    end
end
train_data=ori_train_data;
train_label=ori_train_label;
for i=1:size(Noisy_data,1)
    train_data(end+1:end+200,:)=Noisy_data(i).Data;
    train_label(end+1:end+200,:)=ori_train_label;
end
%% 1.3 Semi training SVM1 without drop
% Generate initial training and test data
old_data=train_data;
old_label=train_label;
norm_test=zscore(semi_data);
new_data=[];
new_label=[];
for i=1:100
% Train the svm
w = fitcsvm(old_data,old_label,'Standardize',true,'KernelFunction','polynomial',...
              'KernelScale','auto','OutlierFraction',0.01,'BoxConstraint',600,'PolynomialOrder',2);
[~,score]=predict(w,norm_test);
% Find the most condfident data and put into training set
% [~,x_new1] = sort(score(:,1));
% [~,x_new2] = sort(score(:,2));
x_new1=find(score(:,1)>0.9*max(score(:,1)));
x_new2=find(score(:,2)<0.9*min(score(:,2)));
% [max(score(:,1)),size(x_new1,1),min(score(:,2)),size(x_new2,1)]
new_data(end+1:end+size(x_new1,1),:)=norm_test(x_new1,:);
new_label(end+1:end+size(x_new1,1),:)=1;
new_data(end+1:end+size(x_new2,1),:)=norm_test(x_new2,:);
new_label(end+1:end+size(x_new2,1),:)=2;
% Updata new data
% old_data(end+1:end+20,:)=norm_test(x_new1(end-19:end),:);
% old_label(end+1:end+20,:)=1;
% old_data(end+1:end+20,:)=norm_test(x_new2(1:20),:);
% old_label(end+1:end+20,:)=2;
% old_data(end+1:end+size(x_new1,1),:)=norm_test(x_new1,:);
% old_label(end+1:end+size(x_new1,1),:)=1;
% old_data(end+1:end+size(x_new2,1),:)=norm_test(x_new2,:);
% old_label(end+1:end+size(x_new2,1),:)=2;
old_data=train_data;
old_label=train_label;
old_data(end+1:end+size(new_data,1),:)=new_data;
old_label(end+1:end+size(new_data,1),:)=new_label;
% norm_test([x_new1(end-19:end);x_new2(1:20)],:)=[];
norm_test([x_new2;x_new1],:)=[];
% % Drop data
% [~,score]=predict(w,new_data);
% rank1=sort(score(:,1));
% x_delete=find(abs(score(:,1))<1);
% new_data(x_delete,:)=[];
% new_label(x_delete,:)=[];
% Compare with "ground truth"
[svm_label,~]=predict(w,zscore(semi_data));
diff_dicision1(i)=sum((svm_label~=ground_label));
diff_dicision2(i)=sum((svm_label~=store_final_labels));
diff_dicision3(i)=sum((svm_label~=ymh_label));
[i,diff_dicision1(i),diff_dicision2(i),diff_dicision3(i),sum(ground_label==svm_label==ymh_label)]
% max(score(:,1))
% min(score(:,2))
end
%% 2.1 CV
P_range=[4,8,10,12];
R_range=[2,5,8,10,12,15];
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
times
  w = fitcsvm(Noise_Train,Noise_Label,'Standardize',true,'KernelFunction','polynomial',...
          'KernelScale','auto','OutlierFraction',0.1);
Noise_Test=p_norm(10,10,norm_data(times,:));
[cv_label(times),~]=predict(w,Noise_Test); 
end
sum((cv_label~=ori_train_label))/200
%% Plot
plot(1:100,diff_dicision);
%% 20000 TEST OUTPUT
csvwrite('MYLABEL.csv',svm_label);
%% 
[drop_label,~]=predict(w,norm_data);
sum((drop_label~=train_label))/200
norm_test=zscore(getdata(test_data));
[drop_label,~]=predict(w,norm_test);
sum((drop_label~=ymh_label))/20000
%%
Set=[1,2,5,8,12,15,18,20];
for C=1:size(Set,2)
range=(1:200)';
cv_label=zeros(200,1);
parfor times=1:200
Noise_Train=norm_data(range~=times,:);
Noise_Label=ori_train_label(range~=times,:);
Noise_Test=norm_data(times,:);
for i=1:size(P_range,2)
    for j=1:size(R_range,2)
Noise_Train(end+1:end+199,:)=p_norm(P_range(i),R_range(j),norm_data(range~=times,:));
Noise_Label(end+1:end+199,:)=ori_train_label(range~=times,:);
    end
end
Noise_Train(end+1:end+size(new_data,1),:)=new_data;
Noise_Label(end+1:end+size(new_label,1),:)=new_label;
          times
  w = fitcsvm(Noise_Train,Noise_Label,'Standardize',true,'KernelFunction','polynomial',...
          'KernelScale','auto','OutlierFraction',0.01,'BoxConstraint',600,'PolynomialOrder',2);
Noise_Test=p_norm(Set(C),Set(C),norm_data(times,:));
[cv_label_noise(times),~]=predict(w,Noise_Test); 
end
error_noise(C)=sum((cv_label_noise'~=ori_train_label))/200
end
%%
plot(semis(1:7),semi_error(1:7));
xlabel('Additional data');
ylabel('Error rate');
%%
sum(ground_label==svm_label)
%%
error_noise(5)=0.43;
error_noise(6)=0.445;
error_noise(7)=0.45;
%% 
plot(Set,error_noise);
xlabel('[R,P]');
ylabel('Error rate');
%%
my_labels=csvread('MYLABEL.csv');
%%
sum(ground_label==my_labels)
sum(ymh_label==my_labels)