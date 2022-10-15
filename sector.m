function [sct] = sector(AB, AC, AF)

 if AB>1 && AC > meter(3500) && AC < meter(20000) && (AF == 1 || AF == 2 || AF == 3 || AF == 4 || AF == 5 || AF == 6 || AF == 7) % Lower East (LE)
    sct = 1;
 else
    sct =0;
 end
end
 
