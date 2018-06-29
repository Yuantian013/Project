%EUSPACE Convert PE space to Euclidean space
%
%   B = A*EUSPACE
%   B = A*EUSPACE(TYPE)
%   V = W*EUSPACE(TYPE)
%
% INPUT
%   A     Pseudo-Euclidean dataset
%   W     Pseudo-Euclidean mapping
%   TYPE  String defining conversion type, 'ass' (default), 'pos', 'neg' or
%         'dec' (for pe_datasets only).
%
% OUTPUT
%   B     Euclidean dataset
%   V     Euclidean mapping
%
% DESCRIPTION
% The Pseudo-Euclidean (PE) space consist of two Euclidean subspaces, the 
% positive one and the negative one. A pseudo-Euclidean mapping as
% constructed by PE_EM generates vectors for which the first p components
% refer to the positive space and the next q components to the negative
% space. The signature (p,q) can be retrieved by GETSIG. 
%
% This routine returns for TYPE = 'ass' the so-called associative space. B
% contains thereby the same set of vectors, but now with signature (p+q,0).
% For TYPE = 'pos' just the positive part is returned, B = A(:,1:p). The
% signature is now just (p,0). For TYPE = 'neg', the negative part is
% returned, B = A(:,p+1:p+q) and the signature is set to (q,0) by which it
% is interpreted as Euclidean. These conversions influence various mappings
% and classifiers defined for the PE space.
%
% TYPE = 'dec' determines the Euclidean correction found by adding a
% sufficiently large positive constant to the off-diagonal elements of the
% squared original dissmilarity matrix.
%
% REFERENCES
% [1] R.P.W. Duin, E. Pekalska, A. Harol, W.J. Lee, and H. Bunke, 
% On Euclidean corrections for non-Euclidean dissimilarities, 
% in: Proc. SSPR & SPR 2008, LNCS 5342, Springer, 2008, 551-561. 
%
% [2] R.P.W. Duin, E. Pekalska, Non-Euclidean Dissimilarities: Causes and
% Informativeness, in: SSPR & SPR 2010, LNCS 6218, Springer, 2010, 324-333. 
%
% SEE ALSO
% DATASETS, PE_EM, GETSIG, PE_DISTM, PE_KNNC, PE_PARZENC, PE_NMC,
% PE_KERNELM, PE_AFFINE, PE_MTIMES
