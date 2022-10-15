function [hold] = plot_holding(Holding_status)



AB = Holding_status(1,:);

 
% AF = find(AB,1) ;
% AG = find(AB,2);
% AH = find(AB,3);
% AI = find(AB,4);

AF = find(AB,1) ;
% AF = find(AD == 0);
 
%desc= AF;
hold = sum(AF>0);
% no2 = sum(AG>0);
% no3 = sum(AH>0);
% no4 = sum(AI>0);
end