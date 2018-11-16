function test_harris(im_color, im)

sigma=[1:4:20];
threshold=2e5;
[r,c]=myharris_ScaleInv(im(:,:,1),sigma,threshold);
fig_out=figure
imshow(im_color{1})
 hold on
 plot(c,r,'+r');
 print(fig_out,['harris_',num2str(threshold),'threshold.png'],'-dpng','-r300');
end