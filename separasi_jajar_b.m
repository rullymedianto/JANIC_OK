function [d_hor,d_ver,d_mer] = separasi_jajar_b(x1,x2,y1,y2,z1,z2,rute1,rute2,segmen1,segmen2,dr1,dr2)
%Define distance between each aircraft

if (((rute1 == 2 && rute2 == 3)||(rute1 == 3 && rute2 == 2)) && (segmen1 == 2 || segmen1 == 3) && (segmen2 == 2|| segmen2 == 3)) || (((rute1 == 1 && rute2 == 3)||(rute1 == 3 && rute2 == 1)) && (segmen1 == 2 || segmen1 == 3) && (segmen2 == 2|| segmen2 == 3))|| (((rute1 == 1 && rute2 == 2)||(rute1 == 2 && rute2 == 1)) && (segmen1 == 2 || segmen1 == 3) && (segmen2 == 2|| segmen2 == 3))% Merging    
    d_mer = abs(dr1-dr2);
else
    d_mer = 0;
end

d_hor = sqrt((x1 - x2).^2 + (y1 - y2).^2); %Horizontal distance 
d_ver = sqrt((z1 - z2).^2); %% Vertical distance;

end