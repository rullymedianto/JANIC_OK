%% Define Cell
%Simulation Time
%time = 1200;
tic
Sim1 = cell(1,time);
%% Import Data from PlaneGenerator
% close all
load('PlaneGenerator.mat')

lat_RADAR = -25118.4;
lon_RADAR = -71138.2;

global lim_low lim_up lim_vel sen_descent sen_climb 
lim_low = meter(3500);   % lower limit
lim_up = meter(15000);  % upper limit
lim_vel = 82;           % limit lower velocity
sen_descent = 0.7;        % sensitivitas sensor to desc  ent
sen_climb = 0.7;        % sensitivitas sensor to climb
t=time;
d=2;
tol_max = 0.5;
tol_min = -0.5;

%% Global Variable    
%% INPUT DESIRE SEPARATION
buffer_zone_1 = nm(15); %Above 10.000 ft
buffer_zone_2 = nm(8); %Below 10.000 ft
conflict_separation_1 = nm(5); % LOS above 10.000 ft
conflict_separation_2 = nm(3); % LOS below 10.000 ft

%Airplane-Airplane Distance cell
Distance_XY = cell(1,time);
Distance_Altitude = cell(1,time);
Distance_Merg = cell (1,time);

%rate of descent/climb
rate_descent = mpersec(1300);
rate_climb   = mpersec(800);

%Conflict Cell
Conflict = cell(1,time);
Conflict_0 = cell(1,time);
Conflict_1 = cell(1,time);
Conflict_2 = cell(1,time);
Conflict_3 = cell(1,time);


ROW = cell(1,time);
ROW_Detail = cell(1,time);
ROW_Airplane = cell(1,time);
% Time_stamp = zeros(13,airplane);
Distance_XY_Plot = cell(1,time);
Separation_Minimum = zeros(1,time);
complex = zeros (1,time);
con_prop = cell(1,time);
con_proport= zeros(3,time);

%Controller
COMCTR = cell(1,time);
COMCTR1 = zeros(1,time);
% slot = zeros(1,time);
Timecheck = cell(1,time);
TimeAVG = zeros(2,airplane);

%Speed_control
speed_changes = 0.5;
deviation_angle = 15;

csac = zeros(1,time);

%%  Simulation
for i = 1:time
%     if i==1
%         csac(1,i) = 0;
%     end
%Conflict Definition and Detection
    for c1 = 1:airplane
            for c2 = 1:airplane
                %Aircraft-Aircraft Distance_XY
                if c1 == c2 || Sim1{1,i}(4,c1) >= 9000000 || Sim1{1,i}(4,c2) >= 9000000
                    Distance_XY{1,i}(c1,c2) = 0;
                    Distance_Altitude{1,i}(c1,c2) = 0;
                    Distance_Merg{1,i}(c1,c2) = 0;
                else
                    [Distance_XY{1,i}(c1,c2),Distance_Altitude{1,i}(c1,c2),Distance_Merg{1,i}(c1,c2)] = separasi(Sim1{1,i}(2,c1),Sim1{1,i}(2,c2),Sim1{1,i}(3,c1),Sim1{1,i}(3,c2),Sim1{1,i}(4,c1),Sim1{1,i}(4,c2),Sim1{1,i}(27,c1),Sim1{1,i}(27,c2),Sim1{1,i}(1,c1),Sim1{1,i}(1,c2));
                end

 %% For Radius 10NM-75NM
 
 if Sim1{1,i}(4,c1)> meter(2000) && Sim1{1,i}(4,c1)< 500000   

 %% Potential Conflict Definition              
                if Distance_XY{1,i}(c1,c2) < buffer_zone_1 && Distance_XY{1,i}(c1,c2) ~= 0 && Distance_Altitude{1,i}(c1,c2) <= meter(2000)
                    Conflict{1,i}(c1,c2) = 1;
                else
                    Conflict{1,i}(c1,c2) = 0;
                end
                
                if Distance_Merg{1,i}(c1,c2) < buffer_zone_1 && Distance_Merg{1,i}(c1,c2) ~= 0
                    Conflict_3{1,i}(c1,c2) = 1;
                else
                    Conflict_3{1,i}(c1,c2) = 0;
                end
%% Conflict Definition              
                if Distance_XY{1,i}(c1,c2) < conflict_separation_1  && Distance_XY{1,i}(c1,c2) ~= 0 && Distance_Altitude{1,i}(c1,c2) <= meter(1000)
                    Conflict_0{1,i}(c1,c2) = 1;
                elseif Distance_XY{1,i}(c1,c2) == 0
                    Conflict_0{1,i}(c1,c2) = 0;
                else
                    Conflict_0{1,i}(c1,c2) = 0;
                end
         
       %% For Radius 10NM
       else 
                %Potential Conflict Definition              
                if Distance_XY{1,i}(c1,c2) < buffer_zone_2 && Distance_XY{1,i}(c1,c2) ~= 0 && Distance_Altitude{1,i}(c1,c2) <= meter(2000)
                    Conflict{1,i}(c1,c2) = 1;
                else
                    Conflict{1,i}(c1,c2) = 0;
                end
                
               if Distance_Merg{1,i}(c1,c2) < buffer_zone_2 && Distance_Merg{1,i}(c1,c2) ~= 0
                    Conflict_3{1,i}(c1,c2) = 1;
                else
                    Conflict_3{1,i}(c1,c2) = 0;
                end
                
