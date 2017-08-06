%%
image1 = imread('wdc1.jpg');
image2 = imread('wdc2.jpg');
load('points1.mat');
load('points2.mat');

%% select the points and compute the homography matrix
[points1, points2] = cpselect(image1, image2, points1, points2, 'Wait', true);
points1 = points1';
points2 = points2';
% save('points1.mat', 'points1');
% save('points2.mat', 'points2');

%%
H = computeH(points1, points2);
[warpIm, mergeIm] = warpImage(image1, image2, H);
