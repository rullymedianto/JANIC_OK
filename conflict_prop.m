function [BIP_1,BIP_2,BIP_3,BIP_4,BIP_5,BIP_6] = conflict_prop(sector_no,clearance)
%Function to determine conflict proportion
%   Detailed explanation goes here

% if sum(nonzeros(sector_no))>0
% BIP_proportion= sum(clearance_all=0 && sector_no=1)/sum(nonzeros(sector_no_all=1)); %% BIP proportion
% else
% BIP_proportion=0;
% end

SECTOR1 = sector_no ==1;
CONFLICT1 = clearance == 0 & sector_no ==1;

SECTOR2 = sector_no ==2;
CONFLICT2 = clearance == 0 & sector_no ==2;

SECTOR3 = sector_no ==3;
CONFLICT3 = clearance == 0 & sector_no ==3;

SECTOR4 = sector_no ==4;
CONFLICT4 = clearance == 0 & sector_no ==4;

SECTOR5 = sector_no ==5;
CONFLICT5 = clearance == 0 & sector_no ==5;

SECTOR6 = sector_no ==6;
CONFLICT6 = clearance == 0 & sector_no ==6;

% sector1 = sum(SECTOR1);
% conflict1 = sum(CONFLICT1);
%  
% sector2 = sum(SECTOR2);
% conflict2 = sum(CONFLICT2);
% 
% sector1 = sum(SECTOR1);
% conflict1 = sum(CONFLICT1);
%  
% sector1 = sum(SECTOR1);
% conflict1 = sum(CONFLICT1);
% 
% sector1 = sum(SECTOR1);
% conflict1 = sum(CONFLICT1);
%  
% sector1 = sum(SECTOR1);
% conflict1 = sum(CONFLICT1);

 if sum(SECTOR1) > 0
BIP_1 = sum(CONFLICT1)/sum(SECTOR1);
 else
    BIP_1 = 0;
 end
 
 if sum(SECTOR2) > 0
BIP_2 = sum(CONFLICT2)/sum(SECTOR2);
 else
    BIP_2 = 0;
 end
 
  if sum(SECTOR3) > 0
BIP_3 = sum(CONFLICT3)/sum(SECTOR3);
 else
    BIP_3 = 0;
  end
 
   if sum(SECTOR4) > 0
BIP_4 = sum(CONFLICT4)/sum(SECTOR4);
   else
    BIP_4 = 0;
   end
 
    if sum(SECTOR5) > 0
BIP_5 = sum(CONFLICT5)/sum(SECTOR5);
    else
    BIP_5 = 0;
    end
 
     if sum(SECTOR6) > 0
BIP_6 = sum(CONFLICT6)/sum(SECTOR6);
    else
    BIP_6 = 0;
    end
 % conflict=sum(nonzeros(clearance_all)&& sector_no==1); %Jumlah BIP
% ac_sector= sum(nonzeros(sector_no_all)&& sector_no ==1); %Jumlah pesawat di sektor

end