% % Conflict Definition              
                if Distance_XY{1,i}(c1,c2) < conflict_separation_2  && Distance_XY{1,i}(c1,c2) ~= 0 && Distance_Altitude{1,i}(c1,c2) <= meter(1000)
                    Conflict_0{1,i}(c1,c2) = 1;
                else
                    Conflict_0{1,i}(c1,c2) = 0;
                end
                
 end
            end
    end
            
%Conflict Colour
    for j = 1:airplane
        if mean(Conflict{1,i}(:,j)) > 0 %&& mean(Conflict{1,i}(:,j)) > 0
        Conflict_1{1,i}(1,j) = 1;
%         elseif mean(Conflict_0{1,i}(:,j)) <= 0 && mean(Conflict{1,i}(:,j)) > 0  
%         Conflict_1{1,i}(1,j) = 2;
        else
        Conflict_1{1,i}(1,j) = 0;  
        end
    
        if Conflict_1{1,i}(1,j) == 1 && Conflict_0{1,i}(1,j) == 1
            Conflict_2{1,i}(j,:) = [1 0 0];
        elseif Conflict_1{1,i}(1,j) == 1 && Conflict_0{1,i}(1,j) == 0
            Conflict_2{1,i}(j,:) = [1 1 0];
        else
            Conflict_2{1,i}(j,:) = [0 1 0];
        end
    end

%ROW Definition
    for j = 1:airplane
 
        ROW{1,i}(1,j)= j;
       ROW{1,i}(2,j)= Route{1,j}(Sim1{1,i}(1,j),1);
        ROW{1,i}(3,j)= Route{1,j}(Sim1{1,i}(1,j),2);
        ROW{1,i}(4,j)= Sim1{1,i}(13,j);  
    end

%ROW Airplane
    for j = 1:airplane
        ROW_Detail{1,i} = Queueing(ROW{1,i},airplane);
        ROW_Airplane{1,i}(1,:) = ROW_Detail{1,i}(1,:);
        ROW_Airplane{1,i}(2,:) = ROW_Detail{1,i}(5,:);
        ROW_Airplane{1,i} = sortrows(ROW_Airplane{1,i}',1)';
    end
    for c1 = 1:airplane
        for c2 = 1:airplane
            if c1 == c2
            Distance_XY_Plot{1,i}(c1,c2) = 1000000;
            else
                Distance_XY_Plot{1,i}(c1,c2) = Distance_XY{1,i}(c1,c2);
            end
        end
    end

%Separation Minimum
Separation_Minimum(1,i) = min(min(Distance_XY_Plot{1,i}(:,:)));

% %Capacity
% CapacityArray{1,1}(1,1) = 0;
% CapacityArray{1,1}(1,i+1) = capacity(Sim1{1,i},airplane);

for j = 1:airplane
%for k = 1:LD
    
%===========================NEXT WAYPOINT==================================
wptnext = 2500; %% Distance when change to next waypoint 


if  Sim1{1,i}(13,j) < wptnext && Sim1{1,i}(1,j) ~= Sim1{1,i}(17,j) 
        Sim1{1,i+1}(1,j) = Sim1{1,i}(1,j) + 1;
    else 
        Sim1{1,i+1}(1,j) = Sim1{1,i}(1,j);
end

% POSITION    
        
    if sched(i,j)==1
        Sim1{1,i+1}(2,j) = InitialPos(1,j);                    %X
        Sim1{1,i+1}(3,j) = InitialPos(2,j);                    %Y
        Sim1{1,i+1}(4,j) = InitialPos(3,j);                    %Z  
        
    elseif Sim1{1,i}(1,j) == Sim1{1,i}(17,j) 
        
        Sim1{1,i+1}(2,j) = 9.0e+7;                     %X
        Sim1{1,i+1}(3,j) = 9.0e+7;                     %Y
        Sim1{1,i+1}(4,j) = 9.0e+7;                      %Z 
    
    else   
        Sim1{1,i+1}(2,j) = Sim1{1,i}(2,j) + Sim1{1,i}(21,j);                     %X
        Sim1{1,i+1}(3,j) = Sim1{1,i}(3,j) + Sim1{1,i}(22,j);                     %Y
            
        if Sim1{1,i}(1,j) < Sim1{1,i}(17,j)
            
        if  Sim1{1,i}(13,j) < wptnext && Sim1{1,i}(1,j)~= 1
                Sim1{1,i+1}(4,j) = Route{1,j}(Sim1{1,i}(1,j)+1,3);   
            else
                Sim1{1,i+1}(4,j) = Sim1{1,i}(4,j) + Sim1{1,i}(14,j);              %Z
        end
        else
          if  Sim1{1,i}(13,j) < wptnext
                Sim1{1,i+1}(4,j) = Route{1,j}(Sim1{1,i+1}(1,j),3);   
            else
                Sim1{1,i+1}(4,j) = Sim1{1,i}(4,j) + Sim1{1,i}(14,j);              %Z
          end  
            
        end 
    end
                  
        Sim1{1,i+1}(5,j) = Route{1,j}(Sim1{1,i+1}(1,j),1) - Sim1{1,i+1}(2,j);    %Delta x
        Sim1{1,i+1}(6,j) = Route{1,j}(Sim1{1,i+1}(1,j),2) - Sim1{1,i+1}(3,j);    %Delta y
        Sim1{1,i+1}(7,j) = Route{1,j}(Sim1{1,i+1}(1,j),3) - Sim1{1,i+1}(4,j);    %Delta z

%ROW
        Sim1{1,i+1}(8,j) = ROW_Airplane{1,i}(2,j); 
        % ROW : Number (1,2,3,...., n)
%Clearance 

if Sim1{1,i}(19,j)==0
    Sim1{1,i+1}(9,j) = 1;
else
[Sim1{1,i+1}(9,j), Sim1{1,i+1}(31,j)]= clearance(ROW_Detail{1,i},Conflict_1{1,i},airplane,j,Distance_XY{1,i},buffer_zone_1,buffer_zone_2,Sim1{1,i+1}(4,j),Holding_status{1,i}(1,j),Conflict_3{1,i},Distance_Merg{1,i});
        % 0 : No clearance
        % 1 : Clearance
end
%Resolution (10)
[Sim1{1,i+1}(10,j),Time_Trigger{1,i+1}(1,j)] = resolution(Sim1{1,i+1}(9,j),Sim1{1,i}(10,j),i,Time_Trigger{1,i}(1,j),Sim1{1,i+1}(1,j),Sim1{1,i}(27,j),csac(1,i));
Holding_status{1,i+1}(1,j) = 0;

    %% Coba Cek       
if i+d > t+1
    d=1;
else
    d=d;
end

if i==1
    d=1;
else
    d=d;
end

if Sim1{1,i+1}(10,j) == 1 && (Sim1{1,i}(29,j) == 1 && COMCTR{1,i}(5,j)== 0) 
%% Altitude Resolution

% Heading & Relative Heading
        Sim1{1,i+1}(11,j) = angle(Sim1{1,i+1}(5,j),Sim1{1,i+1}(6,j)); %Relative Airplane-Waypoint Course
        Sim1{1,i+1}(12,j) = Sim1{1,i+1}(11,j);   %Airplane Heading
      
% Distance Measure        
        Sim1{1,i+1}(13,j) = sqrt((Sim1{1,i+1}(5,j))^2+(Sim1{1,i+1}(6,j))^2);

% Velocity XYZ
if Sim1{1,i+1}(1,j) < Sim1{1,i}(17,j)        
    Sim1{1,i+1}(14,j) = zspeedchanges(Sim1{1,i+1}(4,j), Route{1,j}(Sim1{1,i+1}(1,j)+1,3),rate_climb, rate_descent);  %Vz
else
    Sim1{1,i+1}(14,j) = Sim1{1,i}(14,j);
end 
        Sim1{1,i+1}(15,j) = xspeed(Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i+1}(12,j));
        Sim1{1,i+1}(16,j) = yspeed(Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i+1}(12,j));
        
