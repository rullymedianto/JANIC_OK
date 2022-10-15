function [clim1, clim2, clim3, clim4, clim5, clim6] = vector_climb1(sim1)
% global lim_low lim_up


AB = sim1(1,:);
AD = sim1(20,:);
AG = sim1(29,:);

 AA1 = AB>1 & AD == 1 & AG == 1 ; % Lower North (LN)
 AA2 = AB>1 & AD == 1 & AG == 2; % Lower Centre (LC)
 AA3 = AB>1 & AD == 1 & AG == 3; % Lower East (LE)
 AA4 = AB>1 & AD == 1 & AG == 4 ; % Terminal West (TW)
 AA5 = AB>1 & AD == 1 & AG == 5; % Terminal East (TE)
 AA6 = AB>1 & AD == 1 & AG == 6; % Terminal South (TS)
 

% AF = find(AD == 0);
 
%desc= AF;
clim1 = sum(AA1>0);
clim2 = sum(AA2>0);
clim3 = sum(AA3>0);
clim4 = sum(AA4>0);
clim5 = sum(AA5>0);
clim6 = sum(AA6>0);

end