function [f,d]=Feat_extract_v2(im)
% the input is a (h x w x n) array of n images
% if the image is not single precision, transform them
if ~isa(im,'single')
    im=im2single(im);
    fprintf('Transform images to single precision.\n');
end
num_im=size(im,3);
f=cell(1,num_im);
d=cell(1,num_im);
    for i=1:num_im
        [f{i},d{i}]=vl_sift(im(:,:,i));
        fprintf(['Finish extracting SIFT of ',num2str(i),'th image\n']);
    end
    for i=1:num_im
        feat=loadFeatures(['model_castle_seg_haraff/castle_',num2str(i),'.haraff']);
        [feat_haraff,d_haraff]=covdet(im(:,:,i),'Frames',feat(1:2,:));
        f{i}=[f{i},feat_haraff(1:4,:)];
        d{i}=[d{i},d_haraff];
         fprintf(['Finish extracting ',num2str(i),'th harris-affine and concatenating\n']);
    end
end
