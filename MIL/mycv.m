function  [error_rate]=mycv(Data,sigma,BAGLABEL)

bagid= getident(Data,'milbag');
baglabel=zeros(size(BAGLABEL,1),1);
for i=1:120
    %把data按包编号去除
    train_data=Data(bagid~=i,:);
    test_data=Data(bagid==i,:);
    train_label=BAGLABEL;
    train_label(i,:)=[];
    baglabel(i)=Cv_bagembed(train_data,test_data,sigma,train_label);
end
error_rate=sum(baglabel~=BAGLABEL)/120;
end 