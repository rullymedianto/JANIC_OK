function [vz,vx,vy] = speed(h_aircraft,h_desire,rate,v,heading)
if h_aircraft > h_desire
    vz = -1*rate;
elseif h_aircraft < h_desire
    vz = 1*rate;
else
    vz = 0;
end

Vlatlong = sqrt(v^2 - vz^2);

vx = Vlatlong*sind(heading);
vy = Vlatlong*cosd(heading);

end