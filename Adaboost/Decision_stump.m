function label=Decision_stump(data,dimension,threshVal,sign)
    [m,~]=size(data); 
    label=ones(m,1);
    if sign=='<' 
    p=data(:,dimension)<=threshVal;
    label(p)=0;
    else 
    p=data(:,dimension)>threshVal;
    label(p)=0;
    end
end