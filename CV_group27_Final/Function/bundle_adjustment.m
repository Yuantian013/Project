function [pose_fine,points_3D_fine]=bundle_adjustment(points_data)

num_set=size(points_data,1);
pose_fine=cell(num_set,1);
points_3D_fine=cell(num_set,1);
    X=cell(1);
    for j=1:num_set
        new_points=[points_data(j).Pose',points_data(j).Points_3D];
        X{1}=[X{1},new_points];
    end
%     X=X{1};
     X=reshape(X{1},1,[]);
 opts = optimoptions('fminunc', 'Display', 'iter', 'UseParallel', true,...
  'MaxFunctionEvaluations', 1e6);
% ,'StepTolerance',1e-08
x=fminunc(@compute_reprojection_error,X,  opts);

%    options = optimoptions('lsqnonlin','Display','iter','UseParallel',true,...
%                           'Algorithm','levenberg-marquardt');
%     x=lsqnonlin(@compute_reprojection_error,X,[],[],options);

    function error=compute_reprojection_error(X)
         X=reshape(X,3,[]);
        indx_starting=1;
        indx_ending=0;
%         num_points_tot=0;
        error=0;
        for i=1:num_set
        num_points=size(points_data(i).Points_3D,2);
%         num_points_tot=num_points_tot+num_points;
        num_pose=size(points_data(i).Pose,1);            
        indx_ending=indx_ending+num_points+num_pose;
        pose=X(:,indx_starting:indx_starting+num_pose-1)';
        points_3D=X(:,indx_starting+num_pose:indx_ending);
        points_2D=pose*points_3D+points_data(i).mean_meas;
        error=error+sum(sqrt(sum((points_2D(1:2, :)-points_data(i).Points_2D(1:2, :)).^2)))+ ...
            sum(sqrt(sum((points_2D(3:4, :)-points_data(i).Points_2D(3:4, :)).^2)))+ ...
            sum(sqrt(sum((points_2D(5:6, :)-points_data(i).Points_2D(5:6, :)).^2)));
        indx_starting=indx_ending+1;
        end
    end
    x = reshape(x, 3, []);
      for k=1:num_set
         starts_from=1;
         ends_with=0;
         num_points_x=size(points_data(k).Points_2D,2);
         num_pose_x=size(points_data(k).Pose,1);
         ends_with=ends_with+num_points_x+num_pose_x;
         pose_fine{k}=x(:,starts_from:starts_from+num_pose_x-1)';
         points_3D_fine{k}=x(:,starts_from+num_pose_x:ends_with);
      end


end