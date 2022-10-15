function [x] = zspeedchanges(h_aircraft,h_desire,rate)
if h_aircraft > h_desire + meter(2000)
    x = -1*rate;
elseif h_aircraft < h_desire + meter(2000)
    x = 1*rate;
else
    x = 0;
end