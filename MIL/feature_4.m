function Bags=feature_4(cluster2dataCell,im)
num_im=size(im,4);
Bags=zeros(num_im,4);
for i=1:num_im
feature1=-100000;
feature2=-100000;
feature3=-100000;
feature4=-100000;
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
        if r*r-abs((g-200)*(b-180))>feature1
           feature1=r*r-abs((g-200)*(b-180));
        end
        if g^2-(b-r-30)-b*r>feature2
           feature2=g^2-(b-r-30)-b*r;
        end
        if r*r-abs(g*(b-50))>feature3
           feature3=r*r-abs(g*(b-50));
        end
        if r*g-(b*b)-abs(r-g-30)*abs(g-b-70)>feature4
           feature4=r*g-(b*b)-abs(r-g-30)*abs(g-b-70);
        end
    end
    Bags(i,:)=[feature1,feature2,feature3,feature4];
    fprintf(['Finish extracting features of ',num2str(i),'th image\n']);
end
end