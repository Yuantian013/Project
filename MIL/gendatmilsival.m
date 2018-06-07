function data=gendatmilsival(feature1,feature2)
%%% Input=[feature1,feature2].
%%% 'feature' is get from function extractinstances.m 
%%% Type:cell,Size=1xN,in every cell,there is a M*3 vector, M is the
%%% number of instances.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Output=[data],Type:prdataset
num_feature1=size(feature1,2);
num_feature2=size(feature2,2);
bags=feature1';
bags(num_feature1+1:num_feature1+num_feature2)=feature2';
baglabel=ones(num_feature1+num_feature2,1);
baglabel(num_feature1+1:num_feature1+num_feature2)=2;
data = bags2dataset(bags,baglabel);
end