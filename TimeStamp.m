 Time_stamp = zeros(13,airplane);

for j = 1:airplane 
 for i = 1:time
  
      
   if Time_stamp(1,j) == 0
       if (Sim1{1,i+1}(17,j) > Sim1{1,i+1}(1,j)>1) & Sim1{1,i+1}(4,j) > meter(15000) & Sim1{1,i+1}(4,j) < meter(24500) %& Sim1{1,i+1}(26,j) > nm(75) & Sim1{1,i+1}(26,j) < nm(150) & (Sim1{1,i+1}(27,j) == 2 | Sim1{1,i+1}(27,j) == 3 | Sim1{1,i+1}(27,j) == 1 | Sim1{1,i+1}(27,j) == 12) ; % Lower North (LN)
           Time_stamp(1,j) = i+1;
       else
           Time_stamp(1,j) = 0;
       end
   else
       Time_stamp(1,j) = Time_stamp(1,j);
   end
       
   if Time_stamp(2,j) == 0
       if (Sim1{1,i+1}(17,j) > Sim1{1,i+1}(1,j)>1) & Sim1{1,i+1}(4,j) > meter(15000) & Sim1{1,i+1}(4,j) < meter(24500) %& Sim1{1,i+1}(26,j) > nm(75) & Sim1{1,i+1}(26,j) < nm(150) & (Sim1{1,i+1}(27,j) == 4 | Sim1{1,i+1}(27,j) == 7 | Sim1{1,i+1}(27,j) == 8 | Sim1{1,i+1}(27,j) == 13 | Sim1{1,i+1}(27,j) == 14); % Lower Centre (LC)
           Time_stamp(2,j) = i+1;
       else
           Time_stamp(2,j) = 0;
       end
   else
       Time_stamp(2,j) = Time_stamp(2,j);
   end        
   
   if Time_stamp(3,j) == 0
       if Sim1{1,i+1}(17,j) > Sim1{1,i+1}(1,j) & Sim1{1,i+1}(1,j)>1 & Sim1{1,i+1}(4,j) > meter(15000) & Sim1{1,i+1}(4,j) < meter(24500) %& Sim1{1,i+1}(26,j) > nm(75) & Sim1{1,i+1}(26,j) < nm(150) & (Sim1{1,i+1}(27,j) == 1 | Sim1{1,i+1}(27,j) == 9 | Sim1{1,i+1}(27,j) == 10 | Sim1{1,i+1}(27,j) == 15); % Lower East (LE)
