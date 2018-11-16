function figure_common = visualize_CommonPoints(im,M,f,num_common)
if nargin==3
    num_common=3;
end
mask=M~=0;
common_points=sum(mask,1);
[common_row,common_col]=find(common_points>=num_common);
fprintf(['There are ',num2str(length(common_col)),' points seen in at least ',num2str(num_common),' images\n']);
match_indx=M(:,common_col(end));
[row,col]=find(match_indx~=0);
match_indx=match_indx(row,:);
figure_common = figure;
for i=1:length(row)
   subplot(3,ceil(length(row)/3),i);
   imshow(im(:,:,row(i)),[])
   hold on
   plot(f{row(i)}(1,match_indx(i)),f{row(i)}(2,match_indx(i)),'ro');
   title([num2str(row(i)),'th Image']);
   f{row(i)}(1,match_indx(i));
end

end