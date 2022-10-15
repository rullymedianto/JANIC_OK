function [vz,vx,vy] = speedchanges(h_aircraft,h_desire,vertical_speed,v,heading,speed_changes)
global sen_descent sen_climb

if h_aircraft > h_desire && (h_aircraft - h_desire) > sen_descent
    vz = -1*vertical_speed;
elseif h_aircraft < h_desire && (h_desire - h_aircraft) > sen_climb
    vz = 1*vertical_speed;
else
    vz = 0;
end

% Vlatlong = sqrt(v^2 - vz^2) - speed_changes;
Vlatlong = v - speed_changes;

vx = Vlatlong*sind(heading);
vy = Vlatlong*cosd(heading);

end