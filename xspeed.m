function [vx] = xspeed(vz,v,heading)



%  if vplus<vnol
%      v = v-1
%      
%      if else v1>v
%          v = v+1
%          
%      else
%          v = v

vx = sqrt(v^2 - vz^2)*sind(heading);
end