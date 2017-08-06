% Region Queries
%%
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
%%
randomFrame = randperm(numfeats, 1); % random frames to perform queries

fname = [siftdir '/' fnames(randomFrame).name];
pname = [framesdir '/' picnames(randomFrame).name];
file = matfile(fname);
descriptor = file.descriptors;
positions = file.positions;

im = imread(pname);
oninds = selectRegion(im, positions);
print(gcf, '-djpeg', 'part4_f');
close;
figure(1);
subplot(2,3,1);
imshow(im);

descriptors = descriptor(oninds, :);

newHist = createHistogram(descriptors, means);

x = zeros(numfeats,1);
for k =1:numfeats % get the normalized product for the specified image
    x(k) = normalizedProduct(newHist, Frame.histogram(k,:)');
end

x(isnan(x)) = 0; % notice this when a descriptor is NaN it comes to the top. 
[m,n] = sort(x, 'descend');
for j=2:6
    subplot(2,3,j);
    im = imread(Frame.location{n(j)});
    imshow(im);
end
% filename = sprintf('part4_f_%d',1);
% print(filename, '-dpng');



