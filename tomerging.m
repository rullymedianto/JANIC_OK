function [y] = tomerging(sim,airplane)
Result = 0;
for i = 1:airplane
    if sim(18,i)== 1  
        Result = Result + 1;
    end
    y = Result; 
end