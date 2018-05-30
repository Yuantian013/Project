% Final Project of Computer Vision course
% dependancies:
% file foler: mode_castle
% functions: 
% load_castle
% 
%% 0.1 Clear Screen
close all
clc
clear all
%% 0.2 Load images(use'TeddyBear' or 'model_castle')
[im,num_im]=load_im('TeddyBear');
%% 1. Find features and descriptors
im=im2single(im);
[f,d]=Feat_extract(im);
%% 2. Use normalized 8 points RANSAC algorithm to find best matches
[good_matches,F_best]=Norm_EightPoints_RANSAC_by_d(f,d);
%% 2.1 Visualize Foundamental Matrix
visualize_F(F_best,im,1);
%% 3. Create point-view matrix to represent point correspondances for different camera views
M=PointViewMat(good_matches);
%% 3.1 Visualize some common found points
visualize_CommonPoints(im,M,f);