% Vtotal
        Sim1{1,i+1}(19,j) = round(sqrt((Sim1{1,i+1}(15,j))^2 + (Sim1{1,i+1}(16,j))^2+(Sim1{1,i+1}(14,j))^2));

% Total Waypoint        
        Sim1{1,i+1}(17,j) = Sim1{1,1}(17,j);    
        
% Merging Point
if Sim1{1,i+1}(1,j) ==  2 || Sim1{1,i+1}(1,j) == 6 || Sim1{1,i+1}(1,j) == 8
else
  Sim1{1,i+1}(18,j) = 0;
end

if Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)> tol_min && Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)< tol_max
    Sim1{1,i+1}(20,j) = 0; %Cruising
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)>tol_max
    Sim1{1,i+1}(20,j) = 1; %Climbing
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)<tol_min
    Sim1{1,i+1}(20,j) = -1; %Descent
end

Sim1{1,i+1}(21,j) = Sim1{1,i+1}(15,j)+ Vw*sind(tetaw+180);
Sim1{1,i+1}(22,j) = Sim1{1,i+1}(16,j)+ Vw*cosd(tetaw+180);
Sim1{1,i+1}(23,j) = round(sqrt((Sim1{1,i+1}(21,j))^2 + (Sim1{1,i+1}(22,j))^2 +(Sim1{1,i+1}(14,j))^2));

     elseif Sim1{1,i+1}(10,j) == 2 && (Sim1{1,i}(29,j) == 1 && COMCTR{1,i}(5,j)== 0)
%% Vectoring Resolution
        % Heading & Relative Heading
                Sim1{1,i+1}(11,j) = angle(Sim1{1,i+1}(5,j),Sim1{1,i+1}(6,j)); %Relative Airplane-Waypoint Course
        if Sim1{1,1}(11,j) <= 180
                Sim1{1,i+1}(12,j) = Sim1{1,1}(11,j) + deviation_angle;   %Airplane Heading
        else
                Sim1{1,i+1}(12,j) = Sim1{1,1}(11,j) - deviation_angle;
        end
% Distance Measure        
                Sim1{1,i+1}(13,j) = sqrt((Sim1{1,i+1}(5,j))^2+(Sim1{1,i+1}(6,j))^2+(Sim1{1,i+1}(7,j))^2);

% Velocity XYZ
if Sim1{1,i+1}(1,j) < Sim1{1,i+1}(17,j)
   Sim1{1,i+1}(14,j) = zspeed(Sim1{1,i+1}(4,j),Route{1,j}(Sim1{1,i+1}(1,j)+1,3),mpersec(Route{1,j}(Sim1{1,i+1}(1,j),5)));  %Vz      
   else
   Sim1{1,i+1}(14,j) = Sim1{1,i}(14,j);
end
                Sim1{1,i+1}(15,j) = xspeed(Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i+1}(12,j));
                Sim1{1,i+1}(16,j) = yspeed(Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i+1}(12,j));
                
% Vtotal
        Sim1{1,i+1}(19,j) = round(sqrt((Sim1{1,i+1}(15,j))^2 + (Sim1{1,i+1}(16,j))^2+(Sim1{1,i+1}(14,j))^2));
