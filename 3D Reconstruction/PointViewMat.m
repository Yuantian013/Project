function M=PointViewMat(good_matches)
% This function constructs a point-view matrix using good_matches
% from each two consecutive images
% good_matches: 1 X n cell containing good matches between the current 
% image and the next image, the last good_matches is the mathces between
% the last and the first image. The component is matrix with 2 row, the
% 1st row is the matches of current image, the 2nd row is the matches of
% the next image
% output: Point-view matrix M
num_im=size(good_matches,2);
M=zeros(num_im+1,1e5);
M(1,1:size(good_matches{1},2))=good_matches{1}(1,:);

for i=1:num_im
    % when i=num_im, the first row of good_matches{num_im} is the matches
    % of the last image,the second row of good_matches{num_im} is the
    % matches of the first image
    current_matches=good_matches{i}(1,:);
    new_matches=good_matches{i}(2,:);
    % find intersection of two matches  
    [~,Ia,Ib]=intersect(current_matches,M(i,:));
    fprintf(['Number of common matches: ',num2str(length(Ia)),'\n'])
    M(i+1,Ib)=new_matches(Ia);
    % find unprecedented matches
    new_matches(Ia)=0;
    current_matches(Ia)=0;
    new_matches_left=new_matches(new_matches~=0);
    current_matches_left=current_matches(current_matches~=0);
    length_new=length(new_matches_left);
    % append unprecedented matches
    [~,indx_largest_M]=find(M(i,:),1,'last');
    % add new matches to M
    if i<=num_im
    M(i+1,indx_largest_M+1:indx_largest_M+length_new)=new_matches_left;
    M(i,indx_largest_M+1:indx_largest_M+length_new)=current_matches_left;
    else
        [~,Ia1,Ib1]=intersect(new_matches_left,M(1,:));
        % move the points existing in the first frame that also match the
        % last frame under the allocated points of the first frame
        M(i,Ib1)=current_matches_left(Ia1);
        
            new_matches_left(Ia1)=0;
            current_matches_left(Ia1)=0;
            new_matches_left=new_matches_left(new_matches_left~=0);
            current_matches_left=current_matches_left(current_matches_left~=0);
        
        M(i+1,indx_largest_M+1:indx_largest_M+length(new_matchse_left))=new_matches_left;
        M(i,indx_largest_M+1:indx_largest_M+length(new_matchse_left))=current_matches_left;
    end
    M(i,indx_largest_M+1:indx_largest_M+length_new)=current_matches_left;
    % update previous matches
    fprintf(['Finished ',num2str(i),'th point-view \n'])
end
indx_largest_M=max(find(M(end,:),1,'last'));
M=M(:,1:indx_largest_M);
end