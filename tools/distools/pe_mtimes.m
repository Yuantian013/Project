%PE_MTIMES Pseudo-Euclidean matrix product
%
%  C = PE_MTIMES(A,B)
%
% A and/or B should be datasets. Their PE signature SIG is retrieved,
% C = A*J*B, where J is a diagonal matrix with 1's, followed by -1's.
% J = diag ([ONES(SIG(1),1);  -ONES(SIG(2),1)])
