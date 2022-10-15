% function [AA1,conflict_prop1,max_aircraftinsector, conflict_prop2, time, mean_time,ULT_CAP,max_conflictinsector,max_complexity,corelat, ya1, ya2, ya3, ya4, ya5] = Gabungan_cross_D()

% AA1: tingkat workload controller
% conflict_prop1: conflict proportion by time
% max_aircraftinsector: TAC controller capacity aac/sector
% mean_time: waktu selama di sektor dalam menit
% sec_demand: aircraft demand per jam
% max_conflictinsector: jumlah maksimum konflik yang terjadi;


clearvars Sim1
% close all
load('NavData_8jajar.mat')
load('NavAIP_8jajar.mat')
load('Label_8jajar.mat')

time= 3600; %
temp1=8;
lat_RADAR = -25118.4; %Koordinat X RADAR
lon_RADAR = -71138.2; %Koordinat Y RADAR
Vw = 6;   % Besar kecepatan angin
tetaw = 210; %sudut arah angin (dari)

separation_length = nm(12);                      %%Manual Input
%Separation_Angle = [270 335 28 432 393 494 250 250 250 250 250 250 250 250 250 250 250]; 
a = 1;                                          %For Platform Looping NavAIP
b = 1; 

Time_Trigger = cell(1,time);
Holding_status = cell(1,time);
Sim2 = cell(1,time);

%% Arrival
%% RWY 25R

%% RWY 25L

sa1=[10 20];%jadwal1(time) ;
sa2=0;
%  sa3=0;
sa3=100;
sa4=0;
sa5=0;
sa6=0;
sa7=0;
sa8=0;
% sa9=0;
% sa10=0;

% sa1=randi([1 120]);
% sa2=randi([1 120]);
% sa3=randi([1 120]);
% sa4=randi([1 120]);
% sa5=randi([1 120]);
% sa6=randi([1 120]);
% sa7=randi([1 120]);
% sa8=randi([1 120]);
% sa9=randi([1 120]);
% sa10=randi([1 120]);
% 

% sa1=[1 100];
% sa2=[20 200];
% sa3=[50 250]
% sa4= [200 1000];
% sa5= [1];
% sa6 =[1];

%sa1 = [1 200 840 1080 1800 2000 2720 3600 4000 4200 4400 4600 4800 5000 5200 5800 6000 6200 6600 6800 7000];
%sa2 = [1 200 840 1560 1700 2100 2460 2560 2660 2860 3000 3200 3400 3500 3600 3800 4000 4500 4600 4800 4900 5000 5100 5200 5400 5600 5800 6000 6600 6800 7000];
%sa3 = [1 200 1560 2100 2560 2860 3400 3800 4000 4400 4500 4600 4800 4900 5000 5100 5200 5400 5600 5800 6000 6200 6400 6600 6800 7000];

% sa1 = [1 240 480 720 960 1200 1440 1920 2160 2400 2640 2880 3120 3360 3840 4080 4320 4560 4800 5280 5520 5760 6240 6480 6720 6960 7200];
% sa2 = [40 240 480 720 960 1200 1440 1920 2160 2400 2640 2880 3120 3360 3840 4080 4320 4560 4800 5280 5520 5760 6240 6480 6720 6960 7200];
% sa3 = [1 240 480 720 960 1200 1440 1920 2160 2400 2640 2880 3120 3360 3840 4080 4320 4560 4800 5280 5520 5760 6240 6480 6720 6960 7200];

%% Schedule Departure %%
%Runway 25R

% sa4=jadwal(time);
% sa5=jadwal(time);%[500 2000];% 5600 7000]

% sa4 = [500 1000]; %240 360 1000 1200 1500 2000 3800 4200 4500 4800 6400 6800 7000];% 5300];
% sa5 = [2000]; %2500 2800 3200 3500 5100 5400 5700 6000 ];% 5600 7000];

% 
% %Runway 25L
%sa6=[0];
% % sa6 = [50 600 1000 1300 1600];
% 
% % sa6 = [50 600 1000 1300 1600 2200 2500 3000 3400 3800 4200 4500 4800 5100 5400 5700 6000 6400 6800 7000];% 5000]; % DOLTA 2D
% 
% sa7 = [0];%[700];% 
% sa8 = [0];%[900];%
% sa9 = [0];%[1100];% 
% sa10 = [0];%[1200];% 

% %Runway 25L
% sa11 = [0];%[50 200 400 600];%
% sa12 = [0];%[800 1000];%
% sa13 = [0];%[1200];% 

