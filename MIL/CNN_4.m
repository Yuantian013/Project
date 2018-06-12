%% 0.1 Clear Screen
close all
clc
clear all
%% 1.0 Load image
[im1,~]=loadimage_MIL('sival_medal_tea/greenteabox');
[im2,~]=loadimage_MIL('sival_medal_tea/goldmedal');
[im3,~]=loadimage_MIL('sival_apple_banana/banana');
[im4,~]=loadimage_MIL('sival_apple_banana/apple');
baglabel=ones(240,1);
baglabel(61:120)=2;
baglabel(121:180)=3;
baglabel(181:240)=4;
%% 5.1 Test
Bags1=feature_4(part_cnn1,im1);
Bags2=feature_4(part_cnn2,im2);
Bags3=feature_4(part1,im3);
Bags4=feature_4(part2,im4);
data_8=Bags1;
data_8(61:120,:)=Bags2;
data_8(121:180,:)=Bags3;
data_8(181:240,:)=Bags4;
data_8=prdataset(data_8,baglabel);
prcrossval(data_8,knnc);
%% MILES
bags=bags';
bags(61:120)=bags1';
bags(121:180)=info1';
bags(181:240)=info2';
data = bags2dataset(bags,baglabel);
MILES=bagembed(data,50);
DATA_MILES=prdataset(MILES,baglabel);
error_4=prcrossval(DATA_MILES,liknonc);
%% 
