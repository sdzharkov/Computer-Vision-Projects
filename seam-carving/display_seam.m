function [ output_args ] = display_seam( im,seam,seamDirection )
%DISPLAY_SEAM Summary of this function goes here
%   Detailed explanation goes here

[m,n,p] = size(im);
imshow(im);
hold on;

if strcmp(seamDirection, 'VERTICAL')
    plot(seam, (1:m), 'r-');
else
    plot(seam, 'r-');
end

end

