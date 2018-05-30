function [Image]=adaboostshow(data,label,times)
    [m,~]=size(data);
    weight=1/m * ones(m,1);            %Initialize the weights 
    Beta=zeros(times,1);               %Initialize the beta
    Image=zeros(times,4);              %Initialize the image position
    %---------------------Implementing the Set_DSw------------------------%
    for i=1:times 
    [~,~,~,Error,result]=Set_DSw(data,label,weight); 
    Beta(i)=Error/(1-Error);           %Update the Beta
    num=(result==label); 
    weight(num) = weight(num)*Beta(i); %Update the weight
    weight = weight/sum(weight);       %Normalize the weight
    [~,place]=sort(weight);
    Image(i,1:4)=place(m-3:m);
    end
    
end 