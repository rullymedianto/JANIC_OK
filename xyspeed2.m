function [vx vy] = xyspeed2(vz,vplus,vnol,heading)
%% Calculate Vy  
    
 if vplus<vnol
  
     vnol = vnol-1;

     elseif vplus>vnol
         if vnol==0
             vnol = vplus;
         else
         vnol = vnol+1;
         end
     else
         vnol = vnol;
 end

vy = sqrt(vnol^2 - vz^2)*cosd(heading);
vx = sqrt(vnol^2 - vz^2)*sind(heading);
end