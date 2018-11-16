function data_dis=dis_ml(data)
w=kernelm(data);
data_dis=data*w;
end 