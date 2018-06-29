function points_data_refine = remove_ambiguity(points_data)

num_group = size(points_data, 1);
num_img = size(points_data(1).Pose, 1) / 2;
points_data_refine = points_data;
for i = 1:num_group
    for j = 1:num_img
        v1 = points_data(i).Pose(2 * j - 1, :);
        v2 = points_data(i).Pose(2 * j, :);
        v3 = cross(v1, v2);
        v1 = v1 / norm(v1);
        v2 = v2 / norm(v2);
        v3 = v3 / norm(v3);
        A = [v1; v2; v3];
        L = inv(A' * A);
        C = chol(L)';
        points_data_refine(i).Pose(2 * j - 1:2 * j, :) = [v1; v2] * C; 
        points_data_refine(i).Points_3D = C \ points_data(i).Points_3D; 
    end
end

end 