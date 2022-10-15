function [desc1] = vector_descent(AB, AD, AG)

 AA1 = AB>1 & AD == -1 & AG == 1 ; % Lower North (LE)
 
 desc1 = sum(AA1);
 
end