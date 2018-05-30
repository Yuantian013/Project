function [DATA]=adaboostplot(data,label,times)
    figure(1);
    [m,~]=size(data);
    DATA=zeros(m,3);
    DATA(:,1:2)=data;
    weight=1/m * ones(m,1);            %Initialize the weights 
    Beta=zeros(times,1);               %Initialize the beta
    Result(times).result=0;            %Initialize the result label struct
    %---------------------Implementing the Set_DSw------------------------%
    for i=1:times 
    [~,~,~,Error,Result(i).result]=Set_DSw(data,label,weight); 
    Beta(i)=Error/(1-Error);           %Update the Beta
    num=(Result(i).result==label); 
    weight(num) = weight(num)*Beta(i); %Update the weight
    weight = weight/sum(weight);       %Normalize the weight
    DATA(:,3)=weight;
    if i==1
    subplot(1,2,1)
    scatter(DATA(:,1),DATA(:,2),[],DATA(:,3))
    colorbar
    legend('Class 1','Class 2')
    xlabel('Feature 1')
    ylabel('Feature 2')
    title('Iteration time = 1')
    end 
    end
    subplot(1,2,2)
    scatter(DATA(:,1),DATA(:,2),[],DATA(:,3))
    colorbar
    legend('Class 1','Class 2')
    xlabel('Feature 1')
    ylabel('Feature 2')
    title('Iteration time = 100')
end 