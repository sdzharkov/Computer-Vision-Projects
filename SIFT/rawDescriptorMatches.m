% Part 1: Raw Descriptor Matching
% Select a region and match descriptors from the initial frame to the second frame. 
load('twoFrameData.mat');

oninds = selectRegion(im1, positions1);
% print(gcf, '-djpeg', 'part1_selected_region'); % save the results of the selection

descriptors1 = descriptors1(oninds, :); % new descriptors within the space

eucDistance = dist2(descriptors1, descriptors2);
finalPositions = zeros(1723,1);
[m1,m2] = sort(eucDistance,2,'ascend');

for i=1:size(eucDistance,1) % find the features that are closest to one another
    ratio = m1(i,1) / m1(i,2);
    if ratio < 0.7 % ratio of 0.7 best captures the features in the specified region.
        finalPositions(i) = m2(i,1);
    end
end

final = finalPositions(finalPositions ~= 0);


imshow(im2);
displaySIFTPatches(positions2(final,:), scales2(final,:), orients2(final,:), im2);
print(gcf, '-djpeg', 'part1_final');
