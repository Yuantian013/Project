%NNERROR1 Exact expected NN error from a dissimilarity matrix (1)
%
%   E = NNERROR1(D,M)
%   E = D*NNERROR1([],M)
%
% INPUT
%   D 	NxN dissimilarity dataset
%   M 	Vector with desired number of objects to be selected
%
% OUTPUT
%   E 	Expected NN errror
%
% DESCRIPTION
% Exact computation of the expected 1-nearest neighbor error. D should be a
% dataset containing a labeled square dissimilarity matrix of a set of
% objects related to itself. It is not needed that D is symmetric.
% So NNERROR1(D) ~= NNERROR1(D') is possible.
%
%   E = NNERROR1(D)
%   E = D*NNERROR1
%
% In this case a set of training set sizes is used to produce a full
% learning curve. E can be plotted by PLOTE.
%
% There is a similar routine NNERROR2 which is based on the selection of an
% equal number of objects per class.
%
% SEE ALSO
% DATASETS, NNERROR2, NNE, TESTKD
