function [Bags,lab,cluster2dataCell]=extractinstances(im,width)
%%%  Input=[im,width]
%%% 'im' is a set of RGB images SIZE=R*C*3*N
%%% 'width' is a parameter for Mean Shift algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Output=[Features,lab,cluster2dataCell]
%%% 'Bags' is a 1XN cell,in every cell,there is a M*3 vector, M is the
%%% number of instances.
%%% 'lab' is used to visulize the segmentation. SIZE=R*C
%%% 'cluster2dataCell' is using for later exercise.

num_im=size(im,4);                             %Get the number of images
lab=cell(1,num_im);                            %Initialize cell
cluster2dataCell=cell(1,num_im);               %Initialize cell
%-------------------------Loop over all images----------------------------%
for i=1:num_im
    [~,lab{i},cluster2dataCell{i}]=im_meanshift(im(:,:,:,i),width);
    fprintf(['Finish Mean Shift of ',num2str(i),'th image\n']);
end
%--------------------------Extracting features----------------------------%
Bags=cell(1,num_im);
for i=1:num_im
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
        Bags{i}(j,:)=[r,g,b];
    end
    fprintf(['Finish extracting features of ',num2str(i),'th image\n']);
end
end