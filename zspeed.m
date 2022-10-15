function [x] = zspeed(h_aircraft, h_desire, vertical_speed)

global sen_descent sen_climb

if h_aircraft > h_desire && (h_aircraft - h_desire) > sen_descent
    x = -0.5*vertical_speed;
elseif  h_aircraft < h_desire && (h_desire - h_aircraft) > sen_climb
    x = 0.5*vertical_speed;
else
    x = 0;
end
end