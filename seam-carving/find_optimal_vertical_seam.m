function [ vertical_seam ] = find_optimal_vertical_seam( cumulative_energy_map )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%     global index;
    new = cumulative_energy_map;
    [m,n] = size(new);
    vertical_seam = zeros(1,m);
    [value,index] = min(new(m, :));
    vertical_seam(m) = index;
    for x = m:-1:2
        location = vertical_seam(x);
        if location == 1
            [val,index] = min([255, new(x-1,location), new(x-1, location+1)]);
            switch(index)
                case 1
                    error('this is impossible');
                case 2
                    vertical_seam(x-1) = location;
                case 3
                     vertical_seam(x-1) = location+1;
            end
        elseif vertical_seam(x) == n
            [val,index] = min([new(x-1,location-1), new(x-1, location), 255]);
            switch(index)
                case 1
                    vertical_seam(x-1) = location-1;
                case 2
                    vertical_seam(x-1) = location;
                case 3
                     error('This is not possible');
            end
        else
            [val,index] = min([new(x-1,location-1), new(x-1,location), new(x-1, location+1)]);
            switch(index)
                case 1
                    vertical_seam(x-1) = location-1;
                case 2
                    vertical_seam(x-1) = location;
                case 3
                    vertical_seam(x-1) = location+1;
            end
        end
    end
end

