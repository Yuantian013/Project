%GENDDAT Generate dissimilarity sets for training, testing and representation 
%
%  [DT,DS,I,J,R] = GENDDAT(D,M,K,L)
%  [DT,DS,I,J,R] = GENDDAT(D,M,K,L,TYPE)
%
% INPUT
%  D    NxN dissimilarity dataset
%  M    Vector of class sizes or frequencies, or a single number /
% 	    frequency in(0,1), used for the trainset
%  K 	  Vector of class sizes or frequencies, or a single number /
% 	    frequency in(0,1), used for the repset.(optional, default: K = M)
%  L    Vector of class sizes or frequencies, or a single number /
% 	    frequency in(0,1), added tot the repset.(optional, default: L = [])
%  TYPE String, 'in' or 'ex', default 'in'.
%
% OUTPUT
%   DT  Training dissimilarity dataset, DT = D(I,R)
%   DS  Test dissimilarity dataset, DS = D(J,R)
% 	I 	Indices of the training objects
% 	J 	Indices of the test objects
%   R   Indices of the representation set
%
% DESCRIPTION
% This routine is similar to GENDAT for randomly splitting datasets, but it
% randomly selects the representation set (the columns of DT and DS) as 
% well. The input matrix D (a PRTools dataset) should be square, listing 
% dissimilarities of a set of objects to themselves.
%
%  M  determines the split of all objects in parts for training and testing.
%     For M = [] all objects are used for DT.
%  K  determines which part of training objects is used for representation.
%     By default, K = [], all training objects are used. For K = 0 no
%     objects from the trainset are used for the repset.
%  L  determines which part of the test objects are used for representation.
%     By default none of the test objects are used. In case TYPE is 'ex'
%     the repset is kept outside testset.
%
% For setting M, K and L the following rules apply (similar to GENDAT).
% - a scalar smaller than 1 will generate a fraction of the set, using the
%   class priors of the dataset. Use 0.99999 for the entire set.
% - a scalar equal or larger than 1 with generate that number of objects
%   using the class priors of the dataset.
% - a vector with length equal to the number of classes will generate the
%   number (or fraction) of objects for the corresponding class, using the
%   class ranking as obtained by GETLABLIST(D).
% 
% EXAMPLE
% Let D be 100 x 100 dataset with two classes [40 60] and priors [0.4 0.6].
% 1)	[DT,DS] = GENDDAT(D,0.6) 
% DTR is 60x60 and DTE is 40x60. 60% of the 40 objects of the first class 
% (24) and 60% of the 60 objects of the second class (36) are selected for
% DTR. The remaining objects are stores in DTE. The repset equals the
% trainset.
%
% 2) [DT,DS] = GENDDAT(D,0.6,0.1) 
% DTR is 60x6 and DTE is 40x6. 60% of the 40 objects of the first class 
% (24) and 40% of the 60 objects of the second class (36) are selected 
% for training. From that, 10% of the 24 first class training objects are
% selected for the repset (rounded to 2). 10% of 36 second class objects,
% rounded to 4 objects for the second class are added.
%
% 3) [DT,DS] = GENDDAT(D,0.6,0,0.1)
% DTR is 60x4 and DTE is 40x4. The 4 objects in the repset are taken from
% the testset.
%
% 4) [DT,DS] = GENDDAT(D,0.6,0,0.1,'ex')
% DTR is 60x4 and DTE is 36x4. The 4 objects in the repset are exclcuded
% from the testset.
%
% SEE ALSO
% DATASETS, GETLABLIST, GENDAT
