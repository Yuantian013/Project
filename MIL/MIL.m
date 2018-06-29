%% 0.1 Clear Screen
close all
clc
clear all
%% 1.0 Load image
[im1,num1]=loadimage_MIL('sival_apple_banana/banana');
[im2,num2]=loadimage_MIL('sival_apple_banana/apple');
%% 1.1 Extract instances
width1=35;
width2=35;
[bags1,lab1,part1]=extractinstances(im1,width1);
[bags,lab2,part2]=extractinstances(im2,width2);
%% 1.2.1 Or load data
load('part1.mat') %raw / using extractinfo
load('part2.mat') %raw / using extractinfo
%% 1.3 Test image
imagesc(lab2{8});
colormap(gray);
%% 2.0 DATA & LABEL
data=gendatmilsival(info1,info2);
%data_25=gendatmilsival(bags_b,bags_a);
%% 2.1  Show bag id
bagid = getident(data,'milbag');
%% 2.2  Plot
figure(1);plotinfo(data);
%% 3.1 Label=combineinstlabels(labels)
% a = [1 2 2 2 2 2 3 3 3 4 5 6 7 8 8 4 5 6 8 9 9 0 7 6 5 7 7 7 7 7 7 7];
% Label=combineinstlabels(a);
%% 4.1 Train & CV Assessment
baglabel=ones(120,1);
baglabel(61:120)=2;
%[error_rate_bagcv,baglabel_bagcv]=bagcv(data,baglabel);
%%
[ERR,~,labels] =prcrossval(data,fisherc);
BAGLABELS=BAGTEST(data,labels);
%%
sum(double(BAGLABELS~=baglabel))/120;
%% 5.1 Improvement 1 background subtraction
[part_imp1]=part_imp(part1);
[part_imp2]=part_imp(part2);
%% 5.2 Average RGB
[info1_imp]=extractinfo(part_imp1,im1);
[info2_imp]=extractinfo(part_imp2,im2);
%% 5.3 DATA & LABEL
data_imp=gendatmilsival(info1_imp,info2_imp);
%% 5.4 TEST
[error_rate_bagcv_imp,baglabel_bagcv_imp]=bagcv(data_imp,baglabel);
%% 6.1 Improvement 2 width
[error_rate_bagcv_25,baglabel_bagcv_25]=bagcv(data_25,baglabel);
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% 7.0 test
mycv(data,50,baglabel)
%%
%% 7.1 m(B)
sigma=[10,25,50,75,100,150];
error=ones(size(sigma,2),1);
for i=1:size(sigma,2)
error(i)=mycv(data,sigma(i),baglabel)
end
%% 7.2Plot
figure(3)
plot(sigma(:),error(:))
xlabel('Sigma')
ylabel('Cross validation error')
%% 
MILES=bagembed(data_25,200);
DATA_MILES=prdataset(MILES,baglabel);
error_imp(1)=prcrossval(DATA_MILES,liknonc);
%% 7.3 Improvement
sigma=[10,25,50,75,100,250];
error=ones(size(sigma,2),1);
for i=1:size(sigma,2)
MILES=bagembed(data,sigma(i));
[coeff,score,latent] = pca(MILES);
MILES_pca=MILES*coeff(:,1:50);
%% Generate data
DATA_MILES_pca=prdataset(MILES_pca,baglabel);
error_pca(i)=prcrossval(DATA_MILES_pca,liknonc)
end
%% Plot
figure(3)
plot(sigma(:),error(:))
hold on
plot(sigma(:),error_pca(:))
xlabel('Sigma')
ylabel('Cross validation error')
legend('Before PCA','After PCA')
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% 8.0 NEW Algorithm
%%
Bags1=feature_8(part1,im1);
Bags2=feature_8(part2,im2);
%% Baged
data_8=Bags1;
data_8(61:120,:)=Bags2;
%%
data_8=prdataset(data_8,baglabel);
%% 
prcrossval(data_8,parzenc);