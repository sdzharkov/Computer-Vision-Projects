function [ Frame ] = getHistograms( means )
% this function returns all of the histograms of all images

framesdir = './frames';
siftdir = './sift';
fnames = dir([siftdir '/*.mat']);
picnames = dir([framesdir '/*.jpeg']);
numfeats = length(fnames);

Frame.histogram = zeros(numfeats,1500); % this will hold every histogram
Frame.location = cell(numfeats,1); % location of histogram 

for i=1:length(fnames)
    fname = [siftdir '/' fnames(i).name];
    pname = [framesdir '/' picnames(i).name];
    file = matfile(fname);
    descriptor = file.descriptors;
    [m,~] = size(descriptor);
    if m ~= 0
        Frame.histogram(i,:) = createHistogram(descriptor, means);
    end
    Frame.location(i) = {pname};
end

save('frames.mat', 'Frame');


end

