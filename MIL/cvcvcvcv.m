function  [error_rate,baglabel]=cvcvcvcv(data)
num_bag=size(data,1);
[train_data,test_data]=gendat(data,0.85);
w=parzenc(train_data);
baglabel=test_data*w*labeld;
Label=getlab(test_data);
error_rate=size(find(baglabel~=Label),1)/num_bag;
end 