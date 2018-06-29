%CLEVALD Classifier evaluation (learning curve) for dissimilarity data
%
%   E = CLEVALD(D,CLASSF,TRAINSIZES,REPSIZE,NREPS,T,TESTFUN)
%
% INPUT
%   D          Square dissimilarity dataset
%   CLASSF     Classifiers to be evaluated (cell array)
%   TRAINSIZE  Vector of training set sizes, used to generate subsets of D
%              (default [2,3,5,7,10,15,20,30,50,70,100]). TRAINSIZE is per
%              class unless D has no priors set or has soft labels.
%   REPSIZE    Representation set size per class (>=1), or fraction (<1)
%              (default total training set). If REPSIZE > TRAINSIZE
%              testobjects are included for representation.
%   NREPS      Number of repetitions (default 1)
%   T          Test dataset (default [], use remaining samples in A)
%   TESTFUN    Mapping,evaluation function (default classification error)
%
% OUTPUT
%   E          Error structure (see PLOTE) containing training and test
%              errors
%
% DESCRIPTION
% Generates at random, for all class sizes defined in TRAINSIZES, training
% sets out of the dissimilarity dataset D. The representation set is either
% equal to the training set (REPSIZE = []), or a fraction of it (REPSIZE <1)
% or a random subset of it of a given size (REPSIZE>1). This set is used
% for training the untrained classifiers CLASSF. The resulting trained
% classifiers are tested on the training objects and on the left-over test 
% objects, or, if supplied, the testset T. This procedure is then repeated 
% NREPS times. The default test routine is classification error estimation 
% by TESTC([],'crisp'). 
%
% The returned structure E contains several fields for annotating the plot
% produced by PLOTE. They may be changed by the users. Removal of the field
% 'apperror' (RMFIELD(E,'apperror')) suppresses the draw of the error
% curves for the training set.
%
% Training set generation is done "with replacement" and such that for each
% run the larger training sets include the smaller ones and that for all
% classifiers the same training sets are used.
%
% This function uses the RAND random generator and thereby reproduces 
% if its seed is reset (see RAND).
% If CLASSF uses RANDN, its seed should be reset as well.
%
% SEE ALSO
% MAPPINGS, DATASETS, CLEVAL, TESTC, PLOTE