% Total Waypoint        
        Sim1{1,i+1}(17,j) = Sim1{1,1}(17,j);   
        
 % Merging Point
if Sim1{1,i+1}(1,j) ==  6 || Sim1{1,i+1}(1,j) == 6 || Sim1{1,i+1}(1,j) == 8 
else
  Sim1{1,i+1}(18,j) = 0;
end

if i+d > t+1
    d=1;
else
    d=d;
end

if i==1
    d=1;
else
    d=d;
end

if Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)> tol_min && Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)< tol_max
    Sim1{1,i+1}(20,j) = 0; %Cruising
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)>tol_max
    Sim1{1,i+1}(20,j) = 1; %Climbing
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)<tol_min
    Sim1{1,i+1}(20,j) = -1; %Descent
end

Sim1{1,i+1}(21,j) = Sim1{1,i+1}(15,j)+ Vw*sind(tetaw+180);
Sim1{1,i+1}(22,j) = Sim1{1,i+1}(16,j)+ Vw*cosd(tetaw+180);
Sim1{1,i+1}(23,j) = round(sqrt((Sim1{1,i+1}(21,j))^2 + (Sim1{1,i+1}(22,j))^2 +(Sim1{1,i+1}(14,j))^2));

     elseif Sim1{1,i+1}(10,j) == 3 && (Sim1{1,i}(29,j) == 1 && COMCTR{1,i}(5,j)== 0) 
%% Speed Resolution

        Sim1{1,i+1}(11,j) = angle(Sim1{1,i+1}(5,j),Sim1{1,i+1}(6,j)); %Relative Airplane-Waypoint Course
        if Sim1{1,i}(1,j) == Sim1{1,i}(17,j)
            Sim1{1,i+1}(12,j) = Sim1{1,i}(12,j);
        else
        Sim1{1,i+1}(12,j) = Sim1{1,i+1}(11,j);
        end
% Distance Measure        
                Sim1{1,i+1}(13,j) = sqrt(Sim1{1,i+1}(5,j)^2+Sim1{1,i+1}(6,j)^2);
% Total Waypoint        
    Sim1{1,i+1}(17,j) = Sim1{1,1}(17,j);  
    
%Velocity XYZ

if Sim1{1,i+1}(1,j) < Sim1{1,i}(17,j)
    Sim1{1,i+1}(14,j) = zspeed(Sim1{1,i+1}(4,j),Route{1,j}(Sim1{1,i+1}(1,j)+1,3),mpersec(Route{1,j}(Sim1{1,i+1}(1,j),5)));  %Vz      
else
    Sim1{1,i+1}(14,j) = Sim1{1,i}(14,j);  %Vz end
end               

%Sim1{1,i+1}(14,j) = zspeed(Sim1{1,i+1}(4,j),Route{1,j}(Sim1{1,i+1}(1,j),3),mpersec(Route{1,j}(Sim1{1,i+1}(1,j),5)));  %Vz
   
                
    if  Sim1{1,i}(19,j)== 0
       Sim1{1,i+1}(15,j)= 0;
       Sim1{1,i+1}(16,j)= 0;
   else
if Sim1{1,i+1}(1,j) < Sim1{1,i+1}(17,j)
        
        [Sim1{1,i+1}(15,j), Sim1{1,i+1}(16,j)] = speed_changes2( Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j)+1,4)),Sim1{1,i}(19,j),Sim1{1,i+1}(12,j),Sim1{1,i+1}(8,j));
         
else
        [Sim1{1,i+1}(15,j), Sim1{1,i+1}(16,j)] = speed_changes2( Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i}(19,j),Sim1{1,i+1}(12,j),Sim1{1,i+1}(8,j));
         
 end
   end            
% Velocity XYZ
%                 [Sim1{1,i+1}(14,j),Sim1{1,i+1}(15,j),Sim1{1,i+1}(16,j)] = speedchanges(Sim1{1,i+1}(4,j), Route{1,j}(Sim1{1,i+1}(1,j),3),mpersec(Route{1,j}(Sim1{1,i+1}(1,j),5)),Sim1{1,i}(19,j),Sim1{1,i+1}(12,j),speed_changes);

% Vtotal
        Sim1{1,i+1}(19,j) = round(sqrt((Sim1{1,i+1}(15,j))^2 + (Sim1{1,i+1}(16,j))^2 +(Sim1{1,i+1}(14,j))^2));
              
 % Merging Point
if Sim1{1,i+1}(1,j) == 2 || Sim1{1,i+1}(1,j) == 6 || Sim1{1,i+1}(1,j) == 8 
else
  Sim1{1,i+1}(18,j) = 0;
end

if i+d > t+1
    d=1;
else
    d=d;
end

if i==1
    d=1;
else
    d=d;
end

if Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)> tol_min && Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)< tol_max
    Sim1{1,i+1}(20,j) = 0; %Cruising
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)>tol_max
    Sim1{1,i+1}(20,j) = 1; %Climbing
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)<tol_min
    Sim1{1,i+1}(20,j) = -1; %Descent
end
   
Sim1{1,i+1}(21,j) = Sim1{1,i+1}(15,j)+ Vw*sind(tetaw+180);
Sim1{1,i+1}(22,j) = Sim1{1,i+1}(16,j)+ Vw*cosd(tetaw+180);
Sim1{1,i+1}(23,j) = round(sqrt((Sim1{1,i+1}(21,j))^2 + (Sim1{1,i+1}(22,j))^2 +(Sim1{1,i+1}(14,j))^2));

elseif Sim1{1,i+1}(10,j) == 4 && (Sim1{1,i}(29,j) == 1 && COMCTR{1,i}(5,j)== 0) 

    %% Holding
