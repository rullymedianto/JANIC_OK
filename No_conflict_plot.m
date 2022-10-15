[conflict_num1, conflict_num2, conflict_num3, conflict_num4] = cellfun(@number_of_conflict,Sim1);
[acin1, acin2, acin3, acin4] = cellfun(@vector_acinsector1,Sim1);

vector_conflictnoArray1 = [conflict_num1', conflict_num2', conflict_num3', conflict_num4'];
Vector_aircraft_in_Sector = [acin1', acin2', acin3', acin4'];

x1 =linspace(1,time+1,time+1); 

A1 = vector_conflictnoArray1(:,1);
A2 = vector_conflictnoArray1(:,2);
A3 = vector_conflictnoArray1(:,3);
A4 = vector_conflictnoArray1(:,4);
S1 = Vector_aircraft_in_Sector (:,1);
S2 = Vector_aircraft_in_Sector (:,2);
S3 = Vector_aircraft_in_Sector (:,3);
S4 = Vector_aircraft_in_Sector (:,4);

% plot(x1',A1,'b', x1',A2,'r',x1',A3,'c',x1',A4,'g',x1',S1,'b', x1',S2,'r',x1',S3,'c',x1',S4,'g') 

f1= figure; 
f2 = figure;
% 
% figure(f1);
% plot(x1',A1,'b', x1',A2,'r',x1',A3,'c',x1',A4,'g')
% xlim([0 t])
%  ylim([0 50])
%  xlabel('time')
%  ylabel('Conflict No')
%  title("Conflict No")  
% 
% figure(f2);
% plot(x1',S1,'b', x1',S2,'r',x1',S3,'c',x1',S4,'g')
%  
% xlim([0 t])
%  ylim([0 50])
%  xlabel('time')
%  ylabel('Aircraft')
%  title("AIrcrfat in Sector")  

average_acAPP = mean(S3)
max_acAPP = max(S3)
average_conAPP = mean(A3)
max_conAPP = max(A3)

% hold on
% plot(CA2,'b')
% plot(CA3,'g')
% plot(CA4,'c')
% plot(CA5,'y')
% plot(CA6,'r')
% plot(CA7,'r')
% plot(CA8,'r')
% 
% hold off
% timeElapsed_Vector_Complexity = toc;
% 
% %saveas (plotnumofcomplexity2,'Air_Traffic_Complexity.jpg');         
% save('Complexity_.mat', 'CATOT') 
