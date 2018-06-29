%PE_KNNC K-Nearest Neighbor Classifier for PE spaces
%
%   [W,K,E] = PE_KNNC(A,K)
%   [W,K,E] = PE_KNNC(A)
%
% INPUT
%   A  PE dataset
%   K  Number of the nearest neighbors (optional; default: K is 
%      optimized with respect to the leave-one-out error on A)
%
% OUTPUT
%   W  k-NN classifier 
%   K  Number of the nearest neighbors used
%   E  The leave-one-out error of the KNNC
%
% DESCRIPTION  
% Computation of the K-nearest neighbor classifier for the PE dataset A. 
%
% Warning: class prior probabilities in A are neglected.
%
% SEE ALSO
% MAPPINGS, DATASETS, KNNC, PE_EM
