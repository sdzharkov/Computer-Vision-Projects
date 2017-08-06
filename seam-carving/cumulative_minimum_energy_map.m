function [ energy_image ] = cumulative_minimum_energy_map( energyImage, seamDirection )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m, n] = size(energyImage);% m = rows going down, n = column

energy_image = energyImage;
if strcmp(seamDirection,'VERTICAL')
    for x = 2:m
            energy_image(x, 1) = energyImage(x,1) + min([energy_image(x-1,1), energy_image(x-1, 2)]);
            energy_image(x, n) = energyImage(x, n) + min([energy_image(x-1,n), energy_image(x-1, n-1)]);
        for y = 2:n-1
            energy_image(x,y) = energyImage(x,y) + min([energy_image(x-1,y-1), energy_image(x-1,y), energy_image(x-1, y+1)]);
        end
    end
elseif strcmp(seamDirection, 'HORIZONTAL')
    for x = 2:n % column
        energy_image(1,x) = energyImage(1,x) + min([energy_image(1,x-1), energy_image(2,x-1)]);
        energy_image(m,x) = energyImage(m,x) + min([energy_image(m,x-1), energy_image(m-1, x-1)]);
        for y = 2:m-1 % row
            energy_image(y,x) = energyImage(y,x) + min([energy_image(y-1,x-1), energy_image(y,x-1), energy_image(y+1, x-1)]);
        end
    end
else
     error('wrong input supplied. The options are Horizontal or Vertical');
end
 
end

