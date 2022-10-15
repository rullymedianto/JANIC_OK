function [ta] = resolution_type()
% t=hold_point;

% if hold_point == 0
% %%Probability:
% AA = 0.0; % 1 == Holding
% AB = 0.1; % 2 == Altitude Control
% AC = 0.1; % 3 == Vectoring
% AD = 0.8; % 4 == Speed Control
% 
% elsef
% AA = 0.15; % 1 == Holding
AB = 0.00; % 1 == Altitude Control
AC = 0.00; % 2 == Vectoring
AD = 1.00; % 3 == Speed Control
% end

ABAC = AB+AC;
BB = (ABAC-AB)/ABAC;

if BB <= rand()
    type1 = 1; %Altitude
else 
    type1 = 2;%Vectoring 
end

AAC = ABAC + AD;
CC = (AAC-ABAC)/AAC;

if CC <= rand()
    type2 = type1 ;
else 
    type2 = 3;%Speed Control
end

select = type2;

% AAD = AAC +AD;
% DD = (AAD-AAC)/AAD;
% 
% if DD <= rand()
%     select = type2 ; 
% else 
%     select = 3; %Speed Resolution
% end

ta=select;

end
