function [HP] = holding_point(waypoint,route)
% Specify which holding point

if (route == 1 &&  waypoint == 2) % ||  (route == 2 &&  waypoint == 2) || (route == 3 &&  waypoint == 1) % Holding point GAPRI
    HP = 1; % Holding point GAPRI
elseif (route == 4 &&  waypoint == 1) %||  (route == 5 &&  waypoint == 1)
    HP = 2; % Holding point IMU
elseif (route == 1 &&  waypoint == 1) %||  (route == 1 &&  waypoint == 1)
    HP = 3; % Holding point GASPA
elseif (route == 1 &&  waypoint == 4) %||  (route == 2 &&  waypoint == 4) ||( route == 3 &&  waypoint == 3) ||  (route == 4 &&  waypoint == 4) || (route == 5 &&  waypoint == 5)
    HP = 4 ;% Holding point ESALA
elseif (route == 6 &&  waypoint == 2) 
    HP = 5; % Holding point CARLI
elseif (route == 8 &&  waypoint == 1) 
    HP = 6; % Holding point DENDY
elseif (route == 7 &&  waypoint == 1) 
    HP = 7 ;% Holding point BUNIK
elseif (route == 6 &&  waypoint == 4) %||  (route == 7 &&  waypoint == 2) ||( route == 8 &&  waypoint == 3) 
    HP = 8; % Holding point NOKTA
else
    HP = 0;
end
end

