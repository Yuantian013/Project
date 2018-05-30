clear all;
clc;
close all;
%% Importdata
data=importdata('optdigitsubset.txt');
label=ones(1125,1);
label(555:1125,1)=0;
%% Training data
train_data=zeros(100,64);
train_data(1:50,:)=data(1:50,:);
train_data(51:100,:)=data(555:604,:);
train_label=ones(100,1);
train_label(51:100,1)=0;
%% Adaboost
times=17;
[Image]=adaboostbestshow(train_data,train_label,times);
    for j=1:4
        subplot(2,2,5-j)
        image=reshape(train_data(Image(j),:),[8,8]);
        imshow(uint8(image));
        title(['Weight rank = ',num2str(5-j)])
    end