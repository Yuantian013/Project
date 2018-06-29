%PROTSELFD Forward Prototype Selection for Dissimilarity Matrices
%
%   [W,E,KOPT] = PROTSELFD(D,CRIT,K)
%    W  = D*PROTSELFD([],CRIT,K)
%
% INPUT
%   D     Dataset, dissimilarity matrix, not necessarily square.
%   K     Integer, desired number of prototypes. Default: select all, just
%         rank the columns of D
%   CRIT  'super' supervised selection using 1NN error on prototypes.
%         'nn'    same as 'super'
%         'loo' - supervised selection using leave-one-out 1NN error estimation.
%         'maxdist' - unsupervised selection minimizing the maximum
%                     distance to the nearest prototype.
%         'meandist' - unsupervised selection minimizing the average
%                      distance to the nearest prototype.
%
% OUTPUT
%   W     Selection mapping ('feature selection'). +W: Prototype indices.
%   E     Error stimate as a function of number of selected prototypes
%         (for supervised selection only reliable for prototype sizes >= class size)
%   KOPT  Estimate for best size in avoiding peaking 
%         (supervised selection only)
%
% DESCRIPTION
% This procedure for optimizing the representation set of a dissimilarity 
% matrix is based on a greedy, forward selection of prototypes. This
% implies that for larger values of K always the selected features always
% start with the ones found for smaller K.
%
% In case of a supervised selection, D should be a labeled dataset with 
% prototype labels stored as feature labels. The 1NN error to the nearest
% prototype based on the given dissimilarities is used as a criterion. 
% In case of a leave-one-out error estimation it is assumed that the first
% objects in D (rows) correspond with the objects used for the 
% representation set (columns).
% 
% For K=1 just a single prototype has to be returned, but computing the
% 1NN error is not possible as all objects are assigned to the same class.
% In that case the centre object of the largest class will be returned.
%
% Note that the search continues untill K prototypes are found. This might
% be larger than desired due to peaking (overtraining). Therefor an
% estimate for the optimal number of prototype is returned in KOPT. 
%
% The prototype selection may be applied by C = B*W(:,1:KSEL), in which B
% is a dissimilarity matrix based on the same representation set as A (e.g.
% A itself) and C is a resulting dissimilarity matrix in which the KSEL
% (e.g. KOPT) best prototypes are selected.
%
% In case of unsupervised selection the maximum or the mean distances to
% the nearest prototype are minimized. These criteria are the same as used
% in the k-centers and k-mediods cluster procedures.
%
% A random selection just selects at random a set of columns of D.
%
% REFERENCE
% E. Pekalska, R.P.W. Duin, and P. Paclik, Prototype selection for
% dissimilarity-based classification, Pattern Recognition, 
% vol. 39, no. 2, 2006, 189-208.
%
% SEE ALSO
% DATASETS, MAPIINGS, KNNDC, DISEX_PROTSELFD
