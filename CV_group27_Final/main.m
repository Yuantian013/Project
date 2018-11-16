% Final Project of Computer Vision course
% dependancies:
% file foler: mode_castle
% functions: 
% Author : Jiaao Dong          Yuan Tian
% 
% How to use this script:
% RUN and wait 
%% 0.1 Clear Screen
close all
clc
clear 
%% 0.2 Load images
% load the segmentaiton labels
% load('lab')
% fprintf('Load the meanshift labels for pixels\n'); 
% load the grayscale images and RGB images
im_folder='model_castle';
[im,num_im,im_color]=load_im_v2(im_folder,1,[]);
%% 1. Find features and descriptors
im=im2single(im);
[f,d]=Feat_extract_v2(im);
% load('f_d_concatenated'); % uncomment this line to directly load the
% features and descriptors
 %% 1.1 test harris affine
% test_harris_affine(im_color)
%% 2. Use normalized 8 points RANSAC algorithm to find best matches
[good_matches,F_best,matches]=Norm_EightPoints_RANSAC_by_d(f,d,[1e4*ones(1,14),2e5,2e4*ones(1,num_im-15)]);
save([im_folder,'_full_seg_thre1.2_1e4_2e5_concat.mat']);
%% 2.1 Visualize matches
mkdir([im_folder,'_good_matches']);
for i=1:num_im

which_im=i;
if i<=num_im-1
output_fig=plotmatches(im(:,:,which_im),im(:,:,which_im+1),f{which_im},f{which_im+1},good_matches{which_im});
else
    output_fig=plotmatches(im(:,:,which_im),im(:,:,1),f{which_im},f{1},good_matches{which_im});
end
print(output_fig,[im_folder,'_good_matches','/Good matches between image',num2str(i),' and ',num2str(i+1),'.png'],'-dpng','-r300');
end
%% 2.2 Visualize Foundamental Matrix
% visualize_F(F_best,im,1);
%% 3. Create point-view matrix to represent point correspondances for different camera views
M_point_view=PointViewMat(good_matches);
%% 3.1 Visualize some common found points
how_many_common_points=4;
figure_common = visualize_CommonPoints(im,M_point_view,f,how_many_common_points);
%% 4.1 SfM
points_data=mySfM_v2(M_point_view(1:15, :),3,f,im_color);
%% 4.1.0 visualize SfM
vis=10; % <---------which image set do you want to visualize?
figure
[fig_repro,fig_3D]=visual_SfM(vis,points_data,im_color);
%% 4.2 procrustes
transform=CalcTrans(points_data);
%% 4.3 stitching and visualize
[points_first_frame,pose_first_frame]=sti_recursive_overlap(transform,points_data);
points_color_map=cell(1);
for i=1:size(points_data,1)
    points_color_map{1}=[points_color_map{1};points_data(i).color];
end
points_color_map{1}(size(points_first_frame, 1)+1:end, :) = [];
figure
pcshow(points_first_frame, points_color_map{1},'MarkerSize',30);
xlabel('x')
ylabel('y')
zlabel('z')

%% 6 remove ambiguity
points_data_refine = remove_ambiguity(points_data);
%% compare poses
figure 
cmp_group = 1;
cmp_pose = 1;
u1 = points_data(cmp_group).Pose(2*cmp_pose-1,:);
v1 = points_data(cmp_group).Pose(2*cmp_pose,:);
u2 = points_data_refine(cmp_group).Pose(2*cmp_pose-1,:);
v2 = points_data_refine(cmp_group).Pose(2*cmp_pose,:);
plot3([u1(1),0,v1(1)], ...
    [u1(2),0,v1(2)], ...
    [u1(3),0,v1(3)],'b-', 'Linewidth',2)
hold on
plot3(norm(u1)*[u2(1),0,v2(1)], ...
    norm(u1)*[u2(2),0,v2(2)], ...
    norm(u1)*[u2(3),0,v2(3)], 'r-', 'Linewidth',2);
grid on 
ThetaInDegrees1 = atan2d(norm(cross(u1,v1)),dot(u1,v1))
ThetaInDegrees2 = atan2d(norm(cross(u2,v2)),dot(u2,v2))
legend('Before removal', 'After removal');
%% 6.1 visualize
transform_refine=CalcTrans(points_data_refine);
[points_first_frame_refine,pose_first_frame_refine]=sti_recursive_overlap(transform_refine,points_data_refine);
figure
points_color_map_refine=cell(1);
for i=1:size(points_data_refine,1)
    points_color_map_refine{1}=[points_color_map_refine{1};points_data_refine(i).color];
end
points_color_map_refine{1}(size(points_first_frame_refine, 1)+1:end, :) = [];
pcshow(points_first_frame_refine/1e10,points_color_map_refine{1},'MarkerSize',30);
xlabel('x')
ylabel('y')
zlabel('z')

%% 7 surf the 3D point cloud
figure_3D_surf = surf_3D_PCL_v2(1e3*points_first_frame, points_color_map{1});
print(figure_3D_surf, 'Surface of 3D points', '-dpng','-r300');
%% 5 bundle adjustment
[pose_fine,points_3D_fine]=bundle_adjustment(points_data);
for i = 1: size(points_data,1)
   points_data(i).pose = pose_fine{i};
   points_data(i).Points_3D = points_3D_fine{i};
end