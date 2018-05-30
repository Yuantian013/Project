function [Label]=adaboost(data,label,times)
    [m,~]=size(data);     
    weight=1/m * ones(m,1);            %Initialize the weights 
    Beta=zeros(times,1);               %Initialize the beta
    Result(times).result=0;            %Initialize the result label struct
    Label=zeros(m,1);                  %Initialize the final output label
    sumLabel=zeros(m,1);               %Initialize the sum of label
    Thre=0;                            %Initialize the final threshold 
    %---------------------Implementing the Set_DSw------------------------%
    for i=1:times 
    [~,~,~,Error,Result(i).result]=Set_DSw(data,label,weight); 
    Beta(i)=Error/(1-Error);           %Update the Beta
    num=(Result(i).result==label); 
    weight(num) = weight(num)*Beta(i); %Update the weight
    weight = weight/sum(weight);       %Normalize the weight
    end 
    %----------------Calculate the sum of Label and Threshold-------------%
    for i=1:times
    sumLabel=sumLabel+log(1/Beta(i))*Result(i).result;
    Thre=Thre+0.5*log(1/Beta(i));
    end
    %-------------------------Output the hypothesis-----------------------%
    Label(sumLabel>=Thre)=1;
    Label(sumLabel<Thre)=0;
end 