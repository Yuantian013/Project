%PARZENDDC Parzen density based classifier for dissimilarity data
% 
%  [W,H] = PARZENDDC(D)
%  W     = PARZENDDC(D,H)
% 
% INPUT
%   D   Dissimilarity dataset
%   H   Smoothing parameters (optional; default: estimated from D)
%
% OUTPUT
%  W    Trained Parzen classifier
%  H    Smoothing parameters, estimated from the data
%
% DESCRIPTION
% Just implemented for a square dissimilarity matrix D
%
% SEE ALSO
% DATASETS, MAPPINGS, KNNDC, PARZEND_MAP
