%MAKESYM Make a dissimilarity matrix symmetric
%
%   [B,C] = MAKESYM(A,PROC)
%   [B,C] = A*MAKESYM(PROC)
%
% INPUT
%   A     Square dataset or matrix
%   PROC  String with procedure: 'average' (default), 'min', 'max',
%         'lower' (use lower triangle part) or 'upper' (user upper part).
%
% OUTPUT
%   B   Symmetric dataset or matrix computed as (A+A')/2
%   C   Asymmetric remaining part, dataset or matrix computed as (A-A')/2
%
% DESCRIPTION
% B is a symmetric matrix obtained combining A and A' by PROC.
%
%SEE ALSO
%DATASETS, ISSYM, ISSQUARE
