function [y holding_status] = holding_1(hold_status_b4,heading,distance2HP,time_trigger,time)

rate = 3;
point2hold = 2000; % when to start holding
turn_1_end = 180/rate; %180/rate in this case=3
outbond_end = 80; % + 20 time outbound
turn_2_end  = 140; %180/rate

y=heading;
time2hold = 0;
if hold_status_b4 == 0
  if distance2HP < point2hold
        if time_trigger>time
           time2hold = time_trigger;
        else
           time2hold = time;
        end
else
  time2hold =0;
end
end
    
    if time2hold == 0
        y = heading;
        holding_status = 1;
    elseif time-time2hold <= 60 
         y = heading + rate;
         holding_status =1;
    elseif time-time2hold <= 80 && time-time2hold >60
         y = heading;
         holding_status =1;
    elseif time-time2hold <= 140 && time-time2hold >80   
         y = heading+ rate;
         holding_status =1;
    else      %if time-time2hold > 140   
         y = heading;
         holding_status =0;
    end
end
