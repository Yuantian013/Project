%PE_EM Pseudo-Euclidean Linear Embedding
%
%     W = PE_EM(D,ALF,P)
%     W = D*PE_EM([],ALF,P)
%
% INPUT
%   D   NxN symmetric dissimilarity matrix (dataset)
%   ALF Parameter determining the dimensionality and the mapping (optional, default: Inf)
%       (0,1)   - Fraction of the total (absolute value) preserved variance
%        Inf    - No dimensionality reduction, keeping all dimensions (it's VERY noisy)
%       'p'     - Projection into a Euclidean space based on positive eigenvalues only
%       'PARp'  - Projection into a Euclidean space based on the PAR fraction of
%                 positive eigenvalues; e.g. ALF = '0.9p'
%       'n'     - Projection into a Euclidean space based on negative eigenvalues only
%       'PARn'  - Projection into a (negative) Euclidean space based on the PAR fraction
%                 of negative eigenvalues; e.g. ALF = '0.7n'
%       'P1pP2n'- Projection into a Euclidean space based on the P1 positive eigenvalues
%                 and P2 negative eigenvalues; e.g. ALF = '0.7p0.1n', ALF = '7p2n'
%       1 .. N  - Number of dimensions in total
%       [P1 P2] - P1 dimensions or preserved fraction of variance in the positive subspace
%                 and P2 dimensions or preserved fraction of variance in the negative
%                 subspace; e.g. ALF = [5 10], ALF = [0.9 0.1]
%   P   Integer between 0 and N specifying which object is mapped at the origin;
%       0 stands for the mean; (optional, default: 0)
%
% OUTPUT
%   W   Linear embedding into a pseudo-Euclidean space
%
% DEFAULT
%   P   = 0
%   ALF = INF
%
% DESCRIPTION
% Linear mapping W onto an M-dimensional Pseudo-Euclidean _PE) subspace from a 
% symmetric, square dissimilarity matrix D such that the dissimilarities are preserved.
% M is determined by ALF. E.g., the subspace is found such that at least a fraction
% ALF of the total variance is preserved for ALF in (0,1). The resulting X is found
% by D*W. The signature of the obtained PE space (numbers of positive and negative
% directions) can be found by GETDATA(W,'sig'). The spectrum of the obtained space
% can be found by GETDAT(W,'eval').
%
% SEE ALSO
% MAPPINGS, DATASETS, PCAM, GETSIG, SETSIG
%
% LITERATURE
% 1. L. Goldfarb, A unified approach to pattern recognition, 
% Pattern Recognition, vol.17, 575-582, 1984.
% 2. E. Pekalska, P. Paclik, and R.P.W. Duin, 
% A Generalized Kernel Approach to Dissimilarity-based Classification, 
% Journal of Machine Learning Research, vol.2, no.2, 175-211, 2002.
% 3. E. Pekalska and R.P.W. Duin, Beyond traditional kernels: 
% classification % in two dissimilarity-based representation spaces,
% IEEE Trans. on Systems, Man Cybernetics, vol. 38, no. 6, 2008, 729-744. 
