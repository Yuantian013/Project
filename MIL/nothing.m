function [Bags]=extractinstances(im,width)
%%%  Input=[im,width]
%%% 'im' is a set of RGB images SIZE=R*C*3*N
%%% 'width' is a parameter for Mean Shift algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Output=[Bags]
%%% 'Bags' is a Nx2 matrix
num_im=size(im,4);                             %Get the number of images
lab=cell(1,num_im);                            %Initialize cell
cluster2dataCell=cell(1,num_im);               %Initialize cell
%-------------------------Loop over all images----------------------------%
for i=1:num_im
    [~,lab{i},cluster2dataCell{i}]=im_meanshift(im(:,:,:,i),width);
    fprintf(['Finish Mean Shift of ',num2str(i),'th image\n']);
end
%--------------------------Extracting features----------------------------%
Bags=zeros(num_im,2);
for i=1:num_im
    RED=-100000;
    YELLOW=-100000;
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
        % Update the largest red rate
        if r*r-g*b>RED
            RED=r*r-g*b;
        end
        % Update the largest yellow rate
        if r*g-b*b>YELLOW
            YELLOW=r*g-b*b;
        end
    end
    Bags(i,:)=[RED,YELLOW];
    fprintf(['Finish extracting features of ',num2str(i),'th image\n']);
end
end