%jadwal = cell(1,temp1)
% % jadwal = {sa1 sa2 sa3};
% 
[m1,n1]= size(sa1);
[m2,n2]= size(sa2);
[m3,n3]= size(sa3);
[m4,n4]= size(sa4);
[m5,n5]= size(sa5);
[m6,n6]= size(sa6);
[m7,n7]= size(sa7);
[m8,n8]= size(sa8);
% [m9,n9]= size(sa9);
% [m10,n10]= size(sa10);

airplane_input = [n1 n2 n3 n4 n5 n6 n7 n8];% n9 n10];

airplane = sum(airplane_input);


Jumlah_AC = airplane;
sched=zeros(time,airplane);
ruteno=zeros(1,airplane);
typeac = zeros(1,airplane);
InitialPos = zeros(3,airplane);
InitialROW = zeros(2,airplane);


%% Number of Entry Point
for i = 1:temp1
NavAIP{2,i}(1,1) = airplane_input(1,i);
end
Route = cell(1,airplane);

for h=1:temp1
    if h==1 
    takum(1,h)= airplane_input(1,h);
    else
        takum(1,h)= takum(1,h-1)+ airplane_input(1,h);
    end
end

for i = 1:time
    for k = 1:n1
    if i == sa1(1,k)
        sched(i,k) = 1;
        % sched(i,takum(1,1)+k) = 1;
    end
    ruteno(1,k) = 1;
    typeac(1,k)= aircraft_type();
    end
end

for i = 1:time
    for k = 1:n2
    if i == sa2(1,k)
        sched(i,takum(1,1)+k) = 1;
    end
    ruteno(1,takum(1,1)+k) = 2;
    typeac(1,takum(1,1)+k)= aircraft_type();
    end
end
        
for i = 1:time
    for k = 1:n3
    if i == sa3(1,k)
        sched(i,takum(1,2)+k) = 1;
    end
    ruteno(1,takum(1,2)+k) = 3;
    typeac(1,takum(1,2)+k)= aircraft_type();
    end
end

for i = 1:time
    for k = 1:n4
    if i == sa4(1,k)
        sched(i,takum(1,3)+k) = 1;
    end
    ruteno(1,takum(1,3)+k) = 4;
    typeac(1,takum(1,3)+k)= aircraft_type();
    end
end

for i = 1:time
    for k = 1:n5
    if i == sa5(1,k)
        sched(i,takum(1,4)+k) = 1;
    end
    ruteno(1,takum(1,4)+k) = 5;
    typeac(1,takum(1,4)+k)= aircraft_type();
    end
end

for i = 1:time
    for k = 1:n6
    if i == sa6(1,k)
        sched(i,takum(1,5)+k) = 1;
    end
    ruteno(i,takum(1,5)+k) = 6;
    typeac(i,takum(1,5)+k)= aircraft_type();
    end
end

for i = 1:time
    for k = 1:n7
    if i == sa7(1,k)
        sched(i,takum(1,6)+k) = 1;
    end
    ruteno(i,takum(1,6)+k) = 7;
    typeac(i,takum(1,6)+k)= aircraft_type();
    end
end

for i = 1:time
    for k = 1:n8
    if i == sa8(1,k)
        sched(i,takum(1,7)+k) = 1;
    end
    ruteno(i,takum(1,7)+k) = 8;
    typeac(i,takum(1,7)+k)= aircraft_type();
    end
end

% for i = 1:time
%     for k = 1:n9
%     if i == sa9(1,k)
%         sched(i,takum(1,8)+k) = 1;
%     end
%     ruteno(i,takum(1,8)+k) = 9;
%     typeac(i,takum(1,8)+k)= aircraft_type();
%     end
% end
% 
% for i = 1:time
%     for k = 1:n10
%     if i == sa10(1,k)
%         sched(i,takum(1,9)+k) = 1;
%     end
%     ruteno(i,takum(1,9)+k) = 10;
%     typeac(i,takum(1,9)+k)= aircraft_type();
%     end
% end


% %% Airplane Route
for i = 1:airplane
    
    c = NumberWaypoint(NavAIP{1,a}(:,1)); % Check Number of Row
    
    for j = 1:c
        m = typeac(1,i);
        
        Route{1,i}(j,1) = NavData(NavAIP{1,a}(j,1),1);      % X
        Route{1,i}(j,2) = NavData(NavAIP{1,a}(j,1),2);      % Y
        Route{1,i}(j,3) = NavData(NavAIP{1,a}(j,1),2+m);    % Z(Altitude) 
        Route{1,i}(j,4) = NavData(NavAIP{1,a}(j,1),7+m);    % Lateral Speed 
        Route{1,i}(j,5) = NavData(NavAIP{1,a}(j,1),12+m);   % Vertical Speed
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        if b == NavAIP{2,a}(1,1)
                            a = a+1;
                            b = 1;
                        elseif a+1>temp1
                            a = temp1;
                            b = b+1;
                        else
                            a = a;
                            b = b + 1;
                        end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                    
