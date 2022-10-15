function [vy1] = yspeed1(vz,v,dwpt_y,heading)
dey = 5;
dey1 = dey*cosd(heading);

vy1 = sqrt(v^2 - vz^2)*cosd(heading);
if dwpt_y == 0
vy1 = vy1;

elseif dwpt_y == -1
 if vy1 > 0
    vy1 = vy1- dey1;
    elseif vy1<0
        vy1 = Vy1+dey1;
    end
    
elseif dwpt_y == 1
 if vy1 > 0
    vy1 = vy1+ dey1;
elseif vy1<0
        vy1 = vy1-dey1;
    end

end