function Label=combineinstlabels(labels)
labelist = min(labels):max(labels);
num_label = histc(labels,labelist);
[~, max_index] = max(num_label);
Label = labelist(max_index);
end 