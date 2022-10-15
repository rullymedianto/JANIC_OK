function [vx1] = xspeed1(vz,v,dwpt_x,heading)
dex = 5;
dex1 = dex*sind(heading);

vx1 = sqrt(v^2 - vz^2)*sind(heading);

if dwpt_x == 0
vx1 = vx1;

elseif dwpt_x == -1
    if vx1 > 0
    vx1 = vx1- dex1;
    elseif vx1<0
        vx1 = vx1+dex1;
    end
    
elseif dwpt_x == 1
 if vx1 > 0
    vx1 = vx1+ dex1;
elseif vx1<0
        vx1 = vx1-dex1;
    end
end

end