%DISSIMT  Fixed DISsimilarity-SIMilarity transformation
%
%    W = DISSIMT([],TYPE,PAR)
%           OR
%    T = DISSIMT(P,TYPE,PAR)
%
% INPUT
%   P     NxN or NxM proximity matrix or dataset
%   TYPE  Type of the transformation that acts on proximity data
%         (optional; default: 'POW'):
%         'I',    'identity':   P
%         'SCALE', 'scale': 		P ./ PAR
%         'NEG',  'negative':   -P
%         'NEG2', 'negative2':  -P.^2
%         'REV',  'reverse':    1./(PAR + P)
%         'REV2', 'reverse':    1./(PAR^2 + P.^2)
%         'D2S',  'S2D':        1-P
%         'D2SSQ','S2DSQ':      sqrt(1-P)
%         'POW',  'power':      P.^PAR
%         'EXP',  'exponent':   exp(-P./PAR)
%         'EXP2', 'exponent2':  exp((-P.^2)./(PAR^2))
%         'GAUSS':              exp((-P.^2)./(2*PAR^2))
%         'LOG',  'logarithm':  log(P/PAR)
%         'NLOG', 'neglog':     -log((P+1)./PAR)
%         'NLOG2','neglog2':    -log((P.^2+1)./PAR^2)
%         'SIGM', 'sigmoid':    2./(1+exp(-P./PAR))-1
%         'SIGM2','sigmoid2':   2./(1+exp(-(P.^2)./PAR^2))-1
%         'SIM2DIS'
%         'DIS2SIM'
%   PAR   Parameter, PAR > 0 (optional; default: 1)
%
% OUTPUT
%   W     Fixed mapping
%   T     NxN or NxM proximity matrix or dataset
%
% DESCRIPTION
% A fixed mapping that transforms proximity data. Note that in some cases
% similarity is transformed into dissimilarity, or vice versa.
% If a proximity data P is supplied, the data are directly mapped, so there
% is no mapping defined. Hence, DISSIMT([],TYPE,PAR) is a mapping, while
% DISSIMT(P,TYPE,PAR) returns data.
%
% DEFAULT
%   PAR = 1
%
