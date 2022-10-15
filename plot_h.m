function [h1, h2, h3, h4, h5] = plot_h(sim1)
% global lim_low lim_up

% 
% AB = sim1(1,:);
% AC = sim1(4,:);
% AD = sim1(19,:);
%  
% AF = AB>1 & AC>300 & AC<25000 & AD == 1;

% AF = find(AD == 0);
h1 = mps2kt(sim1(4,20));
h2 = mps2kt(sim1(4,21));
h3 = mps2kt(sim1(4,22));
h4 = mps2kt(sim1(4,23));
h5 = mps2kt(sim1(4,24));

%desc= AF;
%clim = sum(AF>0);

end