function [dw] = difwptcal(vx,swpt)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if vx+1 > swpt
    dw=1;
else 
    dw=0;
end
end

