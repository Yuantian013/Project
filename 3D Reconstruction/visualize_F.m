function visualize_F(F,im,which_img)
figure(1)
subplot(1,2,1)
leftImg=imshow(im(:,:,which_img),[]);
hold on
A=ginput;
scatter(A(:,1),A(:,2))
epiline=epipolar(im(:,:,which_img+1),A,F(:,:,which_img));
subplot(1,2,2)
imshow(epiline,[]);
end