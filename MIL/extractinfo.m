function [info]=extractinfo(part,im)
num_im=size(im,4);
info=cell(1,num_im);
for i=1:num_im
    imr=reshape(im(:,:,1,i),[1,numel(im(:,:,1,i))]);%%get the ith image's red value and reshape to one row
    img=reshape(im(:,:,2,i),[1,numel(im(:,:,2,i))]);%%get the ith image's green value and reshape to one row
    imb=reshape(im(:,:,3,i),[1,numel(im(:,:,3,i))]);%%get the ith image's blue value and reshape to one row
    num_instance=size(part{i},1);%%get the number of instances that ith image(bag) has
    % for every instance of ith image, calculate is average RGB value.
    for j=1:num_instance
        r=sum(imr(part{i}{j}))/size(part{i}{j},2);%%
        g=sum(img(part{i}{j}))/size(part{i}{j},2);
        b=sum(imb(part{i}{j}))/size(part{i}{j},2);
        info{i}(j,:)=[r,g,b];
    end
    fprintf(['Finish extracting ',num2str(i),'th image\n']);
end
end