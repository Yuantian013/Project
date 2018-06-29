%DISPN Split dissimilarity matrix in positive and negative part
%
%   [DP,DN,W] = DISPOSNEG(D)
%
% INPUT
%   D   Full, square dissimilarity matrix, dataset or double
% 
% OUTPUT
%   DP  Euclidean distance matrix of the positive PE space
%   DN  Euclidean distance matrix of the negative PE space
%   W   Mapping to PE space
%
% DESCRIPTION
% D is made square (by (D+D')/2) and its diagonal is set to zero. Next a
% pseudo-Euclidean embedding (PE) is made. The positive and negative
% dimensions are separated. In the two resulting space the Euclidean
% distances of the data are found. The following relations hold:
% D.^2 = DP.^2 - DN.^2; NEF(DP) = 0, NEF(DN) = 0; X = D*W;
