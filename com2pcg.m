function [c2s] = com2pcg(x)
%Function to converte  complexity to decision delay 

if (0.18>x) && (x>=0)
   c2s = 1; % very Light Load
elseif (0.30>x) && (x>=0.18)
   c2s = 2; % Light Load
elseif (0.54>x) && (x>=0.30)
   c2s = 3; % Medium Load
elseif (0.70>x) && (x>=0.54)
   c2s = 4; % Heavy Load
elseif x>=0.70
   c2s = 5; % Overload


end
end

