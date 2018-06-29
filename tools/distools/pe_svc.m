%PE_SVC SVC for PE spaces
%
%   W = PE_SVC(A,C)
%   W = A*PE_SVC([],C)
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
% Computation of the linear SVC classifier for the Pseudo-Euclidean 
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
% v = pe_svc(Xtrain);
% Xtest*v*testc
%
% SEE ALSO
% MAPPINGS, DATASETS, PE_EM
