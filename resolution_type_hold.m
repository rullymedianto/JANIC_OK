function [ta] = resolution_type_hold()
% t=hold_point;

% if hold_point == 0
%%Probability:
% AA = 0.0; % 1 == Holding
% AB = 0.1; % 2 == Altitude Control
% AC = 0.1; % 3 == Vectoring
% AD = 0.8; % 4 == Speed Control
% 
% else
AA = 0.00; % 1 == Altitude Control
AB = 0.5; % 2 == Vectoring
AC = 0.5; % 3 == Speed Control
AD = 0.00; % 4 == Holding
% end

AAB = AA+AB;
BB = (AAB-AA)/AAB;

if BB <= rand()
    type1 = 1; %Holding; 
else 
    type1 = 2;%Altitude
end

AAC = AAB + AC;
CC = (AAC-AAB)/AAC;

if CC <= rand()
    type2 = type1; 
else 
    type2 = 3;%Vectoring
end

% if 0.5 <= rand()
%     heavy = 4; 
% else 
%    heavy = 5;
% end

AAD = AAC +AD;
DD = (AAD-AAC)/AAD;

if DD <= rand()
    select = type2 ; 
else 
    select = 4; %Speed Resolution
end

ta=select;

end
