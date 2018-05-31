function [good_matches,F_best]=For15(f,descriptor,iter,num_seed)
% normalized eight-point algorithm with RANSAC
% output foundamental matrix F_best and good matches
% ----------------input--------------------------
% f:1 X n cell containing features in each image
% d:1 X n cell containing descriptors in each image
% iter: iteration times for RANSAC, default value is 1000
% num_seed: number of random points in RANSAC, default value is 20
%-----------------output--------------------------
% good_matches: 1 X n cell containing good matches between the current
% image and the next image, the last good_matches is the mathces between
% the last and the first image. The component is matrix with 2 row, the
% 1st row is the matches of current image, the 2nd row is the matches of
% the next image
% F_best is a 3 X 3 X n array containing n foundamental matrix between
% current image and the next image
fprintf('Start 8-point RANSAC...\n');
if nargin==2
    iter=10000;    %iteration times of RANSAC
    num_seed=20; % number of seeds
end
if nargin==3
    num_seed=20;
end
num_im=size(f,2);
F_best=zeros(3,3,num_im);%%
good_matches=cell(1,num_im);
j=15;
   [matches,~]=vl_ubcmatch(descriptor{15},descriptor{16});
threshold=2;
    fprintf(['Number of matched points: ',num2str(size(matches,2)),'\n'])
DIST=100000;
    for i=1:iter
        % randomly selected
        num_matches=size(matches,2);%number of matches
        indx_all=randperm(num_matches);%随机排列1-number个数字
        indx=indx_all(1:num_seed);%选前20个
        points1=f{j}(1:2,matches(1,indx)); % get random points in frame1
        if j<=num_im-1
            points2=f{j+1}(1:2,matches(2,indx)); % get random points in frame2
        else
            points2=f{1}(1:2,matches(2,indx));
        end
        % normalize the points
        mx1=mean(points1(1,:));
        my1=mean(points1(2,:));
        mx2=mean(points2(1,:));
        my2=mean(points2(2,:));
        %求d
        d_norm1=mean(sqrt((points1(1,:)-mx1).^2+(points1(2,:)-my1).^2));
        d_norm2=mean(sqrt((points2(1,:)-mx2).^2+(points2(2,:)-my2).^2));
        T1=[sqrt(2)/d_norm1, 0, -mx1*sqrt(2)/d_norm1;
            0, sqrt(2)/d_norm2, -my1*sqrt(2)/d_norm1;
            0, 0, 1];
        T2=[sqrt(2)/d_norm2, 0, -mx2*sqrt(2)/d_norm2;
            0, sqrt(2)/d_norm2, -my2*sqrt(2)/d_norm2;
            0, 0, 1];
        % 加了一行1
        points1_aug=[points1;ones(1,size(points1,2))];
        points2_aug=[points2;ones(1,size(points2,2))];
        % ^p^
        points1_norm=T1*points1_aug;
        points2_norm=T2*points2_aug;
        % normalized eight points algorithm
        % 1. construct A matrix
        A=zeros(num_seed,9);
        A(:,1)=points1_norm(1,:)'.*points2_norm(1,:)';
        A(:,2)=points1_norm(2,:)'.*points2_norm(1,:)';
        A(:,3)=points2_norm(1,:)';
        A(:,4)=points1_norm(1,:)'.*points2_norm(2,:)';
        A(:,5)=points2_norm(2,:)'.*points2_norm(2,:)';
        A(:,6)=points2_norm(2,:)';
        A(:,7)=points1_norm(1,:)';
        A(:,8)=points1_norm(2,:)';
        A(:,9)=1;
        % 2. compute foundamental matrix
        [~,~,V]=svd(A);
        %get F? from the last column of V in the SVD of A
        F_norm=reshape(V(:,end),[3 3])';
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        F_norm=F_norm/norm(F_norm);
        % 2.1 enforce singularity
        [Uf,Df,Vf]=svd(F_norm);%D是对角阵，而且是按大小排序的，为什么是3x3
        indx_Df=size(Df,2);
        Df(indx_Df,indx_Df)=0;
        F_norm=Uf*Df*Vf';
        F=T2'*F_norm*T1;%********************88
        % 3. find inliers
        % 3.1 calculate Sampson distance
        dist=SampsonDist(F,points1,points2);
        indx_good_matches=dist<threshold;%返回的是logic数字 1/0 是不是inlier
        SumDist=sum(dist);
        % update best-fitted model
        if SumDist<DIST
            %             max_num_inliers=num_inliers;
            DIST=SumDist;
            F_best(:,:,j)=F;
        end
    end
    
    %% 每两张图间选出最好的F后
    points1_all=f{j}(1:2,matches(1,:));
    if j<=num_im-1
        points2_all=f{j+1}(1:2,matches(2,:));
    else
        points2_all=f{1}(1:2,matches(2,:));
    end
    d_all=SampsonDist(F_best(:,:,j),points1_all,points2_all);
    % if wanting the exact index of inliers, use find(d_all<threshold)
    indx_good_all=find(d_all<10);
    %     inliers1=points1_all(:,indx_good_all);
    %     inliers2=points2_all(:,indx_good_all);
    good_matches{j}(1,:)=matches(1,indx_good_all);
    good_matches{j}(2,:)=matches(2,indx_good_all);
    fprintf('Finished...\n');
end
