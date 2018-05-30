function [bestFeature,threshold,type,Error,Result]=Set_DSw(data,label,weighted)
    [~,n] = size(data);
    numThre = 30;                 %set the number of threshold we will try
    bestFeature = 0;              %initialize the best feature
    Error = 100000;               %initialize the Error
    Sign=['<','>'];
    for i=1:n                     %loop over all dimensions
        rangeMin = min(data(:,i));
        rangeMax = max(data(:,i));
        interval = (rangeMax-rangeMin)/numThre;
        for j=0:numThre           %loop over all threshold
            for sign=1:2          %loop over > and <   
                threshVal = (rangeMin + j*interval);
                predictedVals = Decision_stump(data,i,threshVal,Sign(sign));
                num=predictedVals~=label;
                %add weight factor to error
                error=sum(weighted(num));
                % Update the best setting
                if  error < Error
                    Error = error;
                    bestFeature=i;
                    threshold=threshVal;
                    type=Sign(sign);
                    Result=predictedVals;
                end
            end
        end 
    end 
end 