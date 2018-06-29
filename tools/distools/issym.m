%ISSYM Check whether a Matrix is Symmetric
%
%   OK = ISSYM(A,DELTA)
%
% INPUT
%   A      Dataset
%   DELTA  Parameter for the precision check (optional; default: 1e-13)
%
% OUTPUT
%   OK     1 if the matrix A is symmetric and error otherwise.
%
% DESCRIPTION
% A is considered as a symmetric matrix, when it is square and
% max(max(A-A')) is smaller than DELTA.
%
