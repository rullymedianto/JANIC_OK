function [at1] = vector_aircrafttype(AB, AD, AG)

 AA1k1 = any(AB>1 & AG==1 & AD == 1) ; 
 AA1k2 = any(AB>1 & AG==1 & AD == 2) ; 
 AA1k3 = any(AB>1 & AG==1 & AD == 3) ; 
 AA1k4 = any(AB>1 & AG==1 & AD == 4) ; 
 AA1k5 = any(AB>1 & AG==1 & AD == 5) ;
   
at1 = AA1k1+AA1k2+AA1k3+AA1k4+AA1k5;
end