% Heading & Relative Heading
        Sim1{1,i+1}(11,j) = angle(Sim1{1,i+1}(5,j),Sim1{1,i+1}(6,j)); %Relative Airplane-Waypoint Course
        [Sim1{1,i+1}(12,j) Holding_status{1,i+1}(1,j)] = holding_1(Holding_status{1,i}(1,j),Sim1{1,i}(12,j),Sim1{1,i}(13,j),Time_Trigger{1,i}(1,j),i); %Airplane Heading %Airplane Heading
      
% Distance Measure        
        Sim1{1,i+1}(13,j) = sqrt((Sim1{1,i+1}(5,j))^2+(Sim1{1,i+1}(6,j))^2+(Sim1{1,i+1}(7,j))^2);

% Total Waypoint        
        Sim1{1,i+1}(17,j) = Sim1{1,1}(17,j); 

% Velocity XYZ
        Sim1{1,i+1}(14,j) = zspeedholding(Sim1{1,i+1}(4,j),Sim1{1,i}(25,j),rate_climb,rate_descent);  %Vz
%         Sim1{1,i+1}(15,j) = xspeed1(Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),difwpt(mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i+1}(1,j),Sim1{1,i+1}(17,j)),Sim1{1,i+1}(12,j));
%         Sim1{1,i+1}(16,j) = yspeed1(Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),difwpt(mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i+1}(1,j),Sim1{1,i+1}(17,j)),Sim1{1,i+1}(12,j));
        Sim1{1,i+1}(15,j) = Sim1{1,i}(15,j);
        Sim1{1,i+1}(16,j) = Sim1{1,i+1}(16,j);

% Vtotal
        Sim1{1,i+1}(19,j) = round(sqrt((Sim1{1,i+1}(15,j))^2 +(Sim1{1,i+1}(16,j))^2 +(Sim1{1,i+1}(14,j))^2));
        
% Merging Point
if Sim1{1,i+1}(1,j) ==  3 || Sim1{1,i+1}(1,j) ==  9 || Sim1{1,i+1}(1,j) ==  5 || Sim1{1,i+1}(1,j) ==  8 ...
        Sim1{1,i+1}(1,j) ==  22 || Sim1{1,i+1}(1,j) ==  21 || Sim1{1,i+1}(1,j) ==  17;
Sim1{1,i+1}(18,j) = 1;
else
  Sim1{1,i+1}(18,j) = 0;
end
 
if i+d > t+1
    d=1;
else
    d=d;
end

if i==1
    d=1;
else
    d=d;
end

if Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)> tol_min && Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)< tol_max
    Sim1{1,i+1}(20,j) = 0; %Cruising
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)>tol_max
    Sim1{1,i+1}(20,j) = 1; %Climbing
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)<tol_min
    Sim1{1,i+1}(20,j) = -1; %Descent
end

Sim1{1,i+1}(21,j) = Sim1{1,i+1}(15,j)+ Vw*sind(tetaw+180);
Sim1{1,i+1}(22,j) = Sim1{1,i+1}(16,j)+ Vw*cosd(tetaw+180);
Sim1{1,i+1}(23,j) = round(sqrt((Sim1{1,i+1}(21,j))^2 + (Sim1{1,i+1}(22,j))^2 +(Sim1{1,i+1}(14,j))^2));

else
%% No Conflict & No Resolution 

% Heading & Relative Heading
        Sim1{1,i+1}(11,j) = angle(Sim1{1,i+1}(5,j),Sim1{1,i+1}(6,j)); %Relative Airplane-Waypoint Course
        if Sim1{1,i}(1,j) == Sim1{1,i}(17,j)
            Sim1{1,i+1}(12,j) = Sim1{1,i}(12,j);
        else
        Sim1{1,i+1}(12,j) = Sim1{1,i+1}(11,j);
        end
        %Airplane Heading
      
% Distance Measure        
        Sim1{1,i+1}(13,j) = sqrt(Sim1{1,i+1}(5,j)^2+Sim1{1,i+1}(6,j)^2);

% Total Waypoint        
        Sim1{1,i+1}(17,j) = Sim1{1,1}(17,j);  
        
% Velocity XYZ (Air Speed)
if Sim1{1,i+1}(1,j) < Sim1{1,i+1}(17,j)
   Sim1{1,i+1}(14,j) = zspeed(Sim1{1,i+1}(4,j),Route{1,j}(Sim1{1,i+1}(1,j)+1,3),mpersec(Route{1,j}(Sim1{1,i+1}(1,j),5)));  %Vz      
else
%   Sim1{1,i+1}(14,j) = zspeed(Sim1{1,i+1}(4,j),Route{1,j}(Sim1{1,i+1}(1,j),3),mpersec(Route{1,j}(Sim1{1,i+1}(1,j),5)));  %Vz end
    Sim1{1,i+1}(14,j) = Sim1{1,i}(14,j);
end

    if Sim1{1,i+1}(1,j) < Sim1{1,i+1}(17,j)
        [Sim1{1,i+1}(15,j), Sim1{1,i+1}(16,j)] = xyspeed2( Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j)+1,4)),Sim1{1,i}(19,j),Sim1{1,i+1}(12,j));        
    else
        [Sim1{1,i+1}(15,j), Sim1{1,i+1}(16,j)] = xyspeed2( Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i}(19,j),Sim1{1,i+1}(12,j));   
    end
    
% Vtotal
 Sim1{1,i+1}(19,j) = round(sqrt((Sim1{1,i+1}(15,j))^2 + (Sim1{1,i+1}(16,j))^2 +(Sim1{1,i+1}(14,j))^2));  
              
