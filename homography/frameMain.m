%%
image1 = imread('bill2.jpg');
image2 = imread('tron.jpg');

%% select the points and compute the homography matrix
[points1, points2] = cpselect(image1, image2, 'Wait', true);
H = computeH(points1', points2');

%%
[warpIm, mergeIm] = warpFrameImage(image1, image2, H);
