function [bestFeature,threshold,type]=Set_DS(data,label)
    [~,n] = size(data);
    numThre = 30;                 %set the number of threshold we will try
    bestFeature = 0;              %initialize the best feature
    Right_Number = 0;             %initialize the Right number
    Sign=['<','>'];
    for i=1:n                     %loop over all dimensions
        rangeMin = min(data(:,i));
        rangeMax = max(data(:,i));
        interval = (rangeMax-rangeMin)/numThre;
        for j=0:numThre           %loop over all threshold
            for z=1:2             %loop over > and <   
                sign=Sign(z);
                threshVal = (rangeMin + j*interval);
                predictedVals = Decision_stump(data,i,threshVal,sign);
                num=find(predictedVals==label);
                [number,~]=size(num); 
                % Update the best setting
                if  number > Right_Number
                    Right_Number = number;
                    bestFeature=i;
                    threshold=threshVal;
                    type=sign;                 
                end
            end
        end 
    end 
end 