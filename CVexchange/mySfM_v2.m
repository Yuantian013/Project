function points_data=mySfM_v2(PointViewMatrix,size_group,f,im_color)
% input:
% PointViewMarix is the output of PointViewMat.m
% portion indicates how to divide the frames. E.g. if portion =3 the frames
% are divided by [3,3,3,3,3,4]
% f is cell variable f{n} is the features from nth frame
%--------------------------------------------------------------------------
% output:
% M is the motion matrix
% S is the shape matrix, different points in 3D world are in different
% columns The three values in each portion indicate the 3D coordinates
num_im=size(PointViewMatrix,1);
points_data=struct('PointsIndx',cell(num_im-size_group+1,1),...
    'Points_3D',cell(num_im-size_group+1,1),...
    'Points_2D',cell(num_im-size_group+1,1),...
    'Pose',cell(num_im-size_group+1,1),...
    'mean_meas',cell(num_im-size_group+1,1),...
    'color',cell(num_im-size_group+1,1));
    im_size=size(im_color{1}(:,:,1));

for i=1:num_im-size_group+1
    % find common seen points
    num_points_common=sum(PointViewMatrix(i:i+size_group-1,:)~=0,1);
    [~,indx]=find(num_points_common==size_group);
    points_data(i).PointsIndx=indx;
    num_points=sum(num_points_common==size_group,2);
    % find the 2D coordinates of these points
    meas=zeros(2*size_group,num_points);
    for j=1:size_group
       meas(2*j-1:2*j,:)=f{i+j-1}(1:2,PointViewMatrix(i+j-1,indx));
    end
    points_data(i).Points_2D=meas;
    
    linear_indx=sub2ind(im_size,floor(meas(2,:)),floor(meas(1,:)));
    
    color_r=im_color{i}(:,:,1);
    color_g=im_color{i}(:,:,2);
    color_b=im_color{i}(:,:,3);
    points_data(i).color(:,1)=color_r(linear_indx);
    points_data(i).color(:,2)=color_g(linear_indx);
    points_data(i).color(:,3)=color_b(linear_indx);

    points_data(i).mean_meas=mean(meas,2);
    meas=meas-mean(meas,2);
    % SfM
    [U,W,V]=svd(meas);
    U=U(:,1:3);
    W=W(1:3,1:3);
    V=V(:,1:3);
%     points_data(i).Points_3D=sqrtm(W)*V';
%     points_data(i).Pose=U*sqrtm(W);
    points_data(i).Points_3D=V';
    points_data(i).Pose=U*W;
end

end