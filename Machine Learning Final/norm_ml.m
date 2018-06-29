function data_norm=norm_ml(data)
DATA=getdata(data);
DATA=zscore(DATA);
data_norm=prdataset(DATA,getlab(data));
end