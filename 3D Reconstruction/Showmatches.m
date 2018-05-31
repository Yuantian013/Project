function [good_matches]=Showmatches(f,good_matches,im,which_img)
num_im=size(im,3);
if which_img<=num_im-1
%     [matches,~]=vl_ubcmatch(descriptor{which_img},descriptor{which_img+1},25);
    image1=im(:,:,which_img);
    image2=im(:,:,which_img+1);
    f1=f{which_img};
    f2=f{which_img+1};
    else
%     [matches,~]=vl_ubcmatch(descriptor{which_img},descriptor{1},25);
    image1=im(:,:,which_img);
    image2=im(:,:,1);
    f1=f{which_img};
    f2=f{1};
end
matchPoints_1 = zeros(size(good_matches{which_img},2), 2);
matchPoints_1(:,1) = f1(1,good_matches{which_img}(1,:));
matchPoints_1(:,2) = f1(2,good_matches{which_img}(1,:));
points_1=matchPoints_1;

matchPoints_2 = zeros(size(good_matches{which_img},2), 2);
matchPoints_2(:,1) = f2(1,good_matches{which_img}(2,:));
matchPoints_2(:,2) = f2(2,good_matches{which_img}(2,:));
points_2=matchPoints_2;
%% show matched features
figure(2)
showMatchedFeatures(image1,image2,points_1,points_2,'montage');
end