function [vy] = yspeed(vz,v,heading)
vy = sqrt(v^2 - vz^2)*cosd(heading);
end