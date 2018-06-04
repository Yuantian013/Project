function [cluster2dataCell,lab]=extractinstances(im,width)
num_im=size(im,4);
lab=cell(1,num_im);
cluster2dataCell=cell(1,num_im);
for i=1:num_im
    [~,lab{i},cluster2dataCell{i}]=im_meanshift(im(:,:,:,i),width);
    fprintf(['Finish extracting ',num2str(i),'th image\n']);
end
end