end

    InitialPos(1,1) = Route{1,1}(1,1);%+ (separation_length + (nm(30)-separation_length)*rand(1,1))*sind(Separation_Angle(1,1)); %X    
    InitialPos(2,1) = Route{1,1}(1,2);%+ (separation_length + (nm(30)-separation_length)*rand(1,1))*cosd(Separation_Angle(1,1)); %Y
    InitialPos(3,1) = Route{1,1}(1,3); %Altitude;
    
    for i=2:n1
    InitialPos(1,i) = InitialPos(1,i-1);%+ (separation_length + (nm(30)-separation_length)*rand(1,1))*sind(Separation_Angle(1,1)); %X    
    InitialPos(2,i) = InitialPos(2,i-1);%+ (separation_length + (nm(30)-separation_length)*rand(1,1))*cosd(Separation_Angle(1,1)); %Y
    InitialPos(3,i) = InitialPos(3,i-1); %Altitude;
    end
    
    for k=1:(temp1-1)
        
    InitialPos(1,takum(1,k)+1) = Route{1,takum(1,k)+1}(1,1);%+ (separation_length + (nm(2)-separation_length)*rand(1,1))*sind(Separation_Angle(1,k+1)); %X
    InitialPos(2,takum(1,k)+1) = Route{1,takum(1,k)+1}(1,2);%+ (separation_length + (nm(2)-separation_length)*rand(1,1))*cosd(Separation_Angle(1,k+1)); %Y
    InitialPos(3,takum(1,k)+1) = Route{1,takum(1,k)+1}(1,3); %Altitude;
    
    for i=2:airplane_input(1,k+1)
    
    InitialPos(1,takum(1,k)+i) = InitialPos(1,takum(1,k)+i-1);%+ (separation_length + (nm(2)-separation_length)*rand(1,1))*sind(Separation_Angle(1,k+1)); %X    
    InitialPos(2,takum(1,k)+i) = InitialPos(2,takum(1,k)+i-1);%+ (separation_length + (nm(2)-separation_length)*rand(1,1))*cosd(Separation_Angle(1,k+1)); %Y
    InitialPos(3,takum(1,k)+i) = InitialPos(3,takum(1,k)+i-1); %Altitude;
    end
    end
    
       %% Initial ROW
a = 1;
b = 1;
for i=1:airplane
    
    InitialROW(1,i) = i;
    InitialROW(2,i) = b;

    
                        if b == NavAIP{2,a}(1,1)
                            a = a+1;
                            b = 1;
                        elseif a+1>temp1
                            a = temp1;
                            b = b+1;
                        else
                            a = a;
                            b = b + 1;
                        end
    
end
    
%% Aircraft Data t = 0
a = 1;
b = 1;

for i = 1:airplane
Time_Trigger{1,1}(1,i) = 0;
Holding_status{1,1}(1,i) = 0;

 Sim1{1,1}(1,i) = 1 ; 

if sched(1,i)==1
                                    %Num Waypoint = [1 2 3 4 5 ....]
   
    Sim1{1,1}(2,i) = InitialPos(1,i);                    %X
    Sim1{1,1}(3,i) = InitialPos(2,i);                    %Y
    Sim1{1,1}(4,i) = InitialPos(3,i);                    %Z

else
    Sim1{1,1}(2,i) = 9.0e+7;                    %X
    Sim1{1,1}(3,i) = 9.0e+7;                    %Y
    Sim1{1,1}(4,i) = 9.0e+7;                    %Z
