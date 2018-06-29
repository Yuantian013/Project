%NNERROR2 Exact expected NN error from a dissimilarity matrix (2)
%
%   E = NNERROR2(D,M)
%   E = D*NNERROR2([],M)
%
% INPUT
%   D 	NxN dissimilarity dataset
%   M 	Vector with desired number of objects per class to be selected
%
% OUTPUT
%   E 	Expected NN errror
%
% DESCRIPTION
% Exact computation of the expected 1-nearest neighbor error. D should be a
% dataset containing a labeled square dissimilarity matrix of a set of
% objects related to itself. It is not needed that D is symmetric.
% So NNERROR2(D) ~= NNERROR2(D') is possible.
%
%   E = NNERROR2(D)
%   E = D*NNERROR2
%
% In this case a set of training set sizes is used to produce a full
% learning curve. E can be plotted by PLOTE.
%
% There is a similar routine NNERROR1 which is based on the random
% selection of objects, instead of class-wise.
%
% SEE ALSO
% DATASETS, NNERROR1, NNE, TESTKD
