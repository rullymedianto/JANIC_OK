function [c2s] = com2sac(x)
%Function to converte  complexity to decision delay 

if (0.18>x) && (x>=0)
   c2s = 0; % very Light Load
elseif (0.30>x) && (x>=0.18)
   c2s = 0; % Light Load
elseif (0.54>x) && (x>=0.30)
   c2s = 1; % Medium Load
elseif (0.7>x) && (x>=0.54)
   c2s = 2; % Heavyload
elseif x>=0.7
   c2s = 4; % Overload
end
end

