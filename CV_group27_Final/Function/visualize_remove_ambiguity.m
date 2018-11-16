function visualize_remove_ambiguity(points_data, points_data_refine, cmp_group, cmp_pose)
figure 
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
title([num2str(cmp_pose),'th Pose of group ',num2str(cmp_group)])

end