% Merging Point
if Sim1{1,i+1}(1,j) == 2 || Sim1{1,i+1}(1,j) ==  6 || Sim1{1,i+1}(1,j) ==  8 
Sim1{1,i+1}(18,j) = 1;
else
  Sim1{1,i+1}(18,j) = 0;
end

if i+d > t+1
    d=1;
else
    d=d;
end

if i==1
    d=1;
else
    d=d;
end

if  Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)> tol_min && Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)< tol_max
    Sim1{1,i+1}(20,j) = 0; %Cruising
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)>tol_max
    Sim1{1,i+1}(20,j) = 1; %Climbing
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)<tol_min
    Sim1{1,i+1}(20,j) = -1; %Descent
end

Sim1{1,i+1}(21,j) = Sim1{1,i+1}(15,j)+ Vw*sind(tetaw+180);
Sim1{1,i+1}(22,j) = Sim1{1,i+1}(16,j)+ Vw*cosd(tetaw+180);
Sim1{1,i+1}(23,j) = round(sqrt((Sim1{1,i+1}(21,j))^2 + (Sim1{1,i+1}(22,j))^2 +(Sim1{1,i+1}(14,j))^2));

end
%% AKHIR RESOLUSI

if Sim1{1,i+1}(2,j) > 9000000
    Sim1{1,i+1}(19,j)= 0;
end   
 Sim1{1,i+1}(24,j)= LOS(ROW_Detail{1,i},Conflict_1{1,i},airplane,j,Distance_XY{1,i},conflict_separation_1,conflict_separation_2,Sim1{1,i+1}(4,j)); % Lost of Separation
            % 0 : No LOS
            % 1 : LOS
 
   Sim1{1,i+1}(25,j)= 0; %holding_point(Sim1{1,i+1}(1,j),Sim2{1,i+1}(1,j));
   Sim1{1,i+1}(26,j)= sqrt((lon_RADAR-Sim1{1,i+1}(2,j))^2 + (lat_RADAR - Sim1{1,i+1}(3,j))^2); %Radius dari Radar
   Sim1{1,i+1}(27,j) = Sim1{1,i}(27,j) ;
   Sim1{1,i+1}(28,j) = Sim1{1,i}(28,j);
   Sim1{1,i+1}(29,j) = sector(Sim1{1,i+1}(1,j),Sim1{1,i+1}(4,j),Sim1{1,i+1}(27,j)); % Sector Number
   Sim1{1,i+1}(30,j) = clearance(ROW_Detail{1,i},Conflict_1{1,i},airplane,j,Distance_XY{1,i},conflict_separation_1,conflict_separation_2,Sim1{1,i+1}(4,j),Holding_status{1,i}(1,j),Conflict_3{1,i},Distance_Merg{1,i}); %Status Conflict
 

if i==1
    COMCTR{1,i}(1:5,j)= 0;
    COMCTR1(1,i)= 0;
end

 %% Lower East Controller %%% 
 %% Conflict proportion
if Sim1{1,i+1}(29,j)== 1 && Sim1{1,i+1}(9,j)== 0 && Sim1{1,i+1}(31,j)==1
    con_prop{1,i+1}(1,j)= 1; %% Bip in radar because of potential conflict 
else
    con_prop{1,i+1}(1,j)= 0;
end

if sum(nonzeros(Sim1{1,i+1}(29,:)))>0
con_proport(1,i+1)= sum(nonzeros(con_prop{1,i+1}(1,:)))/sum(nonzeros(Sim1{1,i+1}(29,:))); %% BIP proportion
else
con_proport(1,i+1)=0;
end
con_proport(2,i+1)=sum(con_prop{1,i+1}(1,:));
con_proport(3,i+1)= sum(Sim1{1,i+1}(29,:));
 
%% Communication Workload 
if (Sim1{1,i}(29,j)== 0 && Sim1{1,i+1}(29,j)== 1) %|| COMCTR{1,i}(1,j)== 1 
   COMCTR{1,i+1}(1,j)= 1; % Enter sector  Check
else
   COMCTR{1,i+1}(1,j)= 0;
end

if (Sim1{1,i}(29,j)== 1 && Sim1{1,i+1}(29,j)== 0) 
   COMCTR{1,i+1}(2,j)= 1; % Exit sector  Check
else
   COMCTR{1,i+1}(2,j)= 0;
end
 
if (Sim1{1,i}(9,j)== 1 && Sim1{1,i+1}(9,j)== 0 && Sim1{1,i+1}(29,j)== 1 && Sim1{1,i+1}(10,j) == 2) || (Sim1{1,i}(10,j)== 2 && Sim1{1,i+1}(29,j)== 1 && Sim1{1,i+1}(10,j) == 0)
   COMCTR{1,i+1}(3,j)= 1; % Radar vector
else
   COMCTR{1,i+1}(3,j)= 0;
end

if Sim1{1,i}(9,j)== 1 && Sim1{1,i+1}(9,j)== 0 && Sim1{1,i+1}(29,j)== 1 && Sim1{1,i+1}(10,j)~= 2 && Sim1{1,i+1}(10,j)~= 0
   COMCTR{1,i+1}(4,j)= 1; % Control conflict
else
   COMCTR{1,i+1}(4,j)= 0;
end

 
tcin   = 16;% Communication time for coordination in sec
tcout  = 14; % Communication time for coordination out sector
tcid   = 12; % Communication time for radar identification 
tcvec  = 16; % Communication time for radar vectoring 
tccon  = 15; % Communication time for control conflict
tccros = 70; % Workload for crossing conflict

