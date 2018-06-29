%DISCHECK Dissimilarity Matrix Check
%
%   N = DISCHECK(D)
%         OR
%   N = DISCHECK(D,LABLIST,FLAG)
%
% INPUT
%   D       NxN dissimilarity matrix or dataset
%   LABLIST List of labels
%   FLAG    0 - check square dissimilarity matrix
%           1 - check square similarity matrix
%
% OUTPUT
%   N      1/0 if D is/isnot a proper dissimilarity matrix
%
% DESCRIPTION
% Returns error if 
% 	- D is not a square dissimilarity matrix with feature labels 
% 		equal to object labels or feature labels of D are not in LABLIST.
% 	- FLAG==0 & there are non-zero elements on the diagonal of D
% 	- FLAG==0 & there are negative values in D
%
