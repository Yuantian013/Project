function figure_reprojection = visual_reprojection(points_data, group, image, im_color)

    figure_reprojection = figure;
    imshow(im_color{(group-1)*3+image});
    hold on
    plot(points_data(group).Points_2D(2*image-1,:),points_data(group).Points_2D(2*image,:),'r*')
    r=points_data(group).Pose(2*image-1:2*image,:)*points_data(group).Points_3D+points_data(group).mean_meas(2*image-1:2*image,:);
    plot(r(1,:),r(2,:),'g+');
    legend('Original Points','Reprojectrion Points');

end