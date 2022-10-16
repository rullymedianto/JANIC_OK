
i=76;
c1=1;
c2=2

Sim1{1,i}(2,c1)
Sim1{1,i}(2,c2)
Sim1{1,i}(3,c1)
Sim1{1,i}(3,c2)
Sim1{1,i}(4,c1)
Sim1{1,i}(4,c2)
Sim1{1,i}(27,c1)
Sim1{1,i}(27,c2)
Sim1{1,i}(1,c1)
Sim1{1,i}(1,c2)
Sim1{1,i}(13,c1)
Sim1{1,i}(13,c2)


if rute1==rute2
d_hor = sqrt((x1 - x2).^2 + (y1 - y2).^2); %Horizontal distance 
d_mer = 0;

elseif rute1 ~= rute2
    if  (rute1 == 1 && rute2 == 6 && (segmen1 == 2 || segmen1 == 3) && (segmen2 == 2|| segmen2 == 3)) || (rute1 == 1 && rute2 == 3 && (segmen1 == 2 || segmen1 == 3) && (segmen2 == 2|| segmen2 == 3))|| (rute1 == 1 && rute2 == 2 && (segmen1 == 2 || segmen1 == 3) && (segmen2 == 2|| segmen2 == 3))% Merging
%         d_mer = sqrt((x1 - x2).^2 + (y1 - y2).^2);
        d_mer = abs(sqrt((dx1).^2 + (dy1).^2)-sqrt((dx2).^2 + (dy2).^2));
        d_hor = 0;
        
%     elseif  (rute1 == 6 && rute2 == 1 && (segmen1 == 2 || segmen1 == 3) && (segmen2 == 2|| segmen2 == 3)) || (rute1 == 3 && rute2 == 1 && (segmen1 == 2 || segmen1 == 3) && (segmen2 == 2|| segmen2 == 3))% Boleh dihapus
%         d_mer = sqrt((x1 - x2).^2 + (y1 - y2).^2);
%         d_hor = 0;
        
    elseif rute1 == 1 && rute2 == 3 && (segmen1 == 4 || segmen1 == 5) && (segmen2 == 4|| segmen2 == 5)
        d_hor = sqrt((x1 - x2).^2 + (y1 - y2).^2); %Horizontal distance
        d_mer = 0;
        
%      elseif rute1 == 3 && rute2 == 1 && (segmen1 == 4 || segmen1 == 5) && (segmen2 == 4|| segmen2 == 5)
%         d_hor = sqrt((x1 - x2).^2 + (y1 - y2).^2); %Horizontal distance
%         d_mer = 0;
        
   else
    d_hor = 0;
    d_mer = 0;
    
    end
end

d_ver = sqrt((z1 - z2).^2); %% Vertical distance;