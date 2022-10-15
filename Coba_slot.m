time = 100;
airplane = 5;
COMCTR = cell(1,time);
matrix =zeros (100);
matrix (10,1)=1;
% matrix (20,2)=2;
matrix (23,3)=3;
matrix (24,3)=4;


for i = 1:time
    for j = 1:airplane
        
 if matrix (i,j) == 1 %i == 10 && j== 1 
   COMCTR{1,i+1}(1,j)= 1; % Enter sector  Check
else
   COMCTR{1,i+1}(1,j)= 0;
end

% if matrix (i,j) == 2 %i == 23 && j == 3
%    COMCTR{1,i+1}(2,j)= 1; % Radar vector
% else
%    COMCTR{1,i+1}(2,j)= 0;
% end

if matrix (i,j) == 3 %i == 16 && j== 2
   COMCTR{1,i+1}(3,j)= 1; % Exit sector  Check
else
   COMCTR{1,i+1}(3,j)= 0;
end

if matrix (i,j) == 4%i == 16 && j== 2
   COMCTR{1,i+1}(3,j)= 1; % Exit sector  Check
else
   COMCTR{1,i+1}(3,j)= 0;
end


if i==1
COMCTR{1,i}(4,j)= 0; % Slot time for Communication time in TS
end

if COMCTR{1,i}(1,1)== 1 %&& slot1(1,i)==0
    COMCTR{1,i+1}(4,j)= 1;
    tcin5 = 16;
elseif COMCTR{1,i}(4,j)== 1 && tcin5>0 %&& slot(1,i)==1 
    tcin5 = tcin5-1;
    COMCTR{1,i+1}(4,j)= 1;
%  elseif COMCTR{1,i}(4,j)== 1 && tcin5==1 %&& slot(1,i)==1 
%  COMCTR{1,i+1}(4,j)= 0;
%  tcin5 = 0;
else
    COMCTR{1,i+1}(4,j)= 0;
 end
 
  if COMCTR{1,i}(2,j)== 1 %&& slot(1,i)==0
     COMCTR{1,i+1}(4,j)= 1;
     tcout5 = 14;
 elseif COMCTR{1,i}(4,j)== 1 && tcout5>0 %&& slot(1,i)==1 
     tcout5 = tcout5-1;
     COMCTR{1,i+1}(4,j)= 1;
%  elseif COMCTR{1,i}(4,j)== 1 && tcout5==1 %&& slot(1,i)==1 
%  COMCTR{1,i+1}(4,j)= 0;
%  tcout5 = 0;
 else
     COMCTR{1,i+1}(4,j)= 0;
 end
  
  if COMCTR{1,i}(3,j)== 1 %&& slot(1,i)==0
     COMCTR{1,i+1}(4,j)= 1;
     tcout5 = 14;
 elseif COMCTR{1,i}(4,j)== 1 && tcout5>0 %&& slot(1,i)==1 
     tcout5 = tcout5-1;
     COMCTR{1,i+1}(4,j)= 1;
%  elseif COMCTR{1,i}(4,j)== 1 && tcout5==1 %&& slot(1,i)==1 
%  COMCTR{1,i+1}(4,j)= 0;
%  tcout5 = 0;
 else
     COMCTR{1,i+1}(4,j)= 0;
 end
  
    end
end