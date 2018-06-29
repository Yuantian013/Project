% this function find an epipolar given coordinates in one images 
% and image from the other camera
% we can tune the thickness of the epipolar line by tuning ub and lb
function [epipline]=epipolar(image,coord,F)
num=size(coord,1); % the number of coordinates
iter=num;       
x=1:size(image,2);  % the width of the image
y=1:size(image,1);  % the height of the image
[X,Y]=meshgrid(x,y); % use vectorized method
ub=0.005;     %<----------set the upper bound
lb=-0.005;    %<----------set the lower bound
for i=1:iter
    A=F*[coord(i,:),1]'; % fundamental matrix multiplied by augmented vector
    B=X.*A(1)+Y.*A(2)+ones(size(image,1),size(image,2)).*A(3); % calculate the value of the constraints for every point
    [row,col]=find((B<=ub)&(B>=lb));   % find the pixel whose value is within the upper and lower bound 
    for j=1:size(row,1)        % draw the epipolar line
        vertical=row(j);
        horizontal=col(j);
        image(vertical,horizontal,:)=0;
    end
end
epipline=image;
end