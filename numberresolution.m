function [no1, no2, no3, no4] = numberresolution(sim1)

AB = sim1(10,:);
 
AF = find(AB,1) ;
AG = find(AB,2);
AH = find(AB,3);
AI = find(AB,4);


% AF = find(AD == 0);
 
%desc= AF;
no1 = sum(AF>0);
no2 = sum(AG>0);
no3 = sum(AH>0);
no4 = sum(AI>0);
end