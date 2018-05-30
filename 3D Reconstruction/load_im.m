function [im,Num_f]=load_im(im_folder,only_foreground,threshold)
    %this function return a h x w x n array containing grayscale n images
    %in the folder 'foldername'
    if nargin==1
        only_foreground=0;
    end
    if nargin==2
        threshold=25;
    end
    subfolder = @(base, sub) [base '/' sub];
    merge_file = @(dir) subfolder(dir.folder, dir.name);
    im_files=dir(fullfile(im_folder,'*.jpg'));
    Num_f=size(im_files,1);
    for i = 1:Num_f       
        im(:,:,i) = double(rgb2gray(imread(merge_file(im_files(i)))));
    	fprintf(['Finish loading ',num2str(i),'th images.\n']);
    end
    [h,w]=size(im(:,:,1));
    tranch=floor(h/4);
    trancw=floor(w/4);
    im=im(tranch*2/3:h-tranch,trancw:w-trancw,:);%%²Ã¼ôÍ¼Æ¬
    if only_foreground==1
    im_back=mean(im,3); % get the average image as the background
    threshold=25;
    % background subtraction
    mask=im-im_back>threshold;
    im=im.*mask;
    end
end
