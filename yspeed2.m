function [vy] = yspeed2(vz,vplus,vnol,heading)



% if wpt1 == wpt17
% dw = 1;
% else
%     dw=0;
% 
% 
% if dw==0
    
 if vplus<vnol
     vnol = vnol-1
     
     elseif vplus>vnol
         vnol = vnol+1
         
     else
         vnol = vnol
 end
     
% else
%     vnol=vnol
% end

vy = sqrt(vnol^2 - vz^2)*cosd(heading);
end