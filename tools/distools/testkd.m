%TESTKD Test k-NN classifier for dissimilarity data
%
%   [E,C] = TESTKD(D,K,PAR)
%   [E,C] = D*TESTKD([],K,PAR)
%
% INPUT
%   D    Dissimilarity dataset. Object labels are assumed to be the
%        true labels. Feature labels are assumed to be the labels of
%        the objects they are related to.
%   K    Desired number of neighbors to take into account, default K = 1.
%   PAR  'LOO' - leave-one-out option. This should be used if
%          the objects are related to themselves. If D is not square,
%          it is assumed that the first sets of objects in columns and
%          rows match.
%        'ALL' - use all objects (default).
%
% OUTPUT
%   E    Estimated error
%   C    Dataset with confidences, size M x N, if D has size M x L and
%        the labels are given for N classes. Note that for K < 3 these
%        confidences are derived from the nearest neigbor distances
%        and that for K >= 3 they are the Bayes estimators of the 
%        neighborhood class probabilities. D*TESTC returns E.
%
% DESCRIPTION
% TESTKD is based on just counting errors and does not weight with class
% class priors stored in D. Use D*(DL*KNNDC)*TESTC if this is needed. 
% DL is the dissimilarity matrix of the representation objects used for D.
%
% SEE ALSO
% DATASETS, KNNDC, NNE, NNERROR1, NNERROR2
