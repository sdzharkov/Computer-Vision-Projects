%%
im = imread('inputSeamCarvingPrague.jpg');
%%
energyImage = energy_image(im);

for i=1:100
    [im, energyImage] = reduce_width(im, energyImage);
end

imwrite(im, 'outputReduceWidthPrague.png');