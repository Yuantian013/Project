function visualize_CommonPoints(im,M,f)

mask=M~=0;
common_points=sum(mask,1);
max(common_points)
[common_row,common_col]=find(common_points==5);
match_indx=M(:,common_col(1));
[row,col]=find(match_indx~=0);
match_indx=match_indx(row,:);
for i=1:length(row)
   figure
   imshow(im(:,:,row(i)),[])
   hold on
   plot(f{row(i)}(1,match_indx(i)),f{row(i)}(2,match_indx(i)),'ro');
   f{row(i)}(1,match_indx(i));
end

end