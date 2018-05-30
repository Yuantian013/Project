classdef adaboost_ini
    properties
        test_data;
        test_label;
        T;
        Beta;
        Para;
    end
    %-----------------------------------Constructor----------------------------------------%
    methods
        function obj=adaboost_ini(train_data,train_label,test_data,test_label,times)
            %----------------------------Initialize-----------------------%
            obj.test_data=test_data;
            obj.test_label=test_label;
            obj.T=times;
            [m,~]=size(train_data);
            weight=1/m * ones(m,1);                    %Initialize the weights
            obj.Beta=zeros(obj.T,1);                   %Initialize the beta
            obj.Para(times).result=0;                  %Initialize the paramater struct
            %--------------------Implementing the Set_DSw-----------------%
            for i=1:times
                [obj.Para(i).bestFeature,obj.Para(i).threshold,obj.Para(i).type,...
                    Error,obj.Para(i).result]=Set_DSw(train_data,train_label,weight);
                obj.Beta(i)=Error/(1-Error);           %Update the Beta
                num=(obj.Para(i).result==train_label);
                weight(num) = weight(num)*obj.Beta(i); %Update the weight
                weight = weight/sum(weight);           %Normalize the weight
            end
        end
    end
    %----------------------------------------Classifier---------------------------------------%
    methods
        function [Label,Accuracy]=Ada_classifier(obj)
            AdaLabel=zeros(size(obj.test_label,1),1);
            Thre=0;
            %----------Calculate the sum of Label and Threshold-----------%
            for i=1:obj.T
                Label=Decision_stump(obj.test_data,obj.Para(i).bestFeature,...
                    obj.Para(i).threshold,obj.Para(i).type);
                AdaLabel=AdaLabel+log(1/obj.Beta(i))*Label;
                Thre=Thre+0.5*log(1/obj.Beta(i));
            end
            %--------------------Output the hypothesis--------------------%
            Label(AdaLabel>=Thre)=1;
            Label(AdaLabel<Thre)=0;
            %--------------------------Accuracy--------------------------%
            Accuracy=sum(Label==obj.test_label,1)/size(obj.test_label,1);
        end
    end
end % classdef