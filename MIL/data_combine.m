function im_com=data_combine(im)
num_im=size(im,4);
for i=1:num_im
    test=rgb2gray(im(:,:,:,i));
    test=reshape(test,[1,2028]);
    im_com(i,:)=test;
end
end