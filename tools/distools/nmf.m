%NMF Compute Non-Metricity Fraction of a dissimilarity matrix
%
%   [F,C] = NMF(D,N)
%   [F,C] = D*NMF
%
% INPUT
%   D   - Dissimilarity matrix or dataset
%   N   - Scalar integer for a fast estimation of F from N random
%         triangles. Default: use all.
%
% OUTPUT
%   F   - Non-metricity fraction
%   C   - Constant to make F=0, if added to the off-diagonal elements of D.
%
% DESCRIPTION
% This routine counts the number of triangle inequality violations D to
% estimate the NEF of D. If D is asymmetric, it is made symmetric by 
% averaging. F is the fraction of violating inequalities. Hence, for F = 0, 
% the triangle inequality holds for all triplets of the objects that
% construct the distance matrix D. 
%
% Additionally, a constant C is determined, which when added to the
% off-diagonal elements of D will take care that F = 0:
%
% If N is given, a random NxN subset of D is taken to speed up and F is an
% estimate. N=100 yields already a reasonably fast and accurate estimate.
