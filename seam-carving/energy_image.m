function [ energy ] = energy_image( im )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
im2 = im2double(im);
gray = rgb2gray(im2);
[Gx, Gy] = gradient(gray); % get the x and y directional gradients

energy = sqrt(Gx.^2 + Gy.^2);

end

