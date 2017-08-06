function [ output ] = createHistogram( descriptors, means )
% this function creates a histogram for a specific frame and its
% descriptors.

answer = dist2(descriptors, means'); % get the distance of the descriptors to visual words

[~,y] = min(answer,[],2); % get which descriptor corresponds to which word 

output = histc(y, 1:1500)';


end
