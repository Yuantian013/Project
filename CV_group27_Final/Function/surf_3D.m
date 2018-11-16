function [] = surf_3D(points,X_width,Y_width,RGB)
% Usage: 3D surf plot
% points is a 3-by-N matrix
%remove isolated points
mean_Z=mean(points(3,:));
std_Z=std(points(3,:));
indices_remove=[];
for i=1:size(points,2)
    if abs(points(3,i)-mean_Z)>3*std_Z
        indices_remove=[indices_remove i];
    end
end
points(:,indices_remove)=[];

%surf plot
max_value=max(points,2);
min_value=min(points,2);
X=min_value(1):X_width:max_value(1);
Y=min_value(2):Y_width:max_value(2);
[mesh_x,mesh_y]=meshgrid(X,Y);
Z=zeros(size(mesh_x));
C=255*ones(size(mesh_x,1),size(mesh_x,2),3);
for i=X
    mask_x=points(1,:)>=i&points(1,:)<(i+X_width);
    for j=Y
        mask_y=points(2,:)>=j&points(2,:)<(j+Y_width);
        indices=mask_x&mask_y;
        if max(abs(points(3,indices)))
            temp=points(3,:);
            temp(~indices)=0;
            [~,I]=max(abs(temp));
            Z(j==Y,i==X)=temp(I);
            C(j==Y,i==X,:)=RGB(I,:);
        end
    end
end
h=surf(mesh_x,mesh_y,Z,C);
% set(h,'LineStyle','none')
end