end
    
    
    Sim1{1,1}(5,i) = Route{1,i}(1,1) - Sim1{1,1}(2,i);    %Delta X
    Sim1{1,1}(6,i) = Route{1,i}(1,2) - Sim1{1,1}(3,i);    %Delta Y
    Sim1{1,1}(7,i) = Route{1,i}(1,3) - Sim1{1,1}(4,i);    %Delta Z

    Sim1{1,1}(8,i) = InitialROW(2,i);                    %ROW
    Sim1{1,1}(9,i) = 1;                                  %Clearance
    Sim1{1,1}(10,i) = 0;                                 %Resolution

    Sim1{1,1}(11,i) = angle(Sim1{1,1}(5,i),Sim1{1,1}(6,i)); %Relative Heading
    Sim1{1,1}(12,i) = Sim1{1,1}(11,i);                     %Heading

    Sim1{1,1}(13,i) = sqrt((Sim1{1,1}(5,i)).^2+(Sim1{1,1}(6,i)).^2+(Sim1{1,1}(7,i)).^2);      %r

    Sim1{1,1}(14,i) = 0;                                              %vz
    Sim1{1,1}(15,i) = Route{1,i}(1,4) * sind(Sim1{1,1}(12,i));        %vx
    Sim1{1,1}(16,i) = Route{1,i}(1,4) * cosd(Sim1{1,1}(12,i));        %vy
    Sim1{1,1}(17,i) = NumberWaypoint(Route{1,i});                     %Total Waypoint
    Sim1{1,1}(18,i) = 0   ;                                           %Aircraft to merging point
    Sim1{1,1}(19,i) = sqrt((Sim1{1,1}(15,i)).^2 + (Sim1{1,1}(16,i)).^2 +(Sim1{1,1}(14,i)).^2) ;  %TAS
    Sim1{1,1}(20,i) = 0;
    Sim1{1,1}(21,i) = Sim1{1,1}(15,i)+ Vw*sind(tetaw+180); %Ground Speed Sumbu x
    Sim1{1,1}(22,i) = Sim1{1,1}(16,i)+ Vw*cosd(tetaw+180); %Ground Speed Sumbu y
    Sim1{1,1}(23,i) = round(sqrt((Sim1{1,1}(21,i)).^2 + (Sim1{1,1}(22,i)).^2 +(Sim1{1,1}(14,i)).^2)); % Ground Speed
    Sim1{1,1}(24,i) = 0;%LoS
    
    
    for j= 1:time+1
    Sim2{1,j}(1,i) = ruteno(1,i); %Ruote No.
    Sim2{1,j}(2,i) = typeac(1,i); %Aircraft Type
    end
    
    Sim1{1,1}(25,i) = holding_point(Sim1{1,1}(1,i),Sim2{1,1}(1,i)); %Holding point
    Sim1{1,1}(26,i) = sqrt((lon_RADAR-Sim1{1,1}(2,i)).^2 + (lat_RADAR - Sim1{1,1}(3,i)).^2); %Radius to RADAR
    Sim1{1,1}(27,i) = Sim2{1,1}(1,i); %Route No.
    Sim1{1,1}(28,i) = Sim2{1,1}(2,i); %Aircraft Type
    Sim1{1,1}(29,i) = 0; % Sector Number
    Sim1{1,1}(30,i) = 0; % Status Conflict
    Sim1{1,1}(31,i) = 0; % Status Crossing Conflict
    Sim1{1,1}(32,i) = 0; % Status potensi Conflict
    
                        if b == NavAIP{2,a}(1,1)
                            a = a+1;
                            b = 1;
                        elseif a+1>temp1
                            a = temp1;
                            b = b+1;
                        else
                            a = a;
                            b = b + 1;
                        end
end




%% Define Cell
%Simulation Time
%time = 1200;

%% Import Data from PlaneGenerator
% close all
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
buffer_merge = nm(17);

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
Conflict_4 = cell(1,time);
Conflict_5 = cell(1,time);

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
COMCTR1 = zeros(7,time+1);
SLOTWL = zeros(1,time+1);
CHWRK = zeros(5,time+1);
TCOM = zeros(1,time+1);
check_merge = zeros(airplane,time+1);
% slot = zeros(1,time);
Timecheck = cell(1,time);
TimeAVG = zeros(2,airplane);

COMDLY = zeros(5,time);

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
                    [Distance_XY{1,i}(c1,c2),Distance_Altitude{1,i}(c1,c2),Distance_Merg{1,i}(c1,c2)] = separasi_jajar_b(Sim1{1,i}(2,c1),Sim1{1,i}(2,c2),Sim1{1,i}(3,c1),Sim1{1,i}(3,c2),Sim1{1,i}(4,c1),Sim1{1,i}(4,c2),Sim1{1,i}(27,c1),Sim1{1,i}(27,c2),Sim1{1,i}(1,c1),Sim1{1,i}(1,c2),Sim1{1,i}(13,c1),Sim1{1,i}(13,c2));
                end

 %% For Radius 10NM-75NM
 
 if Sim1{1,i}(4,c1)> meter(2000) && Sim1{1,i}(4,c1)< 500000   

 %% Potential Conflict Definition              
                if Distance_XY{1,i}(c1,c2) < buffer_zone_1 && Distance_XY{1,i}(c1,c2) ~= 0 && Distance_Altitude{1,i}(c1,c2) <= meter(2000)
                    Conflict{1,i}(c1,c2) = 1;
                else
                    Conflict{1,i}(c1,c2) = 0;
                end
                
                if Distance_Merg{1,i}(c1,c2) < buffer_merge && Distance_Merg{1,i}(c1,c2) ~= 0
                    Conflict_3{1,i}(c1,c2) = 1;
                else
                    Conflict_3{1,i}(c1,c2) = 0;
                end
