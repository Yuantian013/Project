%PROXXM Proximity Mapping
%
%   W = PROXXM(A,TYPE,P,WEIGHTS)
%   W = A*PROXXM([],TYPE,P,WEIGHTS)
%
% INPUT
%   A       MxK Dataset
%   TYPE    Type of the proximity (optional; default: 'distance')
%   P       Parameter of the proximity (optional; default: 1)
%   WEIGHTS Weights (optional; default: all 1)
%
%   OUTPUT
%   W       Proximity mapping
%
% DESCRIPTION
% Computation of the KxM proximity mapping (or kernel) defined by the
% MxK dataset A. Unlabeled objects in A are neglected. If B is an NxK
% dataset, then D=B*W is the NxM proximity matrix between B and A. The
% proximities can be defined by the following types:
%
%   'POLYNOMIAL'   | 'P':  SIGN(A*B').*(A*B').^P
%   'HOMOGENEOUS'  | 'H':  SIGN(A*B').*(A*B').^P
%   'EXP'          | 'E':  EXP(-(||A-B||)/P)
%   'EXP-SUM'      | 'ES': SUM_Z SIGN(P(Z)) * EXP(-(||A-B||)/P(Z))
%   'RBF'          | 'R':  EXP(-(||A-B||.^2)/(P*P))
%   'RBF-SUM'      | 'RS': SUM_Z SIGN(P(Z)) * EXP(-(||A-B||.^2)/(P(Z)^2))
%   'SIGMOID'      | 'S':  SIGM(A*B'/P)
%   'DSIGMOID'     | 'DS': SIGM(||A-B||^(2P(1))/P(2))
%   'DISTANCE'     | 'D':  ||A-B||.^P
%   'MULTIQUADRIC' | 'MQ': SQRT(||A-B||.^2/P(1) + P(2))
%   'THIN-PLATE'   | 'TP': ||A-B||.^(2*P(1))/P(2) * LOG(1+||A-B||.^(2*P(1))/P(2))
%   'N-THIN-PLATE' | 'NTP': -||A-B||.^(2*P(1))/P(2) * LOG(1+||A-B||.^(2*P(1))/P(2))
%   'MINKOWSKI'    | 'M':  SUM(|A-B|^P).^(1/P)
%   'CITY-BLOCK'   | 'C':  SUM(|A-B|)
%   'COSINE'       | 'O':  1 - (A*B')/||A||*||B||
%   'FOURIER'      | 'F'
%   'TANH'         | 'T':  TANH(P*(A*B')/LENGTH(A) + P);
%   'ANOVA'        | 'A':  ANOVA MODEL
%   'BSPLINE'      | 'B':  BSPLINE MODEL, ORDER P
%   'ANOVABSPLINE' | 'AB': ANOVA-BSPLINE MODEL, ORDER P
%   'ANOVASPLINE1' | 'AS1':ANOVA-SPLINE MODEL, ORDER 1
%   'ANOVASPLINE2' | 'AS2':ANOVA-SPLINE MODEL, ORDER 2
%   'ANOVASPLINE3' | 'AS3':ANOVA-SPLINE MODEL, ORDER 3
%
% In the polynomial case for a non-integer P, the proximity is computed
% as D = SIGN(S+1).*ABS(S+1).^P, in order to avoid problems with negative
% inner products S = A*B'. The features of the objects in A and B may be
% weighted by the weights in the vector WEIGHTS.
%
% SEE ALSO
% PROXM, MAPPINGS, DATASETS
