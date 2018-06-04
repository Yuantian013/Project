%% 0.1 Clear Screen
close all
clc
clear all
%% 0.2 Load images
[im1,num1]=loadimage_MIL('sival_apple_banana/banana');
[im2,num2]=loadimage_MIL('sival_apple_banana/apple');
%% 1.0.0Test
im=im1(:,:,:,1);
width=35;
[clustCent,lab,cluster2dataCell]=im_meanshift(im,width);
%%
lab = reshape(lab,768,1024);
test=cell(1,1);
test{1}=lab;
%%
imagesc(lab);
colormap(gray);
%% 1.0.1
TEST=bags2dataset(test,1);
%% 1.1 Extract instances
lab1=extractinstances(im1,width);
%% 1.2 Extract instances
lab2=extractinstances(im2,width);