if i==1
    tcom1=0;
end


 %% Communication Time Lower North%%% 
 
 if COMCTR{1,i+1}(1,j)== 1 
    if COMCTR{1,i}(5,j)== 0
   tcom1 = tcin; %time comm in
   COMCTR{1,i+1}(5,j)= 1;
   %COMCTR{1,i+1}(1,j)= 0;
    else
        COMCTR{1,i+1}(1,j)= 1;
        COMCTR{1,i+1}(5,j)= 1;
    end
    
elseif COMCTR{1,i+1}(2,j)== 1 
    if COMCTR{1,i}(5,j)== 0
    tcom1 = tcout; %time comm out
    COMCTR{1,i+1}(5,j)= 1;
    %COMCTR{1,i+1}(2,j)= 0;
    else
        COMCTR{1,i+1}(2,j)= 1;
        COMCTR{1,i+1}(5,j)= 1;
    end
          
elseif COMCTR{1,i+1}(3,j)== 1 
    if COMCTR{1,i}(5,j)== 0 && Sim1{1,i}(31,j)==0
    tcom1 = tcvec; %time vectoring
    COMCTR{1,i+1}(5,j)= 1;
    elseif COMCTR{1,i}(5,j)== 0 && Sim1{1,i}(31,j)==1
    tcom1 = tccros; %time crossing
    COMCTR{1,i+1}(5,j)= 1;
    %COMCTR{1,i+1}(3,j)= 0;
    else
        COMCTR{1,i+1}(3,j)= 1 ;
        COMCTR{1,i+1}(5,j)= 1;
    end
    
elseif COMCTR{1,i+1}(4,j)== 1 
    if COMCTR{1,i}(5,j)== 0 && Sim1{1,i}(31,j)==0
    tcom1 = tccon; %time resolution conflict
    COMCTR{1,i+1}(5,j)= 1;
    elseif COMCTR{1,i}(5,j)== 0 && Sim1{1,i}(31,j)==1
    tcom1 = tccros; %time crossing
    COMCTR{1,i+1}(5,j)= 1;
    %COMCTR{1,i+1}(4,j)= 0;
    else
        COMCTR{1,i+1}(4,j)= 1 ;
        COMCTR{1,i+1}(5,j)= 1;
    end
    
    
elseif COMCTR{1,i}(5,j)== 1 && tcom1>0 
    tcom1 = tcom1-1;
    COMCTR{1,i+1}(5,j)= 1;
else
    COMCTR{1,i+1}(5,j)= 0;
end


COMCTR1(1,i+1)= any(COMCTR{1,i+1}(5,:)+ con_prop{1,i+1}(1,:));
COMCTR1(2,i+1)= any(COMCTR{1,i+1}(1,:)+COMCTR{1,i+1}(2,:)+COMCTR{1,i+1}(3,:)+COMCTR{1,i+1}(4,:)+ con_prop{1,i+1}(1,:));


%% Complexity Weighting Factor

w1 = 0.13770; % Weighting factor for A/C in sector
w2 = 0.11135; % Weighting factor for A/C type
w3 = 0.10255; % Weighting factor for speed ratio
w4 = 0.11561; % Weighting factor  for number of descending A/C
w5 = 0.09491; % Weighting factor for number of climbing A/C
w6 = 0.43788; % Weighting factor for potential conflict (overtaking and crossing)
% w7 = 0.09802 ; % Weighting factor for frequency of ATCo's coordination and communication

th_acin = 15;
th_actp = 5;
th_spd = 50;
th_des = 7;
th_clm = 7;
th_con = 2;
% th_com = 3;

complex(1,i) = vector_acinsector(Sim1{1,i}(29,:));
complex(2,i) = vector_aircrafttype(Sim1{1,i}(1,:),Sim1{1,i}(28,:),Sim1{1,i}(29,:));
complex(3,i) = vector_speedratio(Sim1{1,i}(1,:),Sim1{1,i}(19,:),Sim1{1,i}(29,:));
complex(4,i) = vector_descent(Sim1{1,i}(1,:),Sim1{1,i}(20,:),Sim1{1,i}(29,:));
complex(5,i) = vector_climb(Sim1{1,i}(1,:),Sim1{1,i}(20,:),Sim1{1,i}(29,:));
complex(6,i) = number_of_conflict(Sim1{1,i}(1,:),Sim1{1,i}(30,:),Sim1{1,i}(29,:));

tw = 60;
tc = 30;

if i < tw+1
    complex(7,i) = 0;
else
complex(7,i) = vector_comunication(COMCTR1(1,i-tw:i));
%complex(7,i) = vector_comunication(COMCTR1(2,i-60:i))/th_com;
end

complex(8,i) = w1*complex(1,i)/th_acin+ w2*complex(2,i)/th_actp+ w3*complex(3,i)/th_spd+ w4*complex(4,i)/th_des + w5*complex(5,i)/th_clm + w6*complex(6,i)/th_con; %+ w7*complex(7,i)/th_com;

if i < tc+1
    complex(9,i) = 0;
else
    complex(9,i) = complexity_minute(complex(8,i-tc:i));
end

%% Time check
if i == 1
    Timecheck{1,i}(1,j) = 0;
    Timecheck{1,i}(2,j) = 0;
    Timecheck{1,i}(3,j) = 0;
    con_prop{1,i}(1,j) = 0;
   con_proport(1,i) = 0;
end