%% Conflict Definition              
                if Distance_XY{1,i}(c1,c2) < conflict_separation_1  && Distance_XY{1,i}(c1,c2) ~= 0 && Distance_Altitude{1,i}(c1,c2) <= meter(1000)
                    Conflict_0{1,i}(c1,c2) = 1;
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
                
               if Distance_Merg{1,i}(c1,c2) < buffer_merge && Distance_Merg{1,i}(c1,c2) ~= 0
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
            

    for j = 1:airplane
        if mean(Conflict{1,i}(:,j)) > 0 %&& mean(Conflict{1,i}(:,j)) > 0 %Konflik horisontal
        Conflict_1{1,i}(1,j) = 1;
%         elseif mean(Conflict_0{1,i}(:,j)) <= 0 && mean(Conflict{1,i}(:,j)) > 0  
%         Conflict_1{1,i}(1,j) = 2;
        else
        Conflict_1{1,i}(1,j) = 0;  
        end
        
        if mean(Conflict_3{1,i}(:,j)) > 0 %&& mean(Conflict{1,i}(:,j)) > 0  %Ckonflik Crossing
        Conflict_4{1,i}(1,j) = 1;
%         elseif mean(Conflict_0{1,i}(:,j)) <= 0 && mean(Conflict{1,i}(:,j)) > 0  
%         Conflict_1{1,i}(1,j) = 2;
        else
        Conflict_4{1,i}(1,j) = 0;  
        end
        
        if mean(Conflict_0{1,i}(:,j)) > 0 %&& mean(Conflict{1,i}(:,j)) > 0  % Loss of Separation
        Conflict_5{1,i}(1,j) = 1;
%         elseif mean(Conflict_0{1,i}(:,j)) <= 0 && mean(Conflict{1,i}(:,j)) > 0  
%         Conflict_1{1,i}(1,j) = 2;
        else
        Conflict_5{1,i}(1,j) = 0;  
        end
        
%Conflict Colour    
        if (Conflict_4{1,i}(1,j) == 1 && Conflict_0{1,i}(1,j) == 1) || (Conflict_1{1,i}(1,j) == 0 && Conflict_0{1,i}(1,j) == 1)
            Conflict_2{1,i}(j,:) = [1 0 0];
        elseif (Conflict_4{1,i}(1,j) == 1 && Conflict_0{1,i}(1,j) == 0)|| (Conflict_4{1,i}(1,j) == 1 && Conflict_0{1,i}(1,j))
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
% [Sim1{1,i+1}(9,j), Sim1{1,i+1}(31,j)]= clearance_a(ROW_Detail{1,i},Conflict_1{1,i},airplane,j,Conflict_3{1,i});

