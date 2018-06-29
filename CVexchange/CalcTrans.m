function transform=CalcTrans(points_data)
num_set=size(points_data,1);
transform=cell(num_set-1,1);

for i=1:num_set-1
    [~,indx_current,indx_next]=intersect(points_data(i).PointsIndx,points_data(i+1).PointsIndx);
    points_current=points_data(i).Points_3D(:,indx_current);
    points_next=points_data(i+1).Points_3D(:,indx_next);
    [transform{i}]=my_procrustes_v2(points_current',points_next');
    
end
end