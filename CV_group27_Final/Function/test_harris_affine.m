function test_harris_affine(im_color)
num_im = size(im_color,2);

 mkdir('harris_affine_features');
 for i=1:num_im
 which=i;
 file=['model_castle_seg_haraff\castle_',num2str(which),'.haraff'];
 feat=loadFeatures(file);
 fig_out=figure(1)
 imshow(im_color{which})
 hold on
 plot(feat(1,:),feat(2,:),'ro')
 print(fig_out,['harris_affine_features\feature_',num2str(i),'.png'],'-dpng','-r300')
 end
end