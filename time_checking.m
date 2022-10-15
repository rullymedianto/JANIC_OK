function [tc1,tc2,tc3] = time_checking(i,enter,exit,tc1_old,tc2_old)
%determine the  time of aircrft in the sector
%   Detailed explanation goes here

if enter== 1
tc1 = i;%Time Enter Sector
else
tc1 = tc1_old; 
end

if exit== 1
tc2 = i;% Time Exit Sector
else
tc2 = tc2_old;
end

if tc2> tc1
tc3 = tc2- tc1;% Time in Sector
else
tc3 = 0;
end


end

