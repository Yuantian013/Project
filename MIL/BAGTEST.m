function BAGLABELS=BAGTEST(data,labels)
bagid = getident(data,'milbag');
j=1;
BAGLABELS=[];
labelbag=[];
for i=1:size(data,1)-1
    labelbag(end+1)=labels(i);
    if bagid(i)~=bagid(i+1)
        BAGLABELS(j)=combineinstlabels(labelbag);
        j=j+1;
        labelbag=[];
    end
end
BAGLABELS(j)=combineinstlabels(labelbag);
BAGLABELS=BAGLABELS';
end
