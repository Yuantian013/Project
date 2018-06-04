function [im,Num_f]=loadimage_MIL(im_folder)
    subfolder = @(base, sub) [base '/' sub];
    merge_file = @(dir) subfolder(dir.folder, dir.name);
    im_files=dir(fullfile(im_folder,'*.jpg'));
    Num_f=size(im_files,1);
    for i = 1:Num_f       
        im(:,:,:,i) = imread(merge_file(im_files(i)));
    	fprintf(['Finish loading ',num2str(i),'th images.\n']);
    end
end