if COMCTR{1,i+1}(1,j)== 1
Timecheck{1,i+1}(1,j) = i;%Time Enter Sector
else
Timecheck{1,i+1}(1,j) = Timecheck{1,i}(1,j); 
end

if COMCTR{1,i+1}(2,j)== 1
Timecheck{1,i+1}(2,j) = i;% Time Exit Sector
else
Timecheck{1,i+1}(2,j) = Timecheck{1,i}(2,j);
end

if Timecheck{1,i+1}(2,j)> Timecheck{1,i+1}(1,j)
Timecheck{1,i+1}(3,j) = Timecheck{1,i+1}(2,j)- Timecheck{1,i+1}(1,j);% Time in Sector
else
Timecheck{1,i+1}(3,j) = 0;
end

if Timecheck{1,i+1}(3,j)>0
TimeAVG(1,j)= Timecheck{1,i+1}(3,j);
else
TimeAVG(1,j)= Timecheck{1,i}(3,j);
end

if COMCTR{1,i+1}(1,j)== 1
TimeAVG(2,j)= 1;
else
TimeAVG(2,j)= TimeAVG(2,j);
end

%% Conflict proportion
% if Sim1{1,i+1}(29,j)== 1 && Sim1{1,i}(30,j)== 1
%     con_prop{1,i+1}(1,j)= 1;
% else
%     con_prop{1,i+1}(1,j)= 0;
% end
% 
% if sum(nonzeros(Sim1{1,i+1}(29,:)))>0
% con_proport(1,i+1)= sum(nonzeros(con_prop{1,i+1}(1,:)))/sum(nonzeros(Sim1{1,i+1}(29,:))); 
% else
% con_proport(1,i+1)=0;
% end

csac(1,i+1) = com2sac(complex(7,i)); %Comm Workload torespon delay
csac(2,i+1) = com2sac_pp(complex(7,i));  %Comm workload level
csac(3,i+1) = com2pcg(complex(8,i)); %Complexity level
end
end

max_complexity = max(complex(8,:));
mean_complexity = mean(complex(8,:));
max_aircraftinsector = max(complex(1,:));
mean_aircraftinsector = mean(complex(1,:));
max_conflictinsector = max(complex(6,:));
mean_conflictinsector = mean(complex(6,:));
max_communication = max(complex(7,:));
mean_communication= mean(complex(7,:));

workload_comm1 = find(COMCTR1(1,:));
workload_VL = find(csac(2,:)== 1);
workload_LL = find(csac(2,:)== 2);
workload_ML = find(csac(2,:)== 3);
workload_HL = find(csac(2,:)== 4);
workload_OL = find(csac(2,:)== 5);

AA1 = (nnz(workload_comm1)/time);
AA2 = (nnz(workload_VL)/time)*100;
AA3 = (nnz(workload_LL)/time)*100;
AA4 = (nnz(workload_ML)/time)*100;
AA5 = (nnz(workload_HL)/time)*100;
AA6 = (nnz(workload_OL)/time)*100;

COMPLEXITY_VL = find(csac(3,:)== 1);
COMPLEXITY_LL = find(csac(3,:)== 2);
COMPLEXITY_ML = find(csac(3,:)== 3);
COMPLEXITY_HL = find(csac(3,:)== 4);
COMPLEXITY_OL = find(csac(3,:)== 5);

CL1 = (nnz(COMPLEXITY_VL)/time)*100;
CL2 = (nnz(COMPLEXITY_LL)/time)*100;
CL3 = (nnz(COMPLEXITY_ML)/time)*100;
CL4 = (nnz(COMPLEXITY_HL)/time)*100;
CL5 = (nnz(COMPLEXITY_OL)/time)*100;

type_A320 = nnz(find(typeac(1,:)== 1))/Jumlah_AC*100;
type_B737 = nnz(find(typeac(1,:)== 2))/Jumlah_AC*100; % 2 == B737NG
type_A330 = nnz(find(typeac(1,:)== 3))/Jumlah_AC*100;% 3 == A330
type_B777 = nnz(find(typeac(1,:)== 4))/Jumlah_AC*100;% 4 == B777
type_B787 = nnz(find(typeac(1,:)== 5))/Jumlah_AC*100;% 5 == B787

abc = complex(7,:)';
abd = complex(9,:)';
Cor_wkld = corrcoef(abc,abd);
correlat = Cor_wkld(2,1);% Correlation workload-complexity

jam = time/3600;
mean_time = mean(nonzeros(TimeAVG(1,:)))/60; %% average time aircraft in sector/minute
sec_demand = sum(TimeAVG(2,:))/jam; %% Sector demand
% conflict_prop1 = sum(con_proport(1,:))/time; %% BIP porportion-time
conflict_prop1 = sum(con_proport(2,:))/sum(con_proport(3,:));
conflict_prop2 = mean(con_proport(1,:)); % Bip porportion - average

% bbc = csac(2,:)';
% bbd = csac(3,:)';
% Cor_wkld1 = corrcoef(bbc,bbd);
% correlat1 = Cor_wkld1(2,1);% Correlation level workload-complexity

[o,p]=find(complex(1,:)==max_aircraftinsector);
[k1,k2]= size(p);
min_con=zeros(1,k2);
for iv = 1:k2
    min_con(1,iv)=con_proport(1,p(1,iv));
end

minim_con = min(min_con);
maksi_con = max(min_con);
mean_con = mean(min_con);

%   save('Result1.mat','NavData','Sim1','Conflict','Conflict_1','Conflict_2','-v7.3')
    %save('Result1.mat','NavData','Sim1')
    timeElapsed_Simulation_schedule = toc