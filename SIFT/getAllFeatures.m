function [ allFeatures ] = getAllFeatures(  )
% this file returns the feature space for part 2
framesdir = './frames';
siftdir = './sift';

% framesdir = '/usr/local/cs174_data/frames/';
% siftdir = '/usr/local/cs174_data/sift';

fnames = dir([siftdir '/*.mat']);
picnames = dir([framesdir '/*.jpeg']);

numfeats = length(fnames) * 15;

allFeatures.descriptors = zeros(numfeats,128); % intialize the data object
allFeatures.orients = zeros(numfeats, 1);
allFeatures.positions = zeros(numfeats, 2);
allFeatures.scales = zeros(numfeats,1);
allFeatures.origin = cell(numfeats,1);

count = 1;
badCount = 0;
for i=1:length(fnames) % get the number of features 
    fname = [siftdir '/' fnames(i).name];
    pname = [framesdir '/' picnames(i).name];
    file = matfile(fname);
    descriptor = file.descriptors;
    orients = file.orients;
    positions = file.positions;
    scales = file.scales;
    [m,~] = size(descriptor);
    if (m >= 15) % randomly sample 15 features from each frame. this states that it needs to have more than 15 features to be queried
        randnums = randperm(m,15); % get 15 random frames 
        allFeatures.descriptors((count:15+count-1),:) = descriptor(randnums, :);
        allFeatures.orients((count:15+count-1),1) = orients(randnums');
        allFeatures.positions((count:15+count-1),:) = positions(randnums,:);
        allFeatures.scales(count:15+count-1) = scales(randnums);
        allFeatures.origin(count:(15+count-1)) = {pname};
        count = count + 15;
    else
        badCount = badCount + 15;
    end
end

% now remove all of the features that are blank
allFeatures.descriptors = allFeatures.descriptors(1:numfeats-(badCount*15),:);
allFeatures.orients = allFeatures.orients(1:numfeats - (badCount*15),1);
allFeatures.positions = allFeatures.positions(1:numfeats - (badCount*15),:);
allFeatures.scales = allFeatures.scales(1:numfeats - (badCount*15),1);
allFeatures.origin = allFeatures.origin(1:numfeats - (badCount*15),1);

save('allFeatures3.mat', 'allFeatures');


end

