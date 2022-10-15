function [vr] = speed_ratio(sim1,airplane)
global lim_low lim_up lim_vel

for i = 1:airplane
if sim1(1,i) > 1 &&  sim1(4,i) > lim_low && sim1(4,i)< 10000  && sim1(19,i)> lim_vel
    sim1(19,i)= sim1(19,i);
else
    sim1(19,i)= 0;
end
ABm = sim1(19,:);
% if min(ABm(ABm>0)) == 0
%     vr=0;
% else
vr = max(ABm)- min(ABm(ABm>0));

end
end