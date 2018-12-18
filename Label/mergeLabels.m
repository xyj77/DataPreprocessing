load('../labels.mat');
load('../available.mat');
load('../add.mat');
for i=1:length(available)
    labels = setDEd(available(i), labels);
end
save('../labels.mat', 'labels');

% for i=1:length(add)
%     labels = aetOffset(add(i), labels);
% end
