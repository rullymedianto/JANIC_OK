function [dw] = difwpt_x(vxroute,wpt,endwpt)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if wpt == endwpt
    ds=0;
else 
    ds=1;
end

if ds == 1 && vxroute+1 > vxroute
    dw = 1;
elseif ds == 1 && vxroute+1 < vxroute
    dw = -1;
    
elseif ds == 0 || vxroute+1 == vxroute
    dw = 0 ;
end

end

