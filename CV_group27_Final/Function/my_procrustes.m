function transform=my_procrustes(X,Y)
[row_x, col_x]=size(X);
col_y=size(Y,2);
mean_X=mean(X,1);
mean_Y=mean(Y,1);
X0=X-repmat(mean_X, row_x,1);
Y0=Y-repmat(mean_Y, row_x,1);
sum_square_X=sum(X0.^2,1);
sum_square_Y=sum(Y0.^2,1);
constX=all(sum_square_X <= abs(eps(class(X))*row_x*mean_X).^2);
constY=all(sum_square_Y <= abs(eps(class(X))*row_x*mean_Y).^2);
sum_square_X=sum(sum_square_X);
sum_square_Y=sum(sum_square_Y);
if ~constX&&~constY
    normX=sqrt(sum_square_X); 
    normY=sqrt(sum_square_Y); 
    X0 =X0/normX;
    Y0 =Y0/normY;
    if col_y<col_x
        Y0=[Y0 zeros(row_x, col_x-col_y)];
    end
    A=X0'*Y0;
    [L,~,M]=svd(A);
    T=M*L';
    b=1;
    if col_y<col_x
        T=T(1:col_y,:);
    end
    c=mean_X-b*mean_Y*T;
    transform=struct('T',T, 'b',b, 'c',c);
elseif constX
    Z=repmat(mean_X, row_x, 1);
    T=eye(col_y,col_x);
    transform=struct('T',T, 'b',0, 'c',Z);
else
    Z = repmat(mean_X, row_x, 1);
    T = eye(col_y,col_x);
    transform = struct('T',T, 'b',0, 'c',Z);
end