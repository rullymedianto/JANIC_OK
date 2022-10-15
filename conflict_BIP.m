function [BIP_1,BIP_2,BIP_3,BIP_4,BIP_5,BIP_6] = conflict_BIP(sector_no,clearance)
%Function to determine conflict BIP
CONFLICT1 = clearance == 0 & sector_no ==1;
CONFLICT2 = clearance == 0 & sector_no ==2;
CONFLICT3 = clearance == 0 & sector_no ==3;
CONFLICT4 = clearance == 0 & sector_no ==4;
CONFLICT5 = clearance == 0 & sector_no ==5;
CONFLICT6 = clearance == 0 & sector_no ==6;
 
BIP_1 = sum(CONFLICT1);
BIP_2 = sum(CONFLICT2);
BIP_3 = sum(CONFLICT3); 
BIP_4 = sum(CONFLICT4);
BIP_5 = sum(CONFLICT5);
BIP_6 = sum(CONFLICT6);

end

