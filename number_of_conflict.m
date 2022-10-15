function [noc_1] = number_of_conflict(AB, AD, AG)

AA1 = (AB>1 & AD == 1 & AG == 1); % Lower East (LN)

noc_1 = sum(AA1);

end
