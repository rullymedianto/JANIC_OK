function [y] = Queueing4cross(x,airplane)
a = 1;
b = 1;

y = sortrows(x',2:4)';
y = ceil(y);
y(5,1) = 1;

for j = 1:airplane-1
 
 %% ROW Numbering  
 % Same Waypoint
if y(2,j) == y(2,j+1) && y(3,j) == y(3,j+1)
    y(5,j+1) = y(5,j) + 1;
  
 % Different Waypoint
elseif y(2,j)~= y(2,j+1) || y(3,j) ~= y(3,j+1)
    y(5,j+1) = y(5,j)+1;
    


end   
end