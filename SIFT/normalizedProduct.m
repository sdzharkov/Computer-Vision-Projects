function [ c ] = normalizedProduct( a, b )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    c = dot(a,b);
    c = c / (norm(a) * norm(b));

end

