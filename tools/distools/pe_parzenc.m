%PE_PARZENC Parzen Classifier for PE spaces
%
%   [W,H,E] = PE_PARZENC(A,H)
%   [W,H,E] = PE_PARZENC(A)
%
% INPUT
%   A  PE dataset
%   H  Smoothing parameter (optional; default: H is optimized
%      with respect to the leave-one-out error on A)
%
% OUTPUT
%   W  Parzen classifier 
%   H  Number of the nearest neighbors used
%   E  The leave-one-out error
%
% DESCRIPTION  
% Computation of the Parzen classifier for the PE dataset A. 
%
% Warning: class prior probabilities in A are neglected.
%
% SEE ALSO
% MAPPINGS, DATASETS, PARZENC, PARZENDDC
