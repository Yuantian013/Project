function [r,c]=myharris_ScaleInv(im,sigma,threshold)
% inputs: 
% im: double precision grayscale image
% outputs:  The row and column of each point is returned in r and c
% This function finds Harris corners at integration-scale sigma.
% The derivative-scale is chosen automatically as gamma*sigma
if nargin<2
    sigma = [1 5 10];% <---------scales
    threshold = 2e5;% <-----------Set the threshold 
elseif nargin<3
    threshold = 2e5;
end
    gamma = 0.7; % The derivative-scale is gamma times the integration scale
    k=0.05; % Empirically determined constant
    [h,w]=size(im);
    R=zeros(h,w,length(sigma));
    window_size=3;
    
    counter=zeros(h,w);%map maximum points' coordinates
    for s=1:length(sigma)
        % Calculate Gaussian Derivatives at derivative-scale
        % Hint: use your previously implemented function in assignment 1 
        [Ix,Iy]=myGaussGradient(im,sigma(s)*gamma);
        % Allocate an 3-channel image to hold the 3 parameters for each pixel
        M = zeros(size(Ix,1), size(Ix,2), 3);
        % Calculate M for each pixel
        M(:,:,1) = Ix.^2;
        M(:,:,2) = Ix.*Iy;
        M(:,:,3) = Iy.^2;
        % Smooth M with a gaussian at the integration scale sigma.
        M = imfilter(M, fspecial('gaussian', ceil(sigma(s)*6+1), sigma(s)), 'replicate', 'same');
        % Compute the cornerness R
        R(:,:,s)=M(:,:,1).*M(:,:,3)-M(:,:,2).^2-k*(M(:,:,1)+M(:,:,3)).^2;
        % Find local maxima
        % Dilation will alter every pixel except local maxima in a 3x3 square area.
        % Also checks if R is above threshold
        % Display corners
%         figure
%         imshow(R(:,:,s),[]);
        %Return the coordinates
    end
    % search for maximum in scale space
    for i=(window_size-1)/2+1:window_size:floor(h/window_size)*window_size
       for j=(window_size-1)/2+1:window_size:floor(w/window_size)*window_size
            R_window=R(i-(window_size-1)/2:i+(window_size-1)/2,j-(window_size-1)/2:j+(window_size-1)/2,:);
            [max_R,indx]=max(R_window(:));
            [I_row,I_col,I_z]=ind2sub(size(R_window),indx);
            if max_R>threshold
            counter(i-(window_size-1)/2+I_row-1,j-(window_size-1)/2+I_col-1)=1;
            end
       end
    end
    [r,c]=find(counter==1);
end