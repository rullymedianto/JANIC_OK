function [tcom1] = slot_time(tcom,sector_in,sector_out,vectoring,conflict,crossing)
%Function for determine controller communication workload time in Terminal North
%   Detailed explanation goes here

 
tcin   = 16;% Communication time for coordination in sec
tcout  = 14; % Communication time for coordination out sector
% tcid   = 12; % Communication time for radar identification 
tcvec  = 16; % Communication time for radar vectoring 
tccon  = 15; % Communication time for control conflict
tccros = 70; % Workload for crossing conflict

% twl    = tcom ; %initial workload time
% if timer==1
%     tcom1=0;
% end

 %% Communication Time Lower North%%% 
 
 if tcom>0
     twl=tcom-1;
 else
     twl = tcom ;
 end
 
 
 if any(sector_in ==1)
     twl= twl+tcin;
 elseif any(sector_out ==1)
     twl= twl+tcout;
 elseif any(vectoring == 1)
     twl= twl+tcvec;
 elseif any(conflict == 1)
     twl= twl+tccon;
 elseif any(crossing == 1)
     twl= twl+tccros;
 else
     twl=twl+0;
 end
 
  tcom1 = twl;
  

  
end
