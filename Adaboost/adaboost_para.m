function [Para,Beta]=adaboost_para(data,label,times)
    [m,~]=size(data);     
    weight=1/m * ones(m,1);            %Initialize the weights 
    Beta=zeros(times,1);               %Initialize the beta
    Para(times).result=0;              %Initialize the paramater struct
    %---------------------Implementing the Set_DSw------------------------%
    for i=1:times 
    [Para(i).bestFeature,Para(i).threshold,Para(i).type,...
        Error,Para(i).result]=Set_DSw(data,label,weight); 
    Beta(i)=Error/(1-Error);           %Update the Beta
    num=(Para(i).result==label); 
    weight(num) = weight(num)*Beta(i); %Update the weight
    weight = weight/sum(weight);       %Normalize the weight
    end 
end 