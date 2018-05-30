function [train_error,test_error]=adaboost_H(train_data,train_label,times,test_data,test_label)
    [m,~]=size(train_data);     
    weight=1/m * ones(m,1);            %Initialize the weights 
    Beta=zeros(times,1);               %Initialize the beta
    Result(times).result=0;            %Initialize the struct
    test_error=zeros(times,1);         %Initialize the test error
    train_error=zeros(times,1);        %Initialize the train error
    %---------------------Implementing the Set_DSw------------------------%
    for i=1:times 
    [Result(i).bestFeature,Result(i).threshold,Result(i).type,...
        Error,Result(i).result]=Set_DSw(train_data,train_label,weight); 
    Beta(i)=Error/(1-Error);           %Update the Beta
    num=(Result(i).result==train_label); 
    weight(num) = weight(num)*Beta(i); %Update the weight
    weight = weight/sum(weight);       %Normalize the weight
    %-----------------Implementing on test/train data---------------------%
    %----------------Calculate the sum of Label and Threshold-------------%
    sumLabel_test=zeros(size(test_label,1),1);
    sumLabel_train=zeros(size(train_label,1),1);
    Thre=0;
    for j=1:i
    Label_test=Decision_stump(test_data,...
    Result(j).bestFeature,Result(j).threshold,Result(j).type);
    Label_train=Decision_stump(train_data,...
    Result(j).bestFeature,Result(j).threshold,Result(j).type);
    sumLabel_test=sumLabel_test+log(1/Beta(j))*Label_test;
    sumLabel_train=sumLabel_train+log(1/Beta(j))*Label_train;
    Thre=Thre+0.5*log(1/Beta(j));
    end
    %----------------------Calculate the hypothesis-----------------------%
    Label_test(sumLabel_test>=Thre)=1;
    Label_test(sumLabel_test<Thre)=0;
    Label_train(sumLabel_train>=Thre)=1;
    Label_train(sumLabel_train<Thre)=0;
    %----------------------Calculate the error rate-----------------------%
    num_test=Label_test~=test_label;
    test_error(i)=sum(num_test)/size(test_data,1);
    num_train=Label_train~=train_label;
    train_error(i)=sum(num_train)/size(train_data,1);
    end
end 