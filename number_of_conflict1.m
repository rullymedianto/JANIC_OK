function [noc_1] = number_of_conflict1(sim1)

AB = sim1(1,:);
AD = sim1(30,:);
AG = sim1(29,:);

AA1 = AB>1 & AD == 0 & AG == 1; % Lower North (LN)


noc_1 = sum(AA1);


end
