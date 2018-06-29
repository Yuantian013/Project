%SIGNATURE Retrieve the signature from a pseudo-Euclidean dataset or mapping
%
%   SIG = SIGNATURE(W)
%   SIG = SIGNATURE(A)
%   SIG = W*SIGNATURE
%   SIG = A*SIGNATURE
%   [P,Q] = SIGNATURE(W)
%   .....
%
% INPUT
%   W    PE mapping, W = PE_EM(D), if D is a dissimilarity matrix
%   A    Dataset, vectors in PE space, A = D*W
%
% OUTPUT 
%   SIG  Signature, 2-element vector [P,Q] with numbers of dimensions of
%        the positive and the negative subspaces of the PE space.
%   P    Number of dimensions of the positive space.
%   Q    Number of dimensions of the negative space.
%
% SEE ALSO
% DATASETS, MAPPINGS, PE_EM, PE_DISTM
