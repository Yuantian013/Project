%SELDCLASS Select class subset from a square dissimilarity dataset
%
%   [DN,J] = SELDCLASS(D,C)
%   [DN,J] = D*SELDCLASS([],C)
%
% INPUT
%   A   NxN Dissimilarity Dataset
%   C   Indices of classes
%
% OUTPUT
%   DN  Subset of the dataset D
%   J   Indices of the selected objects
%
% DESCRIPTION
% The classes listed in C (indices) are extracted for the square
% dissimilarity matrix D by both, their rows (objects) as well as their
% columns (features). The indices in C refer to the label lis of D, to be
% retrieved by GETLABLIST(D).
%
% SEE ALSO
% DATASETS, SELCLASS, GETLABLIST, ISSQUARE, MAKESQUARE
