function [d_hor,d_ver,d_mer] = distance_con(x1,x2,y1,y2,z1,z2,rute1,rute2,segmen1,segmen2)
%Define distance between each aircraft
%   Detailed explanation goes here
d_hor = sqrt((x1 - x2).^2 + (y1 - y2).^2); %Horizontal distance 

d_ver = sqrt((z1 - z2).^2); %% Vertical distance;

if rute1 ~= rute2
    if  (rute1 == 1 && rute2 == 2 && (segmen1 == 3 || segmen1 == 4) && (segmen2 == 3 || segmen2 == 4)) || (rute1 == 1 && rute2 == 3 && (segmen1 == 3 || segmen1 == 4) && (segmen2 == 3 || segmen2 == 4)) || (rute1 == 2 && rute2 == 3 && (segmen1 == 3 || segmen1 == 4) && (segmen2 == 3 || segmen2 == 4))% Merging di NOKTA
        d_mer = sqrt((x1 - x2).^2 + (y1 - y2).^2);
    elseif rute1 == 4 && rute2 == 5 && segmen1 == 2 && segmen2 == 2  % Merging di GASPA
         d_mer = sqrt((x1 - x2).^2 + (y1 - y2).^2);
    elseif  rute1 == 7 && rute2 == 8 && segmen1 == 2 && segmen2 == 2  % Merging di IMU 
         d_mer = sqrt((x1 - x2).^2 + (y1 - y2).^2);
    elseif (rute1 == 4 && rute2 == 5 && segmen1 == 3 && segmen2 == 3) || (rute1 == 4 && rute2 == 6 && segmen1 == 3 && segmen2 == 2) || (rute1 == 4 && rute2 == 7 && segmen1 == 3 && segmen2 == 4) || (rute1 == 4 && rute2 == 8 && segmen1 == 3 && segmen2 == 4)|| (rute1 == 5 && rute2 == 6 && segmen1 == 3 && segmen2 == 2) || (rute1 == 5 && rute2 == 7 && segmen1 == 3 && segmen2 == 4) || (rute1 == 5 && rute2 == 8 && segmen1 == 3 && segmen2 == 4) || (rute1 == 6 && rute2 == 7 && segmen1 == 2 && segmen2 == 4) || (rute1 == 6 && rute2 == 8 && segmen1 == 2 && segmen2 == 4) || (rute1 == 7 && rute2 == 8 && segmen1 == 4 && segmen2 == 4)% Merging di GAPRI
         d_mer = sqrt((x1 - x2).^2 + (y1 - y2).^2);
    else
         d_mer = 0;
    end
 
else
    d_mer = 0;

end

