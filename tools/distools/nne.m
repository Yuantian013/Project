%NNE Leave-one-out Nearest Neighbor Error on a Dissimilarity Matrix
%
%   [E,LAB] = NNE(D)
%   {E,LAB] = D*NNE
%
% INPUT
%   D   NxN symmetric dissimilarity dataset
%
% OUTPUT
%   E   Leave-one-out error
%   LAB Nearest neighbor labels
%
% DESCRIPTION
% Estimates the leave-one-out error of the 1-nearest neighbor rule
% on the square dissimilairy data D. D should be a dataset containing a
% labeled square dissimilarity matrix of a set of objects related to
% itself. Diagonal of D is assumed to be zero.
% It is not needed that D is symmetric. So NNE(D) ~= NNE(D') is possible.
%
% SEE ALSO
% DATASETS, NNERROR1, NNERROR2, TESTKD
