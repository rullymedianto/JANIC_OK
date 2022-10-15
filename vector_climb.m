function [clim1] = vector_climb(AB, AD, AG)

AA1 = AB>1 & AD == 1 & AG == 1 ; % Lower East

clim1 = sum(AA1);

end