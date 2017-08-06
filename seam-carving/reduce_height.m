function [ reducedColorImage, reducedEnergyImage ] = reduce_height( im, energyImage )
%REDUCE_HEIGHT Summary of this function goes here
%   Detailed explanation goes here
[m,n,o] = size(im);
reducedColorImage = uint8(zeros(m-1, n, o));
reducedEnergyImage = double(zeros(m-1, n));

cumulativeEnergyMap = cumulative_minimum_energy_map(energyImage, 'HORIZONTAL');
horizontalSeam = find_optimal_horizontal_seam(cumulativeEnergyMap);

for x = 1:n
    val = horizontalSeam(x);
    if val == 1
        reducedColorImage(:,x,1) = im(val+1:end, x, 1);
        reducedColorImage(:,x,2) = im(val+1:end, x, 2);
        reducedColorImage(:,x,3) = im(val+1:end, x, 3);
        reducedEnergyImage(:,x) = energyImage(val+1:end, x);
    else
        reducedColorImage(:,x,1) = im([1:val-1 val+1:end], x, 1);
        reducedColorImage(:,x,2) = im([1:val-1 val+1:end], x, 2);
        reducedColorImage(:,x,3) = im([1:val-1 val+1:end], x, 3);
        reducedEnergyImage(:,x) = energyImage([1:val-1 val+1:end], x);
    end

end

end

