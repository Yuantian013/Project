function figure_3D_surf = surf_3D_PCL_v2(points, points_color_map)

X_width = 5;
Y_width = 5;

%surf plot
max_value=max(points,[],1);
min_value=min(points,[],1);
X=min_value(1):X_width:max_value(1);
Y=min_value(2):Y_width:max_value(2);
[mesh_x,mesh_y]=meshgrid(X,Y);
Z=zeros(size(mesh_x));
C=255*ones(size(mesh_x,1),size(mesh_x,2),3);
for i=X
    mask_x=points(:, 1)>=i&points(:,1)<(i+X_width);
    for j=Y
        mask_y=points(:, 2)>=j&points(:, 2)<(j+Y_width);
        indices=mask_x&mask_y;
        if max(abs(points(indices, 3)))
            temp=points(:,3);
            temp(~indices)=0;
            [~,I]=max(abs(temp));
            Z(j==Y,i==X)=temp(I);
            C(j==Y,i==X,:)=points_color_map(I,:);
        end
    end
end
Z=Z-min(min(Z));
mean_Z=mean(mean(Z));
Z(Z<mean_Z)=2*mean_Z-Z(Z<mean_Z);
% surf(Z,C./255,'EdgeColor','none','FaceColor','interp');
figure_3D_surf = figure;
surf(Z,C./255,'EdgeColor','none');
colorbar
end

