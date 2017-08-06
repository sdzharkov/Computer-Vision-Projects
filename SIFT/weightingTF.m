%% Extra Credit part1: tf-idf
framesdir = './frames';
siftdir = './sift';
fnames = dir([siftdir '/*.mat']);
picnames = dir([framesdir '/*.jpeg']);
numfeats = length(fnames);

load('allFeatures2.mat');
% [allFeatures] = getAllFeatures();

load('membership.mat');
% [membership, means, ~] = kmeansML(1500, allFeatures.descriptors');

load('frames.mat'); % load the file instead to save time 
% Frame = getHistograms(means);

%% Create the tf-idf constant 

% idf_weights = create_tf_idf_word(Frame); % in case they don't exist already
load('tf_idf_weights.mat'); % returns matrix "new" with tf-idf weights


%% Apply weighting

randomFrame = randperm(numfeats, 1); % random frames to perform queries

fname = [siftdir '/' fnames(randomFrame).name];
pname = [framesdir '/' picnames(randomFrame).name];
file = matfile(fname);
descriptor = file.descriptors;
positions = file.positions;

im = imread(pname);
oninds = selectRegion(im, positions);
print(gcf, '-djpeg', 'part5_f');
close;
figure(1);
subplot(2,3,1);
imshow(im);

descriptors = descriptor(oninds, :);

newIdf = idf_weights(randomFrame,:);

x = zeros(numfeats,1);
for k =1:numfeats % get the normalized product for the specified image
    x(k) = normalizedProduct(newIdf, idf_weights(k,:)');
end

x(isnan(x)) = 0; % notice this when a descriptor is NaN it comes to the top. 
[m,n] = sort(x, 'descend');
for j=2:6
    subplot(2,3,j);
    im = imread(Frame.location{n(j)});
    imshow(im);
end
filename = sprintf('part5_f_%d',1);
print(filename, '-dpng');





