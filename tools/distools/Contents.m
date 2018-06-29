% DisTools: Dissimilarity based pattern recognition
% Version 3.02 13-Sep-2013
% 
% This Matlab toolbox for the analysis of dissimilarity data works only 
% if also the pattern recognition toolbox PRTools version 5 is available.
% See http://prtools.org, http://37steps.com
% 
% R.P.W. Duin (r.duin@37steps.com)
% E. Pekalksa (e.pekalska@37steps.com)
% 
%Manipulation of dissimilarity matrices
%--------------------------------------
%GENDDAT      Generate random training and test sets for dissimilarity data
%MAKESYM      Make a dissimilarity matrix symmetric
%SELDCLASS    Select class subset from a square dissimilarity dataset
%
%Characterization of dissimilarity matrices
%------------------------------------------
%NEF          Compute negative eigen-fraction and negative eigen-ratio
%NMF          Compute fraction of violations of triangle inequality
%DISNORM      Normalization of a dissimilarity matrix (PRTools)
%ISSQUARE     Check whether a matrix is square
%ISSYM        Check whether a matrix is symmetric
%INTRDIM      Intrinsic diemensionality
%NNE          Leave-one-out Nearest Neighbor error on a dissimilarity matrix
%NNERROR1     Exact expected NN error from a dissimilarity matrix
%NNERROR2     Exact expected NN error from a dissimilarity matrix
%
%Dissimilarity Measures
%----------------------
%DISTM        Square Euclidean distance matrix (PRTools)
%PROXXM       Proximity mappings
%
%Transformations
%---------------
%MAKEMETRIC   Make a matrix metric
%MAKESYM      Make a matrix symmetric
%PE_EM        Pseudo-Euclidean embedding (special case: Classical Scaling)
%EUSPACE      Convert PE space into an Euclidean space
%
%Classification in Pseudo-Euclidean Space and indefinite kernels
%---------------------------------------------------------------
%DISPN        Split dissimilarity matrix in positive and negative part
%GETSPECTRUM  Retrieve spectrum form pseudo-Euclidean mapping
%GETSIG       Retrieve signature of PE mapping or PE dataset
%ISPE_DATASET Test dataset for PE signature setting 
%ISPE_EM      Test mapping for PE signature setting
%NEF          Compute Negative Eigen Fraction from PE dataset or mapping
%NMF          Compute Non-Metric Fraction from dissimilarity matrix
%PE_DISTM     Square pseudo-Euclidean distance between two datasets
%PE_KERNELM   Compute kernel in PE space
%PE_MTIMES    Matrix multiplication (inner product) in PE space
%PE_PARZENC   Parzen classifier in PE space
%PE_KNNC      KNN classifier in PE space
%PE_NMC       Nearest mean classifier in PE space
%PE_SVC       Support classifier in PE space
%PE_LIBSVC    Support classifier in PE space based on LIBSVM
%PE_EM        Pseudo-Euclidean linear embedding
%PLOTSPECTRUM Plot spectrum of eigenvalues
%SELEIGS      Select eigenvalues from a list
%
%Routines supporting learning from dissimilarity matrices
%--------------------------------------------------------
%CROSSVALD    Cross-validation error for dissimilarity data
%CLEVALD      Classifier evaluation (learning curve) for dissimilarity data
%PROTSELFD    Forward prototype selection   
%DLPC         LP-classifier on dissimilarity (proximity) data
%KNNDC        K-Nearest Neighbor classifier for dissimilarity matrices
%PARZENDDC    Parzen classifier for dissimilarity matrices
%TESTKD       Test k-NN classifier for dissimilarity data
%TESTPD       Test Parzen classifier for dissimilarity data
