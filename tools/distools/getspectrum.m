%GETSPECTRUM Retrieve spectrum form pseudo-Euclidean (PE) mapping
%
%   SPEC = GETSPECTRUM(W)
%   SPEC = W*GETSPECTRUM
%   SPEC = GETSPECTRUM(A)
%   SPEC = A*GETSPECTRUM
%
% INPUT
%   W     Pseudo-Euclidean mapping, W = PE_EM(D), 
%         if D is a dissimilarity matrix
%   A     Pseudo-Euclidean dataset
%
% OUTPUT 
%   SPEC  Spectrum of PE mapping (PE_EM), ranked from most positive to most
%         negative
%
% DESCRIPTION
% The spectrum of a PE mapping is defined as the sorted set of eigenvalues
% (from most positive to most negative) that are computed during the
% training of the PE mapping by PE_EM. Note that the order of the features
% of W and A may be different.
%
% SEE ALSO
% DATASETS, MAPPINGS, PE_EM, PLOTSPECTRUM
