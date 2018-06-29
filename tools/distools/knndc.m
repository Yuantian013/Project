%KNNDC K-Nearest Neighbor Classifier for dissimilarity matrices
%
%	[W,K,E] = KNNDC(D,K,PAR,EDIT,PAR1,PAR2,PAR3)
%	[W,K,E] = D*KNNDC([],K,PAR,EDIT,PAR1,PAR2,PAR3)
%
% INPUT
%   D     NxN dissimilarity matrix or dataset
%	  K     Number of nearest neighbors; if [], then K is optimized	
%	  PAR   'LOO' - compute leave-one-out optimization for K, it is assumed
%         that the first objects in the training set constitute the repset.
%		      'ALL' - include all dissimilarities for optimization of K
%         (repset should not be included in training set)
%   EDIT  'ORG', editting and condensing is done by EDICON_ORG using 
%			    K = PAR1 and N = PAR2. K is set to 1. 
%         'DANDK', editting and condensing is done by EDICON using 
%         NSETS = PAR1, NITERS = PAR2 and NTRIES = PAR3. K is set to 1. 
%         
% OUTPUT
%   W	    Classifier
%   K	    Number of nearest neighbors
%	  E	    Error on D
%
% DESCRIPTION
% Compute K-Nearest Neigbor classifier for the dissimilarity set D by 
% optimizing K (if the routine is called with K = []), the error on D is 
% returned in E. A test dissimilarity set DTE defined by the same repset
% can be mapped by C = DTE*W:
%    C        - estimated class confidences
%    C*LABELD - assigned class labels
%    C*TESTC  - classification error
%
% Editting and condesning only affects the repset. During execution the 
% reduced representation set is used. See PROTSELFD for other ways to
% reduce the repset.
% 
% NN errors for dissimilarity data can be directly estimated by TESTKD.
%
% SEE ALSO
% DATASETS, MAPPINGS, TESTKD, CROSSVALD, EDICON
%
