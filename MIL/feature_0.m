function Bags=feature_8(cluster2dataCell,im)
num_im=size(im,4);
Bags=zeros(num_im,2);
for i=1:num_im
RED=100000;
YELLOW=100000;
    %%get the ith image's red/green/blue value and reshape to one row
    imr=reshape(im(:,:,1,i),[1,numel(im(:,:,1,i))]);
    img=reshape(im(:,:,2,i),[1,numel(im(:,:,2,i))]);
    imb=reshape(im(:,:,3,i),[1,numel(im(:,:,3,i))]);
    %%get the number of instances that ith image(bag) has
    num_instance=size(cluster2dataCell{i},1);
    % for every instance of ith image, calculate is average RGB value.
    for j=1:num_instance
        r=sum(imr(cluster2dataCell{i}{j}))/size(cluster2dataCell{i}{j},2);
        g=sum(img(cluster2dataCell{i}{j}))/size(cluster2dataCell{i}{j},2);
        b=sum(imb(cluster2dataCell{i}{j}))/size(cluster2dataCell{i}{j},2);
    % Keep the Most 
        if (r-255)^2+(g-5)^2+(b-10)^2<RED
           RED=(r-255)^2+(g-5)^2+(b-10)^2;
        end
        if (r-220)^2+(g-225)^2+(b-225)^2<YELLOW
           YELLOW=(r-220)^2+(g-225)^2+(b-225)^2;
        end
    end
    Bags(i,:)=[RED,YELLOW];
    fprintf(['Finish extracting features of ',num2str(i),'th image\n']);
end
end