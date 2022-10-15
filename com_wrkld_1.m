function [w_in,w_out,w_vec,w_con,w_cros] = com_wrkld_1(sector_old,sector_new,clearance_old,clearance_new,resolution_old,resolution_new,crossing)
%Function for determine controller communication workload time in Terminal North
%   Detailed explanation goes here

if (sector_old== 0 && sector_new== 1)||(sector_old== 4 && sector_new== 1) 
   w_in= 1; % Enter sector  Check
else
   w_in= 0;
end

if (sector_old== 1 && sector_new== 0)|| (sector_old== 1 && sector_new== 4)
   w_out= 1; % Exit sector  Check
else
   w_out= 0;
end
 
if (clearance_old== 1 && clearance_new== 0 && sector_new== 1 && resolution_new == 2) || (resolution_old== 2 && sector_new== 1 && resolution_new == 0)
   w_vec= 1; % Radar vector
else
   w_vec= 0;
end

if clearance_old== 1 && clearance_new== 0 && sector_new== 1 && resolution_new~= 2 && resolution_new~= 0
   w_con= 1; % Control conflict
else
   w_con= 0;
end
 
if clearance_old== 1 && clearance_new== 0 && sector_new== 6 &&  resolution_new~= 0 && crossing == 1
   w_cros= 1; % Control crossing conflict
else
   w_cros= 0;
end

end
