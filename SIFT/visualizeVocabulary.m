% visualizeVocabulary
% load('allFeatures.mat');
load('allFeatures2.mat');
% [allFeatures] = getAllFeatures();

load('membership.mat');
% [membership, means, ~] = kmeansML(1500, allFeatures.descriptors');

for j=1:20
    I=find(membership == j); % find the location at that index
    n2 = dist2(allFeatures.descriptors(I,:), means(:,j)'); % find the closest points 

    [x,y] = sort(n2); % sort to find the best match

    indices = I(y);

    figure(1);
    try
        for i=1:25
            index = indices(i);
            im = imread(allFeatures.origin{index});
            subplot(5,5,i);
            patch = getPatchFromSIFTParameters(allFeatures.positions(index,:), allFeatures.scales(index,:),allFeatures.orients(index,:), rgb2gray(im));
            imshow(patch);
        end
    catch
        disp('didnt have 25');
    end
%     filename = sprintf('im%d',j);
%     print(filename, '-dpng');
end


% create a hash table for all the features and the corresponding frame
% we will need this to know which frame the descriptor actually came from
% select a random sample of descriptors at least 15000, 80?
% run K-Means on these random points 
% k centers. 
% once you have 8 centers, you pick 2, and then for each one you want to
% find 25 patches for it. 
% K means has memberships, K means, ~]
% means are words, descrip
% membership reprecent member of all of the passed 
% want top 25 words. For 1st word, get all the descriptors that have a
% memberhsip at 7 and compute the distance from each one of them to the
% word and then pick the 25.
% And then you pick the frame using that identifier. d


