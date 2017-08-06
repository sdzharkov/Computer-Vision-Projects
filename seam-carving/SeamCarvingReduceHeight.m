%%
im = imread('inputSeamCarvingMall.jpg');
energyImage = energy_image(im);

for i=1:50
    [im, energyImage] = reduce_height(im, energyImage);
end

imwrite(im, 'outputReduceHeightMall.png');