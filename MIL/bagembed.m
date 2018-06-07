function MILES=bagembed(data,sigma)
%%% Input=[data,sigma].
%%% 'data',Type:prdataset
%%% 'sigma' is a parameter for radial basis function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Output=[MILES],Size=MXN,M is the number of bags,N is the number of
%%% instances.
bagid= getident(data,'milbag');
Data=getdata(data);
num_ins=size(Data,1);
num_bag=size(unique(bagid),1);
MILES=zeros(num_bag,num_ins);
% Loop all bags
for i=1:num_bag
    % find the instances in bag(i)
    instance=find(bagid==i);
    % Loop all instances
    for j=1:num_ins
        distance=10000000;
        % Find the clostest instance in bag(i)
        for h=1:size(instance,1)
            Distance=(norm(Data(j,:)-Data(instance(h),:)));
            % Update the nearest distance
            if ((Distance<distance) && instance(h)~=j)
                distance=Distance;
            end
        end
        MILES(i,j)=exp(-distance*distance/(sigma*sigma));
    end
end