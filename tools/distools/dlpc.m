%DLPC LP-classifier on dissimilarity (proximity) data
%
%   [W1,W2,W3] = DLPC(D,BIAS,TYPE,PARAM)
%
% INPUT
%   D     Dissimilarity (proximity) dataset
%   BIAS  YES or NO (optional; default: 1 (YES))
%   TYPE  Type of a classifier
%         'SIMPLE'   - the most simple formulation; no sparse solution; PARAM = [];
%         'STANDARD' - minimization of the training misclassification errors;
%                      no sparse solution; PARAM = [];
%         'C-SPARSE' - sparse solution; a formulation similar to the LP_1 SVM;
%                       PARAM is a tradeoff parameter, similar as in the traditional
%                       SVM; (optional; DEFAULT: 1).
%         'MU-SPARSE' - sparse solution; a formulation similar to the LP_1 SVM,
%                       based on the paper of Graepel, Herbrich, Smola etc
%                       'Classification on proximity data with LP-machines'.
%                       PARAM is a tradeoff parameter, usually PARAM = 0.05 or 0.1.
%                       It is an upper bound on the misclassfied training objects.
%                       So, for well separable problems, PARAM = 0.01 or PARAM = 0.02.
%                       (optional; DEFAULT: the LOO 1-NN error * 1.3).
%  PARAM Parameter connected to the TYPE, as above
%
% OUTPUT
%   W1  LP-Classifier in the complete dissimilarity space
%   W2  LP-Classifier in a reduced dissimilarity space
%   W3  Object selection prmapping; the indices of support objects are in +W3.
%
% DEFAULTS
%   BIAS  = 1
%   TYPE  = 'STANDARD'
%   PARAM = []
%
% DESCRIPTION
% Classification problem on a N x M dissimilarity dataset D with LP-machines.
% D should be described by both label and feature lists. If D is a square,
% symmetric matrix, then the feature list should be the same as the label list.
%
% Assume a 2-class problem. Let DLPC select J support objects. Then:
% W1 is an M x 2 classifier in the original dissimilarity space, W2 is an J x 2
% classifier in the dissimilarity space defined by the J support objects
% and W3 is an M x R feature selection such that W1 = W3 * W2.
% Note that the indices of the support objects can be retrieved by +W3.
%
% A linear classifier is built on D:
%
%     f(D(x,*)) = diag(Y) * D(x,*) * W + W0,
%
% where Y are labels (+/- 1) and W are the weights. If BIAS is 1, then W0 is also
% sought, otherwise it equals 0, hence the hyperplane is forced to go through the origin.
%
% For C-class problems, C classifiers are trained, one against all others.
% In such a case, only W1 is returned and W3 in now NOT a feature selection,
% but directly the indices of the support objects.
