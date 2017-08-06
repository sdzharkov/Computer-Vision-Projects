function [ H ] = computeH( t1, t2 )
% create the homography matrix with the set of two points 
[m ,n] = size(t1); % get size of the matrix 
[m1, n1] = size(t2);
if m ~= 2 || m1 ~= 2 % the matrices being passed in have to be 2xN
    error('Wrong size of matrix being passed in');
elseif n ~= n1
    error('Not the same amount of rows');
end

    function item = getItem(x, t, dir)
        item = t(dir, (x+1)/2);
    end

A = zeros(2*n, 9); % create the homography matrix 

for x = 1:2:2*n
    A(x, :) = [getItem(x,t1, 1) getItem(x,t1,2) 1 0 0 0 -getItem(x, t2, 1)*getItem(x,t1, 1) -getItem(x,t2, 1)*getItem(x,t1,2) -getItem(x, t2, 1)];
    A(x+1, :) = [0 0 0 getItem(x, t1, 1) getItem(x,t1, 2) 1 -getItem(x,t2,2)*getItem(x,t1,1) -getItem(x,t2,2)*getItem(x,t1,2) -getItem(x,t2, 2)];
end

h = A' * A;
[Hx, Hy]  = eig(h);
[~, mLocation] = min(diag(Hy));
H = reshape(Hx(:,mLocation), [3,3]);
H = H';

end

