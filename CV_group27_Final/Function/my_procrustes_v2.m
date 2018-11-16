function transform = my_procrustes_v2(X, Y)

% find centroid 
mx = size(X,2);
my = size(Y,2);
mean_X = mean(X,1);
mean_Y = mean(Y,1);
X_0 = X - mean_X;
Y_0 = Y - mean_Y;
ssqX = sum(sum(X_0.^2,1));
ssqY = sum(sum(Y_0.^2,1));
normX = sqrt(ssqX);
normY = sqrt(ssqY); 
% rescale
X_0 = X_0 / normX;
Y_0 = Y_0 / normY;
if my < mx
    Y_0 = [Y_0 zeros(n, mx-my)];
end
A = X_0' * Y_0;
[L, D, M] = svd(A);
T = M * L';
traceTA = sum(diag(D)); 
b = traceTA * normX / normY;
if my < mx
    T = T(1:my,:);
end
c = mean_X - b*mean_Y*T;
transform = struct('T',T, 'b',b, 'c',c);

end
