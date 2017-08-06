function [ ] = hVerification( H, points1, points2, im2 )
%   Verify that the homogenous matrix is correct
[~,n] = size(points1);
[~,n1] = size(points2);

points1 = [points1; ones(1,n)];
% points2 = [points2; ones(1,n1)];

for i=1:n
    points1(:,i) = H*points1(:,i);
    points1(:,i) = points1(:,i) ./ points1(3,i);
%     points2(:,i) = H*points2(:,i);
%     points2(:,i) = points2(:,i) ./ points2(3,i);
end

points1(3,:) = [];
% points2(3,:) = [];

imshow(im2);
hold on;
plot(points1(1,:)', points1(2,:)', '*');





end

