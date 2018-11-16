function surf_3D_PCL(points_first_frame, points_color_map)
points_first_frame=round(3e2*points_first_frame);
x_max=max(points_first_frame(:,1));
x_min=min(points_first_frame(:,1));
y_max=max(points_first_frame(:,2));
y_min=min(points_first_frame(:,2));
x=x_min:2:x_max;
y=y_min:2:y_max;
[X,Y]=meshgrid(x,y);
C = zeros(size(X,1),size(X,2), 3);
Z=min(points_first_frame(:,3))*ones(length(y),length(x));
num_points=size(points_first_frame,1);
for i=1:num_points
    row=find(y==points_first_frame(i,2));
    col=find(x==points_first_frame(i,1));
    Z(row,col)=points_first_frame(i,3);
    C(row,col,1)=points_color_map{1}(i,1)/255;
    C(row,col,2)=points_color_map{1}(i,2)/255;
    C(row,col,3)=points_color_map{1}(i,3)/255;
end
surf(X,Y,Z,C);

end