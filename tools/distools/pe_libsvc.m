%PE_LIBSVC LIBSVC for PE spaces
%
%   W = PE_LIBSVC(A,C)
%   W = A*PE_LIBSVC([],C)
%  
% INPUT
%   A	      Pseudo-Euclidean dataset
%   C       Trade_off parameter in the support vector classifier.
%           Default C = 1;
%  
% OUTPUT
%   W       Mapping: Support Vector Classifier
%
% DESCRIPTION  
% Computation of the linear LIBSVC classifier for the Pseudo-Euclidean 
% dataset A.  Note that testsets should be defined in the same PE space 
% as A.
%
% Warning: class prior probabilities in A are neglected.
%
% EXAMPLE
% trainset = gendatm;
% testset = gendatm;
% Dtrain = trainset*proxm(trainset,'m',1);
% Dtest  = testset*proxm(testset,'m',1);
% w = pe_em(Dtrain);
% Xtrain = Dtrain*w;
% Xtest = Dtest*w;
% v = pe_libsvc(Xtrain);
% Xtest*v*testc
%
% SEE ALSO
% MAPPINGS, DATASETS, PE_EM