Sim1{1,i+1}(9,j)= clearance(ROW_Detail{1,i},Conflict_1{1,i},airplane,j,Distance_XY{1,i},buffer_zone_1,buffer_zone_2,Sim1{1,i+1}(4,j),Holding_status{1,i}(1,j),Conflict_4{1,i},Distance_Merg{1,i});
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
    Sim1{1,i+1}(14,j) = zspeedchanges(Sim1{1,i+1}(4,j), Route{1,j}(Sim1{1,i+1}(1,j)+1,3),mpersec(Route{1,j}(Sim1{1,i+1}(1,j),5)));  %Vz
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
                Sim1{1,i+1}(12,j) = Sim1{1,i+1}(11,j) + deviation_angle;   %Airplane Heading
        else
                Sim1{1,i+1}(12,j) = Sim1{1,i+1}(11,j) - deviation_angle;
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
% if Sim1{1,i+1}(1,j) ==  6 || Sim1{1,i+1}(1,j) == 6 || Sim1{1,i+1}(1,j) == 8 
% else
%   Sim1{1,i+1}(18,j) = 0;
% end

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
 Sim1{1,i+1}(24,j)= LOS(ROW_Detail{1,i},Conflict_5{1,i},airplane,j,Distance_XY{1,i},conflict_separation_1,conflict_separation_2,Sim1{1,i+1}(4,j)); % Lost of Separation
            % 0 : No LOS
            % 1 : LOS
 
   Sim1{1,i+1}(25,j)= 0; %holding_point(Sim1{1,i+1}(1,j),Sim2{1,i+1}(1,j));
   Sim1{1,i+1}(26,j)= sqrt((lon_RADAR-Sim1{1,i+1}(2,j))^2 + (lat_RADAR - Sim1{1,i+1}(3,j))^2); %Radius dari Radar
   Sim1{1,i+1}(27,j) = Sim1{1,i}(27,j) ;
   Sim1{1,i+1}(28,j) = Sim1{1,i}(28,j);
   Sim1{1,i+1}(29,j) = sector(Sim1{1,i+1}(1,j),Sim1{1,i+1}(4,j),Sim1{1,i+1}(27,j)); % Sector Number
   Sim1{1,i+1}(30,j) = noclearance(ROW_Detail{1,i},Conflict{1,i},airplane,j,Distance_XY{1,i},conflict_separation_1,conflict_separation_2,Sim1{1,i+1}(4,j),Conflict_0{1,i},Distance_Merg{1,i}); %Status LoS
  % Sim1{1,i+1}(31,j)= crossconf(ROW_Detail{1,i},Conflict_1{1,i},airplane,j,Conflict_4{1,i});%Potential crossing conflict
   Sim1{1,i+1}(31,j) = noclearcross(ROW_Detail{1,i},airplane,j,buffer_merge,buffer_merge,Sim1{1,i+1}(4,j),Conflict_3{1,i},Distance_Merg{1,i}); %Status Potential Conflict
   %Sim1{1,i+1}(30,j)= conflict_def_a(ROW_Detail{1,i},Conflict_0{1,i},airplane,j); %Status Conflict
   Sim1{1,i+1}(32,j) = noclearance(ROW_Detail{1,i},Conflict{1,i},airplane,j,Distance_XY{1,i},buffer_zone_1,buffer_zone_2,Sim1{1,i+1}(4,j),Conflict_3{1,i},Distance_Merg{1,i}); %Status Potential Conflict

if i==1
    COMCTR{1,i}(1:8,j)= 0;
    COMCTR1(1,i)= 0;
    COMDLY(1:5,i) = 0;
end

 %% Lower East Controller %%% 
 %% Conflict proportion
if Sim1{1,i+1}(29,j)== 1 && Sim1{1,i+1}(31,j)==1 %&& Sim1{1,i+1}(9,j)== 0 
    con_prop{1,i+1}(1,j)= 1; %% Bip in radar because of potential crossing conflict 
else
    con_prop{1,i+1}(1,j)= 0;
end

if sum(nonzeros(Sim1{1,i+1}(29,:)))>0
con_proport(1,i+1)= sum(nonzeros(con_prop{1,i+1}(1,:)))/sum(nonzeros(Sim1{1,i+1}(29,:))); %% BIP proportion
else
con_proport(1,i+1)=0;
end
con_proport(2,i+1)=sum(con_prop{1,i+1}(1,:)); %BIP 
con_proport(3,i+1)= sum(Sim1{1,i+1}(29,:)); %Aircraft in sector
 
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

 
tcin   = 58;% Communication time for coordination in sec
tcout  = 14; % Communication time for coordination out sector
tcid   = 12; % Communication time for radar identification 
tcvec  = 16; % Communication time for radar vectoring 
tccon  = 15; % Communication time for control conflict
tccros = 70; % Workload for crossing conflict

% if i==1
%     tcom1=0;
% end


 %% Communication Time Lower North%%% 

 if SLOTWL(1,i)== 0
    if COMDLY(1,i)>0 
        COMDLY(1,i+1)= COMDLY(1,i)- 1;
        SLOTWL(1,i+1)=  1;
        TCOM(1,i+1) = tcin;
    else 
        if COMCTR{1,i+1}(1,j)== 1 
         TCOM(1,i+1) = tcin; %time comm in
         SLOTWL(1,i+1)= 1;
         COMDLY(1,i+1)= 0;
        else
            
            
        end
    end
    elseif COMDLY(2,i)>0 
        COMDLY(2,i+1)= COMDLY(2,i)- 1;
        SLOTWL(1,i+1)=  1;
        TCOM(1,i+1) = tcout;
    
    
    elseif COMDLY(3,i)>0 
        COMDLY(3,i+1)= COMDLY(3,i)- 1;
        SLOTWL(1,i+1)=  1;
        TCOM(1,i+1) = tcvec;
    
    elseif COMDLY(4,i)>0 
        COMDLY(4,i+1)= COMDLY(4,i)- 1;
        SLOTWL(1,i+1)=  1;
        TCOM(1,i+1) = tccon;
    
    
    elseif COMDLY(5,i)>0 
        COMDLY(5,i+1)= COMDLY(5,i)- 1;
        SLOTWL(1,i+1)=  1;
        TCOM(1,i+1) = tccros;
    
    
    end
    
    if COMDLY(1,i)==0
        
    
    
    end
 end
     
 
    if SLOTWL(1,i)== 0 && 
      
   %COMCTR{1,i+1}(1,j)= 0;
    elseif SLOTWL(1,i)== 1
        COMDLY(1,i+1)= COMDLY(1,i)+ 1;
