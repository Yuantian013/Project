%TESTPD Test Parzen classifier for dissimilarity data
%
%   [E,C] = TESTPD(D,H,PAR)
%   [E,C] = D*TESTPD([],H,PAR)
%
% INPUT
%   D    Dissimilarity dataset. Object labels are assumed to be the
%        true labels. Feature labels are assumed to be the labels of
%        the objects they are related to.
%   H    Desired smoothing parameter. Default: estimate by PARZENDDC
%   PAR  'loo' - leave-one-out option. This should be used if
%        the objects are related to themselves. If D is not square,
%        it is assumed that the first sets of objects in columns and
%        rows match.
%        'all' - use all objects (default).
%
% OUTPUT
%   E    Estimated error
%   C    Dataset with confidences, size M x N, if D has size M x L and
%        the labels are given for N classes. 
%
% SEE ALSO
% DATASETS, KNND, TESTKD
