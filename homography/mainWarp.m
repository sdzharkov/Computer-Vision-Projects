%%
image1 = imread('crop1.jpg');
image2 = imread('crop2.jpg');
load('cc1.mat');
load('cc2.mat');

%% select the points and compute the homography matrix
[points1, points2] = cpselect(image1, image2,cc1', cc2', 'Wait', true);

H = computeH(points1', points2');
% hVerification(H, points1', points2', image2); uncomment to verify
%%
[warpIm, mergeIm] = warpImage(image1, image2, H);
