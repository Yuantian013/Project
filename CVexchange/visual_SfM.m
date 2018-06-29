function [figure1,figure2]=visual_SfM(vis,points_data,im_color)
num_im_per_set=size(points_data(1).Pose,1)/2;
len=5e-2; 
 
figure1=figure(1);
for i=1:num_im_per_set
    subplot(1,num_im_per_set,i)
    imshow(im_color{vis+i-1});
    hold on
    plot(points_data(vis).Points_2D(2*i-1,:),points_data(vis).Points_2D(2*i,:),'ro')
    r=points_data(vis).Pose(2*i-1:2*i,:)*points_data(vis).Points_3D+points_data(vis).mean_meas(2*i-1:2*i,:);
    plot(r(1,:),r(2,:),'bo');
    legend('Original Points','Reprojectrion Points');
end


figure2=figure;
for i=1:num_im_per_set
plot3(len*[points_data(vis).Pose(2*i-1,1),0,points_data(vis).Pose(2*i,1)],...
    len*[points_data(vis).Pose(2*i-1,2),0,points_data(vis).Pose(2*i,2)],...
    len*[points_data(vis).Pose(2*i-1,3),0,points_data(vis).Pose(2*i,3)],'Linewidth',1);
hold on
end
grid on
pcshow(points_data(vis).Points_3D',points_data(vis).color,'MarkerSize',100);
end