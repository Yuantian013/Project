function [im,Num_f,im_color]=load_im_v2(im_folder,only_foreground,loadlab)
    %this function return a h x w x n array containing grayscale n images
    %in the folder 'foldername'
    if nargin==1
        only_foreground=0;
        loadlab=[];
    end
    if nargin==2
        loadlab=[];
    end
    subfolder = @(base, sub) [base '/' sub];
    merge_file = @(dir) subfolder(dir.folder, dir.name);
    im_files=dir(fullfile(im_folder,'*.JPG'));
    Num_f=size(im_files,1);
    im_color=cell(1,Num_f);
    bandwidth=[105,101,105,110,105,100,100,90,85,85,85,80,60,65,75,85,90,100,105];
    for i = 1:Num_f
        im_color{i}=imread(merge_file(im_files(i)));
        im(:,:,i) = rgb2gray(im_color{i});
    	fprintf(['Finish loading ',num2str(i),'th images.\n']);
    end
    if only_foreground==1&&isempty(loadlab)
    for i=1:Num_f
        lab=im_meanshift(im_color{i},bandwidth(i));
        num_1=sum(sum(lab==1));
        num_2=sum(sum(lab==2));
        if num_2>num_1
            back=2;
        else
            back=1;
        end
        im_seg=im_color{i}.*uint8(repmat((lab~=back),[1 1 3]));
        im_color{i}=im_seg;
        im(:,:,i)=im(:,:,i).*uint8(lab~=1);
        fprintf(['Finish segmentation of ',num2str(i),'th images.\n']);
    end
    elseif only_foreground==1
        lab=loadlab;
    for i=1:Num_f        
        im_seg=im_color{i}.*uint8(repmat((lab{i}~=1),[1 1 3]));
        im_color{i}=im_seg;
        im(:,:,i)=im(:,:,i).*uint8(lab{i}~=1);
        fprintf(['Finish segmentation of ',num2str(i),'th images.\n']);
    end
    end
    
end
