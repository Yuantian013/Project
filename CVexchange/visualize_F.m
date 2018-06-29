function visualize_F(F,im,which_img)
num_im=size(im,3);
figure
leftImg=imshow(im(:,:,which_img),[]);
A=ginput; 
hold on 
plot(A(:,1),A(:,2),'ro','MarkerFaceColor','r');
if which_img<num_im
epiline=epipolar(im(:,:,which_img+1),A,F(:,:,which_img));
else
    epiline=epipolar(im(:,:,1),A,F(:,:,which_img));
end
figure
imshow(epiline,[]);
end