%        if Sim1{1,i+1}(1,j) > 1 Sim1{1,i+1}(1,j) & Sim1{1,i+1}(1,j)>1 & Sim1{1,i+1}(4,j) > meter(15000) & Sim1{1,i+1}(4,j) < meter(24500) %& Sim1{1,i+1}(26,j) > nm(75) & Sim1{1,i+1}(26,j) < nm(150) & (Sim1{1,i+1}(27,j) == 1 | Sim1{1,i+1}(27,j) == 9 | Sim1{1,i+1}(27,j) == 10 | Sim1{1,i+1}(27,j) == 15); % Lower East (LE)    
           Time_stamp(3,j) = 100; %i+1;
       else
           Time_stamp(3,j) = 0;
       end
   else
       Time_stamp(3,j) = Time_stamp(3,j);
   end
   
   if Time_stamp(4,j) == 0
       if (Sim1{1,i+1}(17,j) > Sim1{1,i+1}(17,j)>1) & Sim1{1,i+1}(4,j) > meter(6000) & Sim1{1,i+1}(4,j) < meter(15000) %& Sim1{1,i+1}(26,j) > nm(30) & Sim1{1,i+1}(26,j) < nm(75) & (Sim1{1,i+1}(27,j) == 2 | Sim1{1,i+1}(27,j) == 3 | Sim1{1,i+1}(27,j) == 4 | Sim1{1,i+1}(27,j) == 5 | Sim1{1,i+1}(27,j) == 6 | Sim1{1,i+1}(27,j) == 11 | Sim1{1,i+1}(27,j) == 12) ; % Terminal West (TW)
           Time_stamp(4,j) = i+1;
       else
           Time_stamp(4,j) = 0;
       end
   else
       Time_stamp(4,j) = Time_stamp(4,j);
   end
 
   if Time_stamp(5,j) == 0
       if (Sim1{1,i+1}(17,j) > Sim1{1,i+1}(1,j)>1) & Sim1{1,i+1}(4,j) > meter(6000) & Sim1{1,i+1}(4,j) < meter(15000) %& Sim1{1,i+1}(26,j) > nm(30) & Sim1{1,i+1}(26,j) < nm(75) & (Sim1{1,i+1}(27,j) == 1 | Sim1{1,i+1}(27,j) == 7 | Sim1{1,i+1}(27,j) == 8 | Sim1{1,i+1}(27,j) == 13 | Sim1{1,i+1}(27,j) == 14); % Terminal East (TE)
           Time_stamp(5,j) = i+1;
       else
           Time_stamp(5,j) = 0;
       end
   else
       Time_stamp(5,j) = Time_stamp(5,j);
   end
       
   if Time_stamp(6,j) == 0
       if (Sim1{1,i+1}(17,j) > Sim1{1,i+1}(1,j)>1) & Sim1{1,i+1}(4,j) > meter(6000) & Sim1{1,i+1}(4,j) < meter(15000) %& Sim1{1,i+1}(26,j) > nm(30) & Sim1{1,i+1}(26,j) < nm(75) & (Sim1{1,i+1}(27,j) == 9 | Sim1{1,i+1}(27,j) == 10 | Sim1{1,i+1}(27,j) == 15); % Terminal South (TS)
           Time_stamp(6,j) = i+1;
       else
           Time_stamp(6,j) = 0;
       end
   else
       Time_stamp(6,j) = Time_stamp(6,j);
   end        
   
   if Time_stamp(7,j) == 0
       if (Sim1{1,i+1}(17,j) > Sim1{1,i+1}(1,j)>1) & Sim1{1,i+1}(4,j) > meter(2500) & Sim1{1,i+1}(4,j) < meter(6000) %& Sim1{1,i+1}(26,j) > nm(12) & Sim1{1,i+1}(26,j) < nm(30) & (Sim1{1,i+1}(27,j) == 1 | Sim1{1,i+1}(27,j) == 2 | Sim1{1,i+1}(27,j) == 3 | Sim1{1,i+1}(27,j) == 4 | Sim1{1,i+1}(27,j) == 5 | Sim1{1,i+1}(27,j) == 6 | Sim1{1,i+1}(27,j) == 7 | Sim1{1,i+1}(27,j) == 11 | Sim1{1,i+1}(27,j) == 12 | Sim1{1,i+1}(27,j) == 13); % Arrival North (AN)
           Time_stamp(7,j) = i+1;
       else
           Time_stamp(7,j) = 0;
       end
   else
       Time_stamp(7,j) = Time_stamp(7,j);
   end
   
   if Time_stamp(8,j) == 0
       if (Sim1{1,i+1}(17,j) > Sim1{1,i+1}(1,j)>1) & Sim1{1,i+1}(4,j) > meter(2500) & Sim1{1,i+1}(4,j) < meter(6000) %& Sim1{1,i+1}(26,j) > nm(12) & Sim1{1,i+1}(26,j) < nm(30) & (Sim1{1,i+1}(27,j) == 7 || Sim1{1,i+1}(27,j) == 8 || Sim1{1,i+1}(27,j) == 9 || Sim1{1,i+1}(27,j) == 10 || Sim1{1,i+1}(27,j) == 13 || Sim1{1,i+1}(27,j) == 14 || Sim1{1,i+1}(27,j) == 15); % Arrival East (AE)
           Time_stamp(8,j) = i+1;
       else
           Time_stamp(8,j) = 0;
       end
   else
       Time_stamp(8,j) = Time_stamp(8,j);
   end
   
    Time_stamp(9,j) = Time_stamp(4,j)-Time_stamp(1,j) ;
    Time_stamp(10,j) = Time_stamp(5,j)-Time_stamp(2,j) ;
    Time_stamp(11,j) = Time_stamp(4,j)-Time_stamp(2,j) ;
    Time_stamp(12,j) = Time_stamp(7,j)-Time_stamp(4,j) ;
    Time_stamp(13,j) = Time_stamp(7,j)-Time_stamp(5,j) ;
  end
end