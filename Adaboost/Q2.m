clear all;
clc;
close all;
%% Importdata
data=importdata('optdigitsubset.txt');
label=ones(1125,1);
label(555:1125,1)=-1;
%% Regularization
[m,n]=size(data); 
for i=1:n  
    A(1,i)=norm(data(:,i));  
end  
A=repmat(A,m,1);  
data=data./A;
%% Train
[bestFeature,threshold,sign,Right]=Set_DS(data,label);
bestFeature
threshold
sign
Right