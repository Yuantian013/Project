%CROSSVALD Cross-validation error for dissimilarity representations
% 
%   [ERR,STD_ERR] = CROSSVALD(D,CLASSF,N,K,ITER)
%   [ERR,CERR,NLAB_OUT] = CROSSVALD(D,CLASSF,N,K,1)
%
% INPUT
%   A          Input dataset
%   CLASSF     Untrained classifier to be tested.
%   N          Number of dataset divisions (default: N==number of
%              samples, leave-one-out)
%   K          Desired size of the representation set (default: use all)
%   ITER       Number of iterations
%
% OUTPUT
%   ERR        Average test error weighted by class priors.
%   CERR       Unweighted test errors per class
%   STD_ERR    Standard deviation in the error
%   NLAB_OUT   Assigned numeric labels
%
% DESCRIPTION
% Cross-validation estimation of the error and the instability of the
% untrained classifier CLASSF using the dissimilarity dataset D. The set is 
% randomly permutated and divided in N (almost) equally sized parts. Note that
% for a dissimilarity matrix, the division has to be applied both to rows and
% to columns. The classifier is trained on N-1 parts and the remaining part is 
% used for testing. This is rotated over all parts. 
%
% ERR is their weighted avarage over the class priors. CERR are the class error 
% frequencies.  D and/or CLASSF may be cell arrays of datasets and classifiers. 
% In that case ERR is an array with errors with on position ERR(i,j) the error of 
% the j-th classifier for the i-th dataset. In this mode, CERR and NLAB_OUT are 
% returned in cell arrays.
%
% If ITER > 1 the routine is run ITER times and results are averaged. The
% standard deviation of the error is returned in STD_ERR.
%
% NOTE
% D is a square dissimilarity matrix for which the representation set has to be 
% reduced to a K-element subset from the training set. This is done by random 
% selection. If K is not chosen the entire training set is used. 
% 
% EXAMPLE
% A = GENDATB(100);
% D = SQRT(DISTM(A));
% [E,S] = CROSSVALD (D, ldc([],1e-2,1e-6)*LOGDENS, 10, [], 5);
%
% SEE ALSO
% DATASETS, MAPPINGS, TESTC
