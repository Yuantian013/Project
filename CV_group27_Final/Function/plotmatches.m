function output_fig=plotmatches(image1,image2,f1,f2,matches);
% it should be fed with two images with same row numbers 
% points are 2 x n vectors, n=point number
% points(1:n) is x coordinates
% points(2:n) is y coordinates
n=size(matches,2);
stitch_image=zeros(size(image1,1),size(image1,2)+size(image2,2));
stitch_image(:,1:size(image1,2),:)=image1;
stitch_image(:,size(image1,2)+1:end,:)=image2;
output_fig=figure(1);
imshow(stitch_image,[]);
hold on;
scatter(f1(1,matches(1,:)),f1(2,matches(1,:)),'g+')
scatter(f2(1,matches(2,:))+size(image1,2),f2(2,matches(2,:)),'yo');
for i=1:n
    plot([f1(1,matches(1,i)),f2(1,matches(2,i))+size(image1,2)],[f1(2,matches(1,i)),f2(2,matches(2,i))],'b--');
end