%         COMCTR{1,i+1}(1,j)= 1;
        SLOTWL(1,i+1)=  1;
        TCOM(1,i+1) = TCOM(1,i)-1;
    end
    
elseif COMCTR{1,i+1}(2,j)== 1
    if SLOTWL(1,i)== 0
    TCOM(1,i+1) = TCOM(1,i+1)+ tcout; %time comm out
    SLOTWL(1,i+1) = 1;
    %COMCTR{1,i+1}(2,j)= 0;
    elseif SLOTWL(1,i+1)== 1
        COMCTR{1,i+1}(2,j)= 1;
        SLOTWL(1,i+1)= SLOTWL(1,i+1);
    else
        COMCTR{1,i+1}(2,j)= 1;
        SLOTWL(1,i+1)= SLOTWL(1,i);
    end
          
elseif COMCTR{1,i+1}(3,j)== 1
    if SLOTWL(1,i)== 0 && Sim1{1,i+1}(31,j)==0
    TCOM(1,i+1) = TCOM(1,i+1)+tcvec; %time vectoring
    SLOTWL(1,i+1)= 1;
    elseif SLOTWL(1,i)== 0 && Sim1{1,i+1}(31,j)==1
    TCOM(1,i+1) = TCOM(1,i+1)+tccros; %time crossing
    SLOTWL(1,i+1)= 1;
    %COMCTR{1,i+1}(3,j)= 0;
    elseif SLOTWL(1,i+1)== 1
        COMCTR{1,i+1}(3,j)= 1;
        SLOTWL(1,i+1)= SLOTWL(1,i+1);
    else
        COMCTR{1,i+1}(3,j)= 1 ;
        SLOTWL(1,i+1) = SLOTWL(1,i);
    end
    
elseif COMCTR{1,i+1}(4,j)== 1 
    if SLOTWL(1,i)== 0 && Sim1{1,i+1}(31,j)==0
    TCOM(1,i+1) = TCOM(1,i+1)+tccon; %time resolution conflict
    SLOTWL(1,i+1)= 1;
    elseif SLOTWL(1,i)== 0 && Sim1{1,i+1}(31,j)==1
    TCOM(1,i+1) = TCOM(1,i+1)+tccros; %time crossing
    SLOTWL(1,i+1)= 1;
    %COMCTR{1,i+1}(4,j)= 0;
    elseif SLOTWL(1,i+1)== 1
        COMCTR{1,i+1}(4,j)= 1;
        SLOTWL(1,i+1)= SLOTWL(1,i+1);
    else
        COMCTR{1,i+1}(4,j)= 1 ;
        SLOTWL(1,i+1) =  SLOTWL(1,i);
    end
    
    
elseif (COMCTR{1,i+1}(1,j)== 0 ||COMCTR{1,i+1}(2,j)== 0 || COMCTR{1,i+1}(3,j)== 0 || COMCTR{1,i+1}(4,j)== 0)
    
    if j==1 && SLOTWL(1,i)> 0 && TCOM(1,i)>0
    TCOM(1,i+1) = TCOM(1,i)-1;
    SLOTWL(1,i+1) = SLOTWL(1,i);
    
    elseif j~= 1 && SLOTWL(1,i+1)> 0 && TCOM(1,i+1)>0 
    TCOM(1,i+1) = TCOM(1,i+1);
    SLOTWL(1,i+1) = SLOTWL(1,i+1);
  
    end
else
    SLOTWL(1,i+1)= 0;
end

if COMCTR{1,i+1}(3,j)== 1 || COMCTR{1,i+1}(4,j)== 1 
if Sim1{1,i+1}(31,j)==1
     COMCTR{1,i+1}(6,j)= 1; % Crossing Conflict
     COMCTR{1,i+1}(7,j)= 0;
     COMCTR{1,i+1}(8,j)= 0;
