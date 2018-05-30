function [f,d]=Feat_extract(im)
if ~isa(im,'single')
    im=im2single(im);
    fprintf('Transform images to single precision.\n');
end
num_im=size(im,3);%im的第三列表示的图像号数
f=cell(1,num_im);
d=cell(1,num_im);
for i=1:num_im
    [f{i},d{i}]=vl_sift(im(:,:,i));
    fprintf(['Finish extracting ',num2str(i),'th image\n']);
end
end