function [points_first_frame,pose_first_frame]=sti_recursive_overlap(transform,points_data)

num_set=size(points_data,1);
points_first_frame=cell(1);
points_first_frame{1}=points_data(end).Points_3D';
pose_first_frame{1}=points_data(end).Pose;

for i=1:num_set-1
    
    points_first_frame{1}=[points_data(num_set-i).Points_3D';
        transform{num_set-i}.b*points_first_frame{1}*transform{num_set-i}.T+...
        transform{num_set-i}.c(1,:)];
    pose_first_frame{1}=[points_data(num_set-1).Pose; 
        transform{num_set-1}.b*pose_first_frame{1}*transform{num_set-i}.T+...
        transform{num_set-i}.c(1,:)];
        
  
end

end