function [x] = zspeedholding(h_aircraft,holding_point,rate_climb,rate_descent)

if holding_point == 1 % Holding point GAPRI
        h_desire =  meter(25000);
elseif holding_point == 2 % Holding point IMU
        h_desire =  meter(27000);
elseif holding_point == 3 % Holding point GASPA
        h_desire =  meter(27000);
elseif holding_point == 4 % Holding point ESALA
        h_desire =  meter(19000);
elseif holding_point == 5 % Holding point CARLI
        h_desire =  meter(27000);
elseif holding_point == 6 % Holding point DENDY
        h_desire =  meter(25000);
elseif holding_point == 7 % Holding point BUNIK
        h_desire =  meter(25000);
elseif holding_point == 8 % Holding point NOKTA
        h_desire =  meter(21000);
else
    h_desire = h_aircraft;
end

if h_aircraft > h_desire 
    x = -1*rate_descent;
elseif h_aircraft < h_desire
    x = 1*rate_climb;
else
    x = 0;
end