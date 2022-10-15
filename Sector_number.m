
[sct_no] = cellfun(@sector_no,Sim1);
vector_sectornoArray1 = [sct_no'];
%vector_acinsectorArray1 = movmedian(vector_acinsectorArray1,5);
A1 = vector_sectornoArray1;



plot(A1,'r')       
 xlim([0 t])
 ylim([0 10])
 xlabel('time')
 ylabel('Sector No')
 title("Sector No")  


% hold on

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
