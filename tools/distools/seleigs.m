%SELEIGS Select eigenvalues from a list
%
%   J = SELEIGS(L,ALF)
%
% INPUT
%   L   List of eigenvalues
%   ALF Parameter determining the dimensionality and the eigenvalue-based mapping
%       (0,1)   - fraction of the total (absolute value) preserved variance
%        Inf    - no dimensionality reduction, keeping all dimensions (it's noisy)
%       'p'     - projection into a Euclidean space based on positive eigenvalues only
%       'PARp'  - projection into a Euclidean space based on the PAR fraction of
%                 positive eigenvalues; e.g. ALF = '0.9p'
%       'n'     - projection into a Euclidean space based on negative eigenvalues only
%       'PARn'  - projection into a (negative) Euclidean space based on the PAR fraction
%                 of negative eigenvalues; e.g. ALF = '0.7n'
%       'P1pP2n'- projection into a Euclidean space based on the P1 positive eigenvalues
%                 and P2 negative eigenvalues; e.g. ALF = '0.7p0.1n', ALF = '7p2n'
%       1 .. N  - number of dimensions in total
%       [P1 P2] - P1 dimensions or preserved fraction of variance in the positive subspace
%                 and P2 dimensions or preserved fraction of variance in the negative
%                 subspace; e.g. ALF = [5 10], ALF = [0.9 0.1]
%
% OUTPUT
%   J   Index of selected eigenvalues
%
% DESCRIPTION
% This is a low-level routine for PSEM, KPSEM, KPCA and PEPCA. From a list of
% eigenvalues it selects the ones according to ALF.
%
% SEE ALSO
% MAPPINGS, DATASETS, PSEM, KPSEM, KPCA, PEPCA
%
