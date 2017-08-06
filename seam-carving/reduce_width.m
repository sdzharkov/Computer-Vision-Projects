function [ reducedColorImage, reducedEnergyImage ] = reduce_width( im, energyImage )
%REDUCE_WIDTH Summary of this function goes here
%   Detailed explanation goes here
[m,n,o] = size(im);
reducedColorImage = uint8(zeros(m, n-1, o));
reducedEnergyImage = double(zeros(m, n-1));

cumulativeEnergyMap = cumulative_minimum_energy_map(energyImage, 'VERTICAL');
verticalSeam = find_optimal_vertical_seam(cumulativeEnergyMap);

for x = 1:m
    val = verticalSeam(x);
    if val == 1
        reducedColorImage(x,:,1) = im(x, val+1:end, 1);
        reducedColorImage(x,:,2) = im(x, val+1:end, 2);
        reducedColorImage(x,:,3) = im(x, val+1:end, 3);
        reducedEnergyImage(x,:) = energyImage(x, val+1:end);
    else
        reducedColorImage(x,:,1) = im(x, [1:val-1 val+1:end], 1);
        reducedColorImage(x,:,2) = im(x, [1:val-1 val+1:end], 2);
        reducedColorImage(x,:,3) = im(x, [1:val-1 val+1:end], 3);
        reducedEnergyImage(x,:) = energyImage(x, [1:val-1 val+1:end]);
    end

end

end

