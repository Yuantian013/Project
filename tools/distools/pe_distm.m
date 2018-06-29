%PE_DISTM Square Pseudo-Euclidean (PE) Distance Between Two Datasets
%
%   D = PE_DISTM(A,B)
%   D = A*PE_DISTM([],B)
%   D = A*(B*PE_DISTM)
%   D = PE_DISTM(A)
%
% INPUT
%   A   NxK Matrix or dataset, Euclidean or pseudo-Euclidean
%   B   MxK Matrix or dataset, Euclidean or pseudo-Euclidean
%
% OUTPUT
%   D   NxM Euclidean distance dataset or matrix
%
% DESCRIPTION
% Computation of the square pseudo-Euclidean distance matrix D between two sets
% of vectors, A and B. The pseudo-Euclidean distance with the signature SIG
% (e.g. SIG = [10 5]) between vectors X and Y is computed as an indefinite
% 'Euclidean' distance:
%     D(X,Y) = (X-Y)'*J*(X-Y),
% where J is a diagonal matrix with 1's, followed by -1's.
% J = diag ([ONES(SIG(1),1);  -ONES(SIG(2),1)]);
%
% In a PE dataset the signature is stored in the user field, see
% SETSIG. This signature is derived from A. It is not stored in D as D
% does not contain vectors in a PE space.
%
% D is a dataset with the labels defined by the labels of A and feature labels 
% defined by the labels of B. 
%
% REMARKS
% Note that square pseudo-Euclidean distances can be negative. Zero
% distances can be negative due to small computational inaccuracies. The
% call 
%    D = PE_DISTM(A)
% forces symmetry and a zero diagonal.
% If A nd B are both Euclidean then D = PE_DISTM(A,B) calls D = DISTM(A,B)
%
% SEE ALSO
% PRDATASET, SETSIG, DISTM
