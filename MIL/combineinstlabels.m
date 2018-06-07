function Label=combineinstlabels(labels)
%%% Input=[labels]
%%% 'labels' A 1XN vecter,we assume all labels are integers.
%%% Output=Label, an interger 

labelist = min(labels):max(labels);
num_label = histc(labels,labelist);
[~, max_index] = max(num_label);
Label = labelist(max_index);
end 