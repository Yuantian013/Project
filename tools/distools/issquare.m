%ISSQUARE Test on square dissimilarity matrix
%
%   OK = ISSQUARE(D)
%   ISSQUARE(D)
%
% INPUT
%   D      Dataset
%
% OUTPUT
%   OK     1 if the matrix D is square and 0, otherwise.
%
% DESCRIPTION
% True is D is a square dissimilarity matrix dataset. This includes
% the check (in case of crisp dataset D) whether feature labels equal 
% object labels. If called without an output argument ISSQUARE generates an 
% error if D is not square.
