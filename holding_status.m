function [holdstat] = holding_status(hold)

AB = hold(11,:);
 
AF = find(AB,1) ;

% AF = find(AD == 0);
 
%desc= AF;
holdstat = sum(AF>0);

end