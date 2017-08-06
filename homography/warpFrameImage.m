function [ warpIm, mergeIm ] = warpImage( inputIm, refIm, H )

inputIm = double(inputIm);
refIm = double(refIm);

[heightInput,widthInput, ~] = size(inputIm); % sizing 
[heightRef,widthRef, ~] = size(refIm);

% Find the four corners of the image to create the bounding box
corners = zeros(3,4);
newCorners = zeros(3,4);

corners(:,1) = [1;1;1];
corners(:,2) = [1;heightInput;1];
corners(:,3) = [widthInput;1;1];
corners(:,4) = [widthInput;heightInput;1];

for i=1:4
    newCorners(:,i) = (H) * corners(:,i);
    newCorners(:,i) = (newCorners(:,i) / newCorners(3,i)); % divide by W
end

newCorners(3,:) = []; % delete the row of 1's 

maxX = max(newCorners(1,:)); % max and min values 
minX = min(newCorners(1,:));
maxY = max(newCorners(2,:));
minY = min(newCorners(2,:));

width = ceil(maxX - minX); % width of the new image
height = ceil(maxY - minY); % height of the new image 

[x,y] = meshgrid(minX:maxX, minY:maxY); % use meshgrid to get all of the needed points
reshaped = [x(:), y(:)]'; % coordinates paired together from meshGrid
reshaped = [reshaped; ones(1,width*height)]; % creates a matrix of [x;y;1] that is prepared to be multiplied by inv(H)

newReshaped = H \ reshaped; % apply the inv(H) onto the reshaped matrix

for k=1:width*height % Normalize all the values with each W
    newReshaped(:,k) = newReshaped(:,k) ./ newReshaped(3,k);
end

newReshaped(3,:) = []; % now we have the warped coordinates 
xVal = round(newReshaped(1,:))'; % x values of the new coordinates
yVal = round(newReshaped(2,:))'; % y values of the new coordinates

warpIm = zeros(height, width, 3, 'uint8'); % initialize the new warpedImage

for l=1:3
    output = uint8(interp2(double( inputIm(:,:,l) ), xVal(:), yVal(:)));
    warpIm(:,:,l) = reshape(output,height,width);
end

mergeMinX = ceil(min([minX, 1]));
mergeMinY = ceil(min([minY, 1]));
mergeMaxX = ceil(max([maxX, widthRef]));
mergeMaxY = ceil(max([maxY, heightRef]));

mergeImHeight = mergeMaxY - mergeMinY + 1;
mergeImWidth = mergeMaxX - mergeMinX + 1;

mergeIm = zeros(mergeImHeight, mergeImWidth, 3, 'uint8');

rx = ceil(max(1, 1 - minX));
ry = ceil(max(1, 1 - minY));
wx = ceil(max(1, minX));
wy = ceil(max(1, minY));

mergeIm((wy:height+wy-1), (wx:width+wx-1),:) = warpIm;
for i = 1:mergeImWidth
    for j = 1:mergeImHeight
        if (i >= rx && i <= (rx + widthRef -1) && j >= ry && j <= (ry + heightRef -1))
%             if mergeIm(j,i,:) == 1
                mergeIm(j, i, :) = refIm((j-ry+1), (i-rx+1),:);
%             else
%                 mergeIm(j, i, :) = (refIm((j-ry+1), (i-rx+1),:) + double(mergeIm(j,i,:))) ./ 2;
%             end
        end
    end
end

imshow(uint8(mergeIm));

end

