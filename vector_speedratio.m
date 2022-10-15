function [sr1] = vector_speedratio(AB, AD, AG)

 AA1 = AB>1 & AG == 1; % Lower East (LE)
 
AD1 = AD(AA1);
vmax1 = max(AD1);
vmin1 = min(AD1);

if vmin1 < 50 | vmax1<50 | vmax1 == vmin1
     sr1 = 0;
 else
     sr1 = 10*(vmax1-vmin1)/vmin1;
 end



end
