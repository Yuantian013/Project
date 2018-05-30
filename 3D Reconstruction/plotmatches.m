function plotmatches(image1,image2,points1,points2);
% it should be fed with two images with same row numbers 
% points are 2 x n vectors, n=point number
% points(1:n) is x coordinates
% points(2:n) is y coordinates
n=size(points1,2);
stitch_image=zeros(size(image1,1),size(image1,2)+size(image2,2));
stitch_image(:,1:size(image1,2))=image1;
stitch_image(:,size(image1,2)+1:end)=image2;
figure;
imshow(stitch_image,[]);
hold on;
scatter(points1(1,:),points1(2,:),'g+')
scatter(points2(1,:)+size(image1,2),points2(2,:),'yo');
for i=1:n
    plot([points1(1,i),points2(1,i)+size(image1,2)],[points1(2,i),points2(2,i)],'b--');
end