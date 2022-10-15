function [y] = clearance(ROW,conflict,airplane,j,distance,buffer_zone_1,buffer_zone_2,height,hold_status,conflict3,distancemerg)

if height > meter(10000)
    buffer_zone = buffer_zone_1;
else
    buffer_zone = buffer_zone_2;
end
a = 1;
ROW = sortrows(ROW',1)';
%Calculating same Waypoint for Clearance decision
for i = 1:airplane

    if ROW(2,j) == ROW(2,i) && ROW(3,j) == ROW(3,i)
        temp1(1,a) = i;
        a = a+1;
    else
        a = a;
    end
 
end

%New Matrix
row = size(temp1);
row = row(1,2);

for i = 1:row
temp2(1,i) = temp1(1,i);
temp2(2,i) = conflict(1,(temp1(1,i)));
temp2(3,i) = ROW(5,(temp1(1,i))); %%ROW
temp2(4,i) = ROW(4,(temp1(1,i))); %%Queueing
end

%Number Column
column = find(temp1(1,:) == j);
it_1 = temp2(3,column); %% ROW Airplane
it_2 = sortrows(temp2',3)';
column1 = find(it_2(1,:) == j);


if conflict(1,j) == 0
    y = 1;

    
elseif conflict(1,j) == 1  %
    if column1 == 1
       y = 1;
  
    else
       k = it_2(1,column1-1);
       if it_2(2,column1-1) == 0 % && distance(j,k) > buffer_zone && distancemerg (j,k)> buffer_zone 
           y = 1;
           
%        elseif it_2(2,column1-1) == 0 && distance(j,k) < buffer_zone && distancemerg (j,k)< buffer_zone
%            y = 1;      
       
       elseif it_2(2,column1-1) == 1 && distance(j,k) > buffer_zone && distancemerg (j,k)> buffer_zone
           y = 1;
           
         
       elseif it_2(2,column1-1) == 1 && distance(j,k) < buffer_zone % || distancemerg (j,k)< buffer_zone) %%Revisi di sini
           y = 0;
           
     elseif it_2(2,column1-1) == 1 && distancemerg (j,k)< buffer_zone && distancemerg (j,k)~= 0
           y = 0;
        
       else
           y= 1;
          
       end
    end
end

% if y == 1 && hold_status == 1
%     y==0;
% else
%     y==1;
% end

end