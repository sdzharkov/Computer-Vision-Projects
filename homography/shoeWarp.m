%%
image1 = imread('shoe3.jpg');
image2 = imread('shoe4.jpg');


%% select the points and compute the homography matrix
[points1, points2] = cpselect(image1, image2, 'Wait', true);

H = computeH(points1', points2');

%%
[warpIm, mergeIm] = warpImage(image1, image2, H);
