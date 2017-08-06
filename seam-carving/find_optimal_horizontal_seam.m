function [ horizontal_seam ] = find_optimal_horizontal_seam( cumulative_energy_map )
%FIND_OPTIMAL_HORIZONTAL_SEAM Summary of this function goes here
%   Detailed explanation goes here
    new = cumulative_energy_map'; % transposed image 
    [m,n] = size(new);
    horizontal_seam = zeros(1,m);
 
    [val,index] = min(new(m, :)); % get the index of the minimum value 
    horizontal_seam(m) = index; % update the back of the array with the location of the minimum
    
    for x = m:-1:2              % go until 2 because it updates one ahead already
        location = horizontal_seam(x);  % the previous location
        if location == 1
            [val,index] = min([255, new(x-1,location), new(x-1, location+1)]); % Currently on the edge of the matrix, only look at two values
            switch(index)
                case 1
                    error('this is impossible');
                case 2
                    horizontal_seam(x-1) = location;
                case 3
                     horizontal_seam(x-1) = location+1;
            end
        elseif horizontal_seam(x) == n
            [val,index] = min([new(x-1,location-1), new(x-1, location), 255]);
            switch(index)
                case 1
                    horizontal_seam(x-1) = location-1;
                case 2
                    horizontal_seam(x-1) = location;
                case 3
                     error('This is not possible');
            end
        else
            [val,index] = min([new(x-1,location-1), new(x-1,location), new(x-1, location+1)]);
            switch(index)
                case 1
                    horizontal_seam(x-1) = location-1;
                case 2
                    horizontal_seam(x-1) = location;
                case 3
                    horizontal_seam(x-1) = location+1;
            end
        end
    end
end

