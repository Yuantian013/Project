function visualize_F(F,im,which_img)
figure
leftImg=imshow(im(:,:,which_img),[]);
A=ginput; 
epiline=epipolar(im(:,:,which_img+1),A,F(:,:,which_img));
imshow(epiline,[]);
end