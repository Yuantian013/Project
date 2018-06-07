function  [error_rate,baglabel]=bagcv(data,Label)
bagid= getident(data,'milbag');
num_bag=size(unique(bagid),1);
baglabel=zeros(num_bag,1);
error_rate=ones(1,3);
for i=1:num_bag
    train=bagid~=i;
    test=bagid==i;
    w=fisherc(data(train,:));
    labels=data(test,:)*w*labeld;
    baglabel(i)=combineinstlabels(labels);
end
error_rate(1)=size(find(baglabel~=Label),1)/num_bag;
error_rate(2)=size(find(baglabel(1:60)~=Label(1:60)),1)/60;
error_rate(3)=size(find(baglabel(61:120)~=Label(61:120)),1)/60;
end 