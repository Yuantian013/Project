function loss=optarget(target)
baglabel=evalin('base','baglabel');
im1=evalin('base','im1');
part1=evalin('base','part1');
im2=evalin('base','im2');
part2=evalin('base','part2');
num_im=60;
Bags1=zeros(60,2);
Bags2=zeros(60,2);
for i=1:num_im
RED=-100000;
YELLOW=-100000;
    %%get the ith image's red/green/blue value and reshape to one row
    imr=reshape(im1(:,:,1,i),[1,numel(im1(:,:,1,i))]);
    img=reshape(im1(:,:,2,i),[1,numel(im1(:,:,2,i))]);
    imb=reshape(im1(:,:,3,i),[1,numel(im1(:,:,3,i))]);
    %%get the number of instances that ith image(bag) has
    num_instance=size(part1{i},1);
    % for every instance of ith image, calculate is average RGB value.
    for j=1:num_instance
        r=sum(imr(part1{i}{j}))/size(part1{i}{j},2);
        g=sum(img(part1{i}{j}))/size(part1{i}{j},2);
        b=sum(imb(part1{i}{j}))/size(part1{i}{j},2);
    % Keep the Most 
        if (target(1:8)*[r^2,g^2,b^2,r*g,r*b,g*b,r*g*b,1]')>RED
           RED=r*r-abs(g*(b-50));
        end
        if (target(9:16)*[r^2,g^2,b^2,r*g,r*b,g*b,r*g*b,1]')>YELLOW
           YELLOW=(target(9:16)*[r^2,g^2,b^2,r*g,r*b,g*b,r*g*b,1]');
        end
    end
    Bags1(i,:)=[RED,YELLOW];
end
for i=1:num_im
RED=-100000;
YELLOW=-100000;
    %%get the ith image's red/green/blue value and reshape to one row
    imr=reshape(im2(:,:,1,i),[1,numel(im2(:,:,1,i))]);
    img=reshape(im2(:,:,2,i),[1,numel(im2(:,:,2,i))]);
    imb=reshape(im2(:,:,3,i),[1,numel(im2(:,:,3,i))]);
    %%get the number of instances that ith image(bag) has
    num_instance=size(part2{i},1);
    % for every instance of ith image, calculate is average RGB value.
    for j=1:num_instance
        r=sum(imr(part2{i}{j}))/size(part2{i}{j},2);
        g=sum(img(part2{i}{j}))/size(part2{i}{j},2);
        b=sum(imb(part2{i}{j}))/size(part2{i}{j},2);
    % Keep the Most 
        if (target(1:8)*[r^2,g^2,b^2,r*g,r*b,g*b,r*g*b,1]')>RED
           RED=r*r-abs(g*(b-50));
        end
        if (target(9:16)*[r^2,g^2,b^2,r*g,r*b,g*b,r*g*b,1]')>YELLOW
           YELLOW=(target(9:16)*[r^2,g^2,b^2,r*g,r*b,g*b,r*g*b,1]');
        end
    end
    Bags2(i,:)=[RED,YELLOW];
end
%% Baged
data_8=Bags1;
data_8(61:120,:)=Bags2;
%%
data_8=prdataset(data_8,baglabel);
%% 
loss=prcrossval(data_8,parzenc);
end