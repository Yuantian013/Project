%INTRDIM Estimate Intrinsic dimension from dissimilarity data
%
%   K = INTRDIM(D)
%   K = D*INTRDIM
%
% INPUT
%   D	  NxN Dissimilarity dataset
%
% OUTPUT
%   K	  Estimated intrinsic dimension
%
% DESCRIPTION
% It is assumed that the data is generated from a normal distribution in
% K dimensions and that the Euclidean distance measure has been used to
% compute D. 
% Do NOT supply squared distances! They will definitely generate the wrong
% result.
%
% EXAMPLE
% A = GENDATB(100);
% D = SQRT(DISTM(A));
% K = INTRDIM(D);
%
% A = GENDATD(100,10);
% D = SQRT(DISTM(A*SCALEM(A,'VARIANCE')));
% K = INTRDIM(D);
