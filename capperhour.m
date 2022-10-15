
Result = zeros (1, airplane) ;
t1 = 3000;
t = 3600;
t2=t1+t;



for i = t1:t2
    for j = 1:airplane
    
    if Sim1{1,i+1}(4,j) == 9.0e+7
       Result (1,j) = 1;
    else
        Result (1,j) = 0;
    end
    end
end

Capacity_per_hour = sum(Result)