% elseif Sim1{1,i}(31,j)==1
%      COMCTR{1,i+1}(6,j)= 0; % Crossing Conflict
%      COMCTR{1,i+1}(7,j)= 0;
%      COMCTR{1,i+1}(8,j)= 1;
else
    COMCTR{1,i+1}(6,j)= 0;
    COMCTR{1,i+1}(7,j)= 1; % Take over conflict2
    COMCTR{1,i+1}(8,j)= 0;
end


else
    COMCTR{1,i+1}(6,j)= 0; 
     COMCTR{1,i+1}(7,j)= 0;
     COMCTR{1,i+1}(8,j)= 0; 
end
     
COMCTR1(1,i+1)= any(COMCTR{1,i+1}(5,:)+ con_prop{1,i+1}(1,:));
COMCTR1(2,i+1)= any(COMCTR{1,i+1}(1,:)+COMCTR{1,i+1}(2,:)+COMCTR{1,i+1}(3,:)+COMCTR{1,i+1}(4,:)+ con_prop{1,i+1}(1,:));
COMCTR1(3,i+1)= any(COMCTR{1,i+1}(1,:)); %check in
COMCTR1(4,i+1)= any(COMCTR{1,i+1}(2,:)); %check out
COMCTR1(5,i+1)= any(COMCTR{1,i+1}(6,:)); %Jumlah crossing conflict
COMCTR1(6,i+1)= any(COMCTR{1,i+1}(7,:)); %Jumlah take over conflict
COMCTR1(7,i+1)= any(COMCTR{1,i+1}(8,:)); %Jumlah crossing conflict 2

CHWRK(1,i+1)= sum(COMCTR{1,i+1}(1,:));
CHWRK(2,i+1)= sum(COMCTR{1,i+1}(2,:));
CHWRK(3,i+1)= sum(COMCTR{1,i+1}(3,:));
CHWRK(4,i+1)= sum(COMCTR{1,i+1}(4,:));
CHWRK(5,i+1)= sum(COMCTR{1,i+1}(5,:));

JML_chekin = sum(COMCTR1(3,:)==1);
JML_chekout = sum(COMCTR1(4,:)==1);
JML_cross = sum(COMCTR1(5,:)==1);
JML_takeov = sum(COMCTR1(6,:)==1);
JML_cross2 = sum(COMCTR1(7,:)==1);
JML_WL = SLOTWL(1,:)/time;

check_merge(airplane,i) = any(Conflict_3{1,i}(airplane,:));

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
complex(6,i) = number_of_conflict(Sim1{1,i}(1,:),Sim1{1,i}(24,:),Sim1{1,i}(29,:));

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

workload_comm1 = find(SLOTWL(1,:));
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
corelat = Cor_wkld(2,1);% Correlation workload-complexity

jam = time/3600;
mean_time = mean(nonzeros(TimeAVG(1,:)))/60; %% average time aircraft in sector/minute
ULT_CAP = round(max_aircraftinsector/mean_time*60); %% Ultimate Capacity
sec_demand = sum(TimeAVG(2,:))/jam; %% Sector demand
% conflict_prop1 = sum(con_proport(1,:))/time; %% BIP porportion-time
% conflict_prop1 = sum(con_proport(2,:))/sum(con_proport(3,:));

conflict_prop1 = sum(con_proport(2,:))/time;
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

% format bank
% ya1 = num2str(str2double(sprintf( '5%1d', sa1 )));
% ya2 = str2double(sprintf( '5%1d', sa2 ));
% ya3 = str2double(sprintf( '5%1d', sa3 ));
% ya4 = str2double(sprintf( '5%1d', sa4 ));

ya1 = convertCharsToStrings(sprintf( '5%1d', sa1 ));
ya2 = convertCharsToStrings(sprintf( '5%1d', sa2 ));
ya3 = convertCharsToStrings(sprintf( '5%1d', sa3 ));
ya4 = convertCharsToStrings(sprintf( '5%1d', sa4 ));
ya5 = convertCharsToStrings(sprintf( '5%1d', sa5 ));

Check_1 = [max_conflictinsector conflict_prop1 JML_chekin JML_chekout JML_cross JML_takeov]

% 
% ya1=convertCharsToStrings(ya1);
% % 
% % ya1=strcat(ya1);

% 
% ya1 = vpa(ya1);
% ya2 = vpa(ya2);
% ya3 = vpa(ya3);
% ya4 = vpa(ya4);

% ya1 = str2double(ya1);
% ya2 = str2double(ya2);
% ya3 = str2double(ya3);
% ya4 = str2double(ya4);