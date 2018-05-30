%% assignment2-whole work flow
%% clear the window
close all;
clear all
clc
%% find the harris corner points
image1='landscape-a.jpg';
image2='landscape-b.jpg';
img1=imread(image1);
img1=rgb2gray(img1);
img2=imread(image2);
img2=rgb2gray(img2);
[r1,c1]=myharris_ScaleInv(img1);
[r2,c2]=myharris_ScaleInv(img2);
%% transform the image to single precision
img1=single(img1);
img2=single(img2);
frames1=[c1,r1]';
frames2=[c2,r2]';
%% find the corresponding descriptor and features f1 that can be drawn 
[f1,d1]=vl_covdet(img1,'Frames',frames1);
%VL_COVDET(..., 'Frames', F) uses the user specified frames F instead of 
%running a detector. The estimation of the affine shape and of the feature 
%orientation can still be performed starting from such frames. Moreover, 
%descriptors for these frames can be computed. 
[f2,d2]=vl_covdet(img2,'Frames',frames2);
%%
matches=vl_ubcmatch(d1,d2,2);
points1=f1(1:2,matches(1,:));
points2=f2(1:2,matches(2,:));
plotmatches(img1,img2,points1,points2);
