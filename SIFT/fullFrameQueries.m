% Full Frame Queries
% this function will perform a full frame query on 20 random images

framesdir = './frames';
siftdir = './sift';
fnames = dir([siftdir '/*.mat']);
picnames = dir([framesdir '/*.jpeg']);
numfeats = length(fnames);

load('allFeatures3.mat');
% [allFeatures] = getAllFeatures(); % don't need to run this because we can just load allFeatures2, which is the result. 

load('membership.mat');
% [membership, means, ~] = kmeansML(1500, allFeatures.descriptors'); % words

% Frame = getHistograms(means);
load('frames.mat'); % load the file instead to save time 


randomFrames = randperm(numfeats, 20); % random frames to perform queries

for i=1:20
    x = zeros(numfeats,1);
    for k =1:numfeats % get the normalized product for the specified image
        x(k) = normalizedProduct(Frame.histogram(randomFrames(i),:), Frame.histogram(k,:)');
    end
    
    x(isnan(x)) = 0; % notice this when a descriptor is NaN it comes to the top. 
    [m,n] = sort(x, 'descend');
    figure(1);
    for j=1:6
        subplot(2,3,j);
        im = imread(Frame.location{n(j)});
        imshow(im);
    end
    filename = sprintf('part3_f_%d',i);
    print(filename, '-dpng');
    clf;
end






