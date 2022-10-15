function [tav] = time_average(timecek,timecek_old)
%Determine time average of the aircraft in the sector
%   Detailed explanation goes here
if timecek>0
tav= timecek;
else
tav= timecek_old;
end

end

