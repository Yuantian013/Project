function label=Cv_bagembed(train_data,test_data,sigma,train_label)
%%% Input=[data,sigma].
%%% 'data',Type:prdataset
%%% 'sigma' is a parameter for radial basis function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Output=[MILES],Size=MXN,M is the number of bags,N is the number of
%%% instances.
Data=getdata(train_data);
num_ins=size(Data,1);
MILES=bagembed(train_data,sigma);
DATA_MILES=prdataset(MILES,train_label);
w=liknonc(DATA_MILES);
% labels=DATA_MILES*w*labeld;
% sum(labels~=train_label)/119
test_DATA=getdata(test_data);
MILES_test=zeros(1,num_ins);
for j=1:num_ins
    distance=10000000;
    % Find the clostest instance in test bag
    for h=1:size(test_DATA,1)
        Distance=norm(Data(j,:)-test_DATA(h,:));
        % Update the nearest distance
        if  Distance<distance
            distance=Distance;
        end
    end
    MILES_test(1,j)=exp(- distance^2/sigma^2);
end
label=MILES_test*w*